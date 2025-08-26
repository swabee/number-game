import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_game/custom/scafold_custom.dart';
import 'package:number_game/features/app_data/presentation/bloc/app_data_bloc.dart';
import 'package:number_game/features/game_daily_task/presentation/bloc/game_daily_task_bloc.dart';
import 'package:number_game/features/game_rewards/presentation/bloc/game_rewards_bloc.dart';

class GameJourneyPage extends StatelessWidget {
  const GameJourneyPage({super.key});

  String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      darkenBg: true,
      bgimagePath: 'asset/images/scafold_main_bg.gif',
      body: BlocBuilder<GameDailyTaskBloc, GameDailyTaskState>(
        builder: (context, dailyTaskState) {
          return BlocBuilder<GameRewardsBloc, GameRewardsState>(
            builder: (context, rewardsState) {
              if (rewardsState is GameRewardsLoaded &&
                  dailyTaskState is GameDailyTaskLoaded) {
                final rewards = rewardsState.gamerewards;

                return ListView(
                  padding: EdgeInsets.only(top: 70.h, left: 16, right: 16),
                  children: [
                    // 🔹 Reward History ONLY
                    Text(
                      "🏆 Reward History",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    if (rewards.isEmpty)
                      Center(
                        child: Text(
                          "No rewards collected yet!",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                      )
                    else
                      ...rewards.map(
                        (reward) => GestureDetector(
                          onTap: () {
                            if (!reward.hasCollected) {
                              final appState =
                                  context.read<AppDataBloc>().state;
                              if (appState is AppDataLoaded) {
                                final appModel = appState.appDataEntity
                                    .copyWith(
                                        totalHindBalance: appState.appDataEntity
                                                .totalHindBalance +
                                            reward.hintCount.toDouble());

                                //update total hint
                                context.read<AppDataBloc>().add(
                                    AppDataUpdateEvent(appModel.toModel()));
                                //
                                context.read<GameRewardsBloc>().add(
                                    GameRewardsCollectedEvent(
                                        reward.toModel(), context));
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade800,
                                  Colors.grey.shade700
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                  color: (reward.hasCollected)
                                      ? Colors.grey
                                      : Colors.amber,
                                  width: 1.2),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.stars,
                                    color: (reward.hasCollected)
                                        ? Colors.grey
                                        : Colors.amber,
                                    size: 32),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reward Collected",
                                      style: TextStyle(
                                        color: (reward.hasCollected)
                                            ? Colors.grey
                                            : Colors.amberAccent,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Date: ${formatDate(reward.dailyChallengeRewardDate)}",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    Text(
                                      "Hints: ${reward.hintCount}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
