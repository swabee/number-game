import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:number_game/features/app_data/presentation/bloc/app_data_bloc.dart';
import 'package:number_game/features/game_base/presentation/pages/game_base_page.dart';
import 'package:number_game/features/game_daily_task/presentation/bloc/game_daily_task_bloc.dart';
import 'package:number_game/features/game_rewards/presentation/bloc/game_rewards_bloc.dart';
import 'package:number_game/features/game_session/presentation/cubit/game_session_cubit.dart';
import 'package:number_game/service_locator/service_locator.dart';

void main() async {
  await Hive.initFlutter();
  await setupLocator();
  runApp(const NumberGame());
}

class NumberGame extends StatelessWidget {
  const NumberGame({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GameSessionCubit(),
          ),
          BlocProvider(
            create: (context) => GameDailyTaskBloc(),
          ),
          BlocProvider(
            create: (context) => AppDataBloc(),
          ),
          BlocProvider(
            create: (context) => GameRewardsBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: GameBasePage(),
        ),
      ),
    );
  }
}
