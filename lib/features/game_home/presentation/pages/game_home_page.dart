import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/custom/scafold_custom.dart';
import 'package:number_game/features/app_data/data/models/app_data_model.dart';
import 'package:number_game/features/app_data/presentation/bloc/app_data_bloc.dart';
import 'package:number_game/features/app_data/presentation/widgets/home_best_score_tile.dart';
import 'package:number_game/features/app_data/presentation/widgets/home_settings_dialouge.dart';
import 'package:number_game/features/game_home/presentation/widgets/home_button_custom.dart';
import 'package:number_game/features/game_home/presentation/widgets/home_game_daily_challange_tile.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/features/game_session/presentation/cubit/game_session_cubit.dart';
import 'package:number_game/features/game_session/presentation/pages/game_play_session_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uuid/uuid.dart';

class GameHomePage extends StatelessWidget {
  const GameHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      darkenBg: true,
      bgimagePath: 'asset/images/scafold_main_bg.gif',
      body: SingleChildScrollView(
        child: BlocBuilder<GameSessionCubit, GameSessionState>(
          builder: (context, gameSessionState) {
            return Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                //custom appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ContainerCustom(
                    //   height: 55.h,
                    //   child: Image.asset('asset/icons/reward.png'),
                    // ),
                    ContainerCustom(
                      callback: () async {
                        final updatedData = await showDialog<AppDataModel>(
                          context: context,
                          builder: (context) => const HomeSettingsDialog(),
                        );

                        if (updatedData != null) {
                          context
                              .read<AppDataBloc>()
                              .add(AppDataUpdateEvent(updatedData));
                        }
                      },
                      marginRight: 10.w,
                      height: 55.h,
                      child: Image.asset('asset/icons/settings.png'),
                    )
                  ],
                ),

                SizedBox(
                  height: 70.h,
                ),
                ContainerCustom(
                  child: HomeGameDailyChallangeTile(),
                ),
                HomeBestScoreTile(),
                SizedBox(
                  height: 80.h,
                ),
                if (gameSessionState.currentGame != null &&
                    !gameSessionState.currentGame!.hasCompleted&&!gameSessionState.currentGame!.isDailyChallenge)
                  ZoomIn(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutBack,
                    child: HomeButtonCustom(
                      buttonName: 'Continue',
                      buttonTextColor: const Color.fromARGB(255, 5, 97, 4),
                      gradientColorOne: const Color.fromARGB(255, 17, 218, 7),
                      gradientColorTwo: const Color.fromARGB(255, 11, 133, 19),
                      onClick: () async {
                        await context
                            .read<GameSessionCubit>()
                            .start(gameSessionState.currentGame!.toModel());
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 600),
                            type: PageTransitionType.fade,
                            child: GamePlaySessionScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(
                  height: 20.h,
                ),
                ZoomIn(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                  child: HomeButtonCustom(
                    buttonName: 'New Game',
                    buttonTextColor: const Color.fromARGB(255, 90, 66, 7),
                    gradientColorOne: const Color.fromARGB(255, 236, 175, 21),
                    gradientColorTwo: const Color.fromARGB(255, 204, 148, 8),
                    onClick: () async {
                      final Uuid uuid = Uuid();
                      final newGameModel = GameDataModel(
                          id: uuid.v4(),
                          date: DateTime.now(),
                          levelType: 1,
                          isDailyChallenge: false,
                          currentScore: 0,
                          timeRemaining: 60,
                          addRowUsed: 7,
                          hasCompleted: false,
                          totalScore: 0);
                      await context
                          .read<GameSessionCubit>()
                          .start(newGameModel);

                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: GamePlaySessionScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
