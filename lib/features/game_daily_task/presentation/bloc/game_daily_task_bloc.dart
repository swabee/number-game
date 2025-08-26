import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_daily_task/domain/usecases/get_daily_game_history_usecase.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';
import 'package:number_game/service_locator/service_locator.dart';
import 'package:number_game/utils/usecase.dart';

part 'game_daily_task_event.dart';
part 'game_daily_task_state.dart';

class GameDailyTaskBloc extends Bloc<GameDailyTaskEvent, GameDailyTaskState> {
  GameDailyTaskBloc() : super(GameDailyTaskInitial()) {
    on<FetchGameDailyTaskEvent>(_onFetchGameDailyTaskEvent);
    on<GameDailyTaskLoadedEvent>(_onGameDailyTaskLoadedEvent);

  
    on<ResetGameDailyTaskEvent>(_onResetGameDailyTaskEvent);
    add(FetchGameDailyTaskEvent());
  }

  final GetDailyGameHistoryUsecase getGameDailyTaskHistoryUsecase =
      locator<GetDailyGameHistoryUsecase>();
  FutureOr<void> _onFetchGameDailyTaskEvent(
    FetchGameDailyTaskEvent event,
    Emitter<GameDailyTaskState> emit,
  ) async {
    emit(GameDailyTaskLoding());
    final result =
        await getGameDailyTaskHistoryUsecase.call(NoParams());

    result.fold(
      (failure) => emit(GameDailyTaskFetchError(failure)),
      (data) => add(GameDailyTaskLoadedEvent(data)),
    );
    return null;
  }

  FutureOr<void> _onGameDailyTaskLoadedEvent(
    GameDailyTaskLoadedEvent event,
    Emitter<GameDailyTaskState> emit,
  ) {
    emit(GameDailyTaskLoaded(event.gameDailyHistory));
  }


    FutureOr<void> _onResetGameDailyTaskEvent(
    ResetGameDailyTaskEvent edevent,
    Emitter<GameDailyTaskState> emit,
  ) {
    emit(GameDailyTaskInitial());
  }

}
