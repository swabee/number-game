import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_rewards/data/models/reward_data_model.dart';
import 'package:number_game/features/game_rewards/domain/entities/reward_data_entity.dart';
import 'package:number_game/features/game_rewards/domain/usecases/fetch_all_game_reward_history_usecase.dart';
import 'package:number_game/features/game_rewards/domain/usecases/update_game_reward_history_usecase.dart';
import 'package:number_game/service_locator/service_locator.dart';
import 'package:number_game/utils/usecase.dart';
import 'package:uuid/uuid.dart';

part 'game_rewards_event.dart';
part 'game_rewards_state.dart';

class GameRewardsBloc extends Bloc<GameRewardsEvent, GameRewardsState> {
  GameRewardsBloc() : super(GameRewardsInitial()) {
    on<FetchGameRewardsEvent>(_onFetchGameRewardsEvent);
    on<GameRewardsLoadedEvent>(_onGameRewardsLoadedEvent);
    on<GameRewardsUpdateEvent>(_onGameRewardsUpdateEvent);
    on<GameRewardsCollectedEvent>(_onGameRewardsCollectedEvent);

    on<ResetGameRewardsEvent>(_onResetGameRewardsEvent);
    add(FetchGameRewardsEvent());
  }

  final FetchAllGameRewardHistoryUsecase fetchAllGameRewardHistoryUsecase =
      locator<FetchAllGameRewardHistoryUsecase>();

  final UpdateGameRewardHistoryUsecase updateGameRewardHistoryUsecase =
      locator<UpdateGameRewardHistoryUsecase>();
  FutureOr<void> _onFetchGameRewardsEvent(
    FetchGameRewardsEvent event,
    Emitter<GameRewardsState> emit,
  ) async {
    emit(GameRewardsLoding());
    final result = await fetchAllGameRewardHistoryUsecase.call(NoParams());

    result.fold(
      (failure) => emit(GameRewardsFetchError(failure)),
      (data) => add(GameRewardsLoadedEvent(data)),
    );
    return null;
  }

  FutureOr<void> _onGameRewardsLoadedEvent(
    GameRewardsLoadedEvent event,
    Emitter<GameRewardsState> emit,
  ) {
    emit(GameRewardsLoaded(event.gamerewards));
  }

  FutureOr<void> _onResetGameRewardsEvent(
    ResetGameRewardsEvent edevent,
    Emitter<GameRewardsState> emit,
  ) {
    emit(GameRewardsInitial());
  }

  FutureOr<void> _onGameRewardsUpdateEvent(
    GameRewardsUpdateEvent edevent,
    Emitter<GameRewardsState> emit,
  ) async {
    final Uuid uuid = Uuid();
    final random = Random();
    final hints = random.nextInt(3) + 1;

    final newModel = RewardDataModel(
        id: uuid.v4(),
        date: DateTime.now(),
        hintCount: hints,
        dailyChallengeRewardDate: edevent.rewardDate,
        hasCollected: false);
    final res = await updateGameRewardHistoryUsecase
        .call(UpdateGameRewardHistoryParams(rewardDataModel: newModel));

    res.fold(
      (failure) {
        emit(GameRewardsFetchError(failure));
      },
      (success) {
        add(FetchGameRewardsEvent());
      },
    );
  }

  FutureOr<void> _onGameRewardsCollectedEvent(
    GameRewardsCollectedEvent edevent,
    Emitter<GameRewardsState> emit,
  ) async {
    final newReward=edevent.rewardDataModel.copyWith(hasCollected: true);
    //
  final  res = await updateGameRewardHistoryUsecase.call(
        UpdateGameRewardHistoryParams(
            rewardDataModel: newReward.toModel()));
    res.fold(
      (l) {
        emit(GameRewardsFetchError(l));
      },
      (r) {
        add(FetchGameRewardsEvent());
        showDialog(
          context: edevent.context,
          barrierDismissible: false, // prevent manual tap to close
          builder: (context) {
            // Schedule auto-close after 2 sec
            Future.delayed(const Duration(seconds: 2), () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            });

            return AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: ContainerCustom(
                width: 300.w,
                height: 200.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'asset/images/success-popper.gif',
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        Text(
                          "🎉 Congratulations!",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "You got ${edevent.rewardDataModel.hintCount} hints 🎁",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
