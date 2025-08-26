import 'package:get_it/get_it.dart';
import 'package:number_game/backend/hive_storage_service.dart';
import 'package:number_game/features/app_data/data/datasources/app_data_local_data_source.dart';
import 'package:number_game/features/app_data/data/repositories/app_data_repository_impl.dart';
import 'package:number_game/features/app_data/domain/repositories/app_data_repository.dart';
import 'package:number_game/features/app_data/domain/usecases/get_app_data_usecase.dart';
import 'package:number_game/features/app_data/domain/usecases/update_app_data_usecase.dart';
import 'package:number_game/features/game_daily_task/data/datasources/daily_game_local_data_source.dart';
import 'package:number_game/features/game_daily_task/data/repositories/daily_game_repository_impl.dart';
import 'package:number_game/features/game_daily_task/domain/repositories/daily_game_repositroy.dart';
import 'package:number_game/features/game_daily_task/domain/usecases/get_daily_game_history_usecase.dart';
import 'package:number_game/features/game_rewards/data/datasources/game_rewards_local_data_source.dart';
import 'package:number_game/features/game_rewards/data/repositories/game_reward_repositroy_impl.dart';
import 'package:number_game/features/game_rewards/domain/repositories/game_rewards_repositroy.dart';
import 'package:number_game/features/game_rewards/domain/usecases/fetch_all_game_reward_history_usecase.dart';
import 'package:number_game/features/game_rewards/domain/usecases/update_game_reward_history_usecase.dart';
import 'package:number_game/features/game_session/data/datasources/game_local_data_source.dart';
import 'package:number_game/features/game_session/data/repositories/game_data_repositroy_impl.dart';
import 'package:number_game/features/game_session/domain/repositories/game_data_repository.dart';
import 'package:number_game/features/game_session/domain/usecases/end_game_session_usecase.dart';
import 'package:number_game/features/game_session/domain/usecases/get_last_game_session_usecase.dart';
import 'package:number_game/features/game_session/domain/usecases/start_game_session_usecase.dart';

final locator = GetIt.instance;

/// Updated method: now supports lazy factories + optional instance names
Future<void> setupLocator() async {
//local storage
  registerLazySingleton<HiveStorageService>(
    HiveStorageService(),
  );
  // game session
  registerLazySingleton<GameLocalDataSource>(
    GameLocalDataSourceImpl(),
  );

  registerLazySingleton<GameDataRepository>(
    GameDataRepositoryImpl(
      locator<GameLocalDataSource>(),
    ),
  );

  registerLazySingleton(
    StartGameSessionUsecase(
      locator<GameDataRepository>(),
    ),
  );
  registerLazySingleton(
    GetLastGameSessionUsecase(
      locator<GameDataRepository>(),
    ),
  );
  registerLazySingleton(
    EndGameSessionUsecase(
      locator<GameDataRepository>(),
    ),
  );

  //game history

  registerLazySingleton<DailyGameLocalDataSource>(
    DailyGameLocalDataSourceImpl(),
  );

  registerLazySingleton<DailyGameRepositroy>(
    DailyGameRepositoryImpl(
      localDataSource: locator<DailyGameLocalDataSource>(),
    ),
  );

  registerLazySingleton(
    GetDailyGameHistoryUsecase(
      repositroy: locator<DailyGameRepositroy>(),
    ),
  );

  // app data
  registerLazySingleton<AppDataLocalDataSource>(
    AppDataLocalDataSourceImpl(),
  );

  registerLazySingleton<AppDataRepository>(
    AppDataRepositoryImpl(
      localDataSource: locator<AppDataLocalDataSource>(),
    ),
  );

  registerLazySingleton(
    GetAppDataUsecase(
      repository: locator<AppDataRepository>(),
    ),
  );

  registerLazySingleton(
    UpdateAppDataUsecase(
      repository: locator<AppDataRepository>(),
    ),
  );

    // Game rewards
  registerLazySingleton<GameRewardsLocalDataSource>(
   GameRewardsLocalDataSourceImpl(),
  );

  registerLazySingleton<GameRewardsRepositroy>(
   GameRewardRepositroyImpl(
     dataSource:  locator<GameRewardsLocalDataSource>(),
    ),
  );

  registerLazySingleton(
   FetchAllGameRewardHistoryUsecase(
      repositroy: locator<GameRewardsRepositroy>(),
    ),
  );

  registerLazySingleton(
   UpdateGameRewardHistoryUsecase(
      repositroy: locator<GameRewardsRepositroy>(),
    ),
  );
}

void registerLazySingleton<T extends Object>(T object) {
  return locator.registerLazySingleton<T>(() => object);
}
