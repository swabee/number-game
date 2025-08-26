import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:number_game/constant/app_constants.dart';
import 'package:number_game/constant/app_level_condition.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/custom/text_custom.dart';
import 'package:number_game/features/game_daily_task/presentation/bloc/game_daily_task_bloc.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';
import 'package:number_game/features/game_session/presentation/cubit/game_session_cubit.dart';
import 'package:number_game/features/game_session/presentation/pages/game_play_session_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uuid/uuid.dart';

class HomeGameDailyChallangeTile extends StatelessWidget {
  const HomeGameDailyChallangeTile({super.key});

  String formatDate(DateTime date) {
    return DateFormat("MMMM d").format(date); // Example: August 23
  }

  @override
  Widget build(BuildContext context) {
    final Uuid uuid = const Uuid();

    return BlocBuilder<GameDailyTaskBloc, GameDailyTaskState>(
      builder: (context, state) {
        if (state is! GameDailyTaskLoaded) {
          return SizedBox(
            height: 250.h,
            width: 210.w,
            child: const Center(),
          );
        }

        // 🔹 Compute today's game from current state
        final todayGame = _getTodayGameFromState(state);

        return _buildTile(context, todayGame, uuid);
      },
    );
  }

  GameDataEntity _getTodayGameFromState(GameDailyTaskState state) {
    final currentDate = DateTime.now();
    final uuid = const Uuid();
    final levels = [3, 2, 1];

    if (state is GameDailyTaskLoaded) {
      final history = state.gameDailyHistory;

      for (var level in levels) {
        for (var game in history) {
          if (game.date.year == currentDate.year &&
              game.date.month == currentDate.month &&
              game.date.day == currentDate.day &&
              game.isDailyChallenge &&
              game.levelType == level) {
            return game;
          }
        }
      }
    }

    final conditions = AppLevelCondition();
    return GameDataEntity(
      id: uuid.v4(),
      date: currentDate,
      levelType: 1,
      isDailyChallenge: true,
      currentScore: 0,
      timeRemaining: conditions.getSecondsAvailable(1),
      addRowUsed: conditions.getAddRowsAvailable(1),
      hasCompleted: false,
      totalScore: 0,
    );
  }

  Widget _buildTile(BuildContext context, GameDataEntity todayGame, Uuid uuid) {
    final currentDate = DateTime.now();

    return SizedBox(
      height: 250.h,
      width: 210.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 🔹 Background
          Transform.rotate(
            angle: -3.2,
            child: Container(
              height: 235.h,
              width: 195.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.r),
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade800,
                    Colors.deepPurple.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // 🔹 Foreground card
          Container(
            height: 230.h,
            width: 190.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
                 gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 208, 187, 245),
                        Color(0xFFF8F6FF),
                        Color(0xFFF8F6FF),
                        Color(0xFFF8F6FF),
                        Color(0xFFF8F6FF),
                        Color.fromARGB(255, 210, 192, 241)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(4, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🟧 Icon
                Container(
                  height: 50.r,
                  width: 50.r,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFC371), Color(0xFFFFA726)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Icon(Icons.calendar_month,
                      color: Colors.white, size: 28),
                ),
                SizedBox(height: 12.h),

                Text(
                  "Daily Challenges",
                  style: GoogleFonts.fredoka(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  formatDate(currentDate),
                  style: GoogleFonts.fredoka(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                SizedBox(height: 16.h),

                // 🎮 Play button or Completed text
                if (todayGame.levelType != 3 || todayGame.currentScore<AppLevelCondition().getPointsNeeded(todayGame.levelType))
                  ContainerCustom(
                    callback: () async {
                      final level = todayGame.levelType;
                      final conditions = AppLevelCondition();

                      final neededPoints = conditions.getPointsNeeded(level);

                      GameDataEntity nextGame;

                      if (todayGame.currentScore >= neededPoints && level < 3) {
                        // Go to next level
                        nextGame = todayGame.copyWith(
                          id: uuid.v4(),
                          levelType: level + 1,
                          currentScore: 0,
                          timeRemaining:
                              conditions.getSecondsAvailable(level + 1),
                          addRowUsed: conditions.getAddRowsAvailable(level + 1),
                          hasCompleted: false,
                          totalScore: 0,
                        );
                      } else {
                        // Retry same level
                        nextGame = todayGame.copyWith(
                          currentScore: 0,
                          timeRemaining: conditions.getSecondsAvailable(level),
                          addRowUsed: conditions.getAddRowsAvailable(level),
                          hasCompleted: false,
                        );
                      }

                      await context
                          .read<GameSessionCubit>()
                          .start(nextGame.toModel());

                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: GamePlaySessionScreen(),
                        ),
                      );
                    },
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE040FB), Color(0xFF9C27B0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                    shadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 126, 17, 146),
                        blurRadius: .1.sp,
                        offset: const Offset(0, 4),
                        spreadRadius: 1.sp,
                      ),
                    ],
                    child: Center(
                      child: TextCustomWidget(
                        containerAlignment: Alignment.center,
                        text: "Play",
                        textStyle: GoogleFonts.fredoka(
                          color: const Color.fromARGB(255, 103, 25, 117),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                if (todayGame.levelType == 3 && todayGame.currentScore>=AppLevelCondition().getPointsNeeded(todayGame.levelType))
                  TextCustomWidget(
                    containerAlignment: Alignment.center,
                    text: 'Today challenge completed!',
                    textStyle: GoogleFonts.fredoka(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple.shade900,
                    ),
                  ),
              ],
            ),
          ),

          // ❗ Notification bubble
        if (todayGame.levelType != 3 || todayGame.currentScore<AppLevelCondition().getPointsNeeded(todayGame.levelType))
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ContainerCustom(
                  marginRight: 5.w,
                  marginBottom: 200.h,
                  height: 23.sp,
                  width: 23.sp,
                  borderRadius: BorderRadius.circular(50.sp),
                  gradient: const RadialGradient(
                    colors: [
                      Color.fromARGB(255, 202, 27, 14),
                      Color.fromARGB(255, 237, 18, 2),
                    ],
                    center: Alignment.center,
                  ),
                  child: TextCustomWidget(
                    text: '!',
                    fontWeight: FontWeight.bold,
                    containerAlignment: Alignment.center,
                    textColor: whiteColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

GameDataEntity getTodayGame(BuildContext context) {
  final state = context.read<GameDailyTaskBloc>().state;
  final currentDate = DateTime.now();
  final uuid = const Uuid();
  final levels = [3, 2, 1];

  if (state is GameDailyTaskLoaded) {
    final history = state.gameDailyHistory;

    for (var level in levels) {
      for (var game in history) {
        if (game.date.year == currentDate.year &&
            game.date.month == currentDate.month &&
            game.date.day == currentDate.day &&
            game.isDailyChallenge &&
            game.levelType == level) {
          return game;
        }
      }
    }
  }

  // If no game found → create fresh level 1
  final conditions = AppLevelCondition();
  return GameDataEntity(
    id: uuid.v4(),
    date: currentDate,
    levelType: 1,
    isDailyChallenge: true,
    currentScore: 0,
    timeRemaining: conditions.getSecondsAvailable(1),
    addRowUsed: conditions.getAddRowsAvailable(1),
    hasCompleted: false,
    totalScore: 0,
  );
}
