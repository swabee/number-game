// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_game/constant/app_constants.dart';
import 'package:number_game/constant/app_level_condition.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/custom/scafold_custom.dart';
import 'package:number_game/custom/text_custom.dart';
import 'package:number_game/features/app_data/data/models/app_data_model.dart';
import 'package:number_game/features/app_data/presentation/bloc/app_data_bloc.dart';
import 'package:number_game/features/app_data/presentation/widgets/home_settings_dialouge.dart';
import 'package:number_game/features/game_home/presentation/widgets/game_screen_bottm_bar_custom.dart';
import 'package:number_game/features/game_home/presentation/widgets/shake_number_widget.dart';
import 'package:number_game/features/game_session/presentation/cubit/game_session_cubit.dart';

class GamePlaySessionScreen extends StatefulWidget {
  const GamePlaySessionScreen({super.key});

  @override
  State<GamePlaySessionScreen> createState() => _GamePlaySessionScreenState();
}

class _GamePlaySessionScreenState extends State<GamePlaySessionScreen> {
  late GameSessionCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = context.read<GameSessionCubit>();
  }

  @override
  void dispose() {
    _cubit.end(_cubit.state.currentGame!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      darkenBg: true,
      bgimagePath: 'asset/images/scafold_main_bg.gif',
      body: BlocBuilder<GameSessionCubit, GameSessionState>(
        builder: (context, gamesessionstate) {
          if (gamesessionstate.currentGame != null) {
            return Column(
              children: [
                SizedBox(height: 60.h),
                // Custom app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContainerCustom(
                      callback: () {
                        if (!gamesessionstate.currentGame!.isDailyChallenge) {
                          Navigator.pop(context);
                        }
                      },
                      marginLeft: 10.w,
                      height: 55.h,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.amber,
                        size: 25.sp,
                      ),
                    ),
                    ContainerCustom(
                      marginRight: 10.w,
                      height: 55.h,
                      child: TextCustomWidget(
                        text: gamesessionstate.currentGame!.currentScore
                            .toString(),
                        textStyle: GoogleFonts.fredoka(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(255, 236, 175, 21),
                        ),
                      ),
                    ),
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
                if (gamesessionstate.currentGame!.isDailyChallenge)
                  ContainerCustom(
                    marginRight: 15.w,
                    marginLeft: 15.w,
                    marginTop: 20.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomWidget(
                          containerAlignment: Alignment.center,
                          text: formatTime(
                              gamesessionstate.currentGame!.timeRemaining),
                          textStyle: GoogleFonts.fredoka(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromARGB(255, 236, 175, 21),
                          ),
                        ),
                        TextCustomWidget(
                          containerAlignment: Alignment.center,
                          text: (gamesessionstate.currentGame!.levelType == 1)
                              ? ' ${gamesessionstate.currentGame!.currentScore} / ${AppLevelCondition().level1pointNeeded}'
                              : (gamesessionstate.currentGame!.levelType == 2)
                                  ? ' ${gamesessionstate.currentGame!.currentScore} / ${AppLevelCondition().level2pointNeeded}'
                                  : ' ${gamesessionstate.currentGame!.currentScore} / ${AppLevelCondition().level3pointNeeded}',
                          textStyle: GoogleFonts.fredoka(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 236, 175, 21),
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: GridView.builder(
                    itemCount: gamesessionstate.numbers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gamesessionstate.rowLength,
                      crossAxisSpacing: 0.sp,
                      mainAxisSpacing: 0.sp,
                    ),
                    itemBuilder: (context, index) {
                      final num = gamesessionstate.numbers[index];
                      final isSelected =
                          gamesessionstate.selected.contains(index);
                      final isHint = gamesessionstate.hintPair.contains(index);
                      final isMatched =
                          gamesessionstate.matched.contains(index);

                      return GestureDetector(
                        onTap: (num == null || isMatched)
                            ? null
                            : () async {
                                await checkHeighScore(
                                    gamesessionstate.currentGame!.currentScore +
                                        2);
                                context
                                    .read<GameSessionCubit>()
                                    .toggleSelection(
                                        index: index,
                                        build: context,
                                        currentScore: gamesessionstate
                                            .currentGame!.currentScore,
                                        isDailyChallenge:
                                            gamesessionstate
                                                .currentGame!.isDailyChallenge,
                                        requiredScore: AppLevelCondition()
                                            .getPointsNeeded(gamesessionstate
                                                .currentGame!.levelType)
                                            .toDouble());
                              },
                        child: ContainerCustom(
                          border: Border.all(
                            color: const Color.fromARGB(255, 182, 161, 230),
                          ),
                          bgColor: isSelected
                              ? Colors.greenAccent
                              : isHint
                                  ? const Color.fromARGB(255, 106, 81, 164)
                                  : primaryColor.withOpacity(.5),
                          child: Center(
                            child: ShakeNumberWidget(
                              shake:
                                  gamesessionstate.invalidPair.contains(index),
                              child: Text(
                                num.toString(),
                                style: GoogleFonts.fredoka(
                                  fontSize: 29.sp,
                                  fontWeight: FontWeight.w800,
                                  color: (num == null)
                                      ? Colors.transparent
                                      : isMatched
                                          ? getColorForNumber(num)
                                              .withOpacity(0.25)
                                          : getColorForNumber(num),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GameScreenBottmBarCustom(
                  onaddNewRow: () {},
                  onHintClick: () {},
                ),
              ],
            );
          }
          return ContainerCustom();
        },
      ),
    );
  }

  Future<void> checkHeighScore(double currentScore) async {
    final state = context.read<AppDataBloc>().state;
    if (state is AppDataLoaded && state.appDataEntity.bestScore == 0) {
      final updateModel = AppDataModel(
          totalHindBalance: 5.0,
          soundPermissionEnabled: true,
          notificationPermissionEnabled: false,
          bestScore: currentScore,
          lastRewardTakenLevel: 0);
      context.read<AppDataBloc>().add(AppDataUpdateEvent(updateModel));
    } else if (state is AppDataLoaded &&
        state.appDataEntity.bestScore <= currentScore) {
      final updateModel = state.appDataEntity.copyWith(bestScore: currentScore);
      context
          .read<AppDataBloc>()
          .add(AppDataUpdateEvent(updateModel.toModel()));
    }
  }
}
