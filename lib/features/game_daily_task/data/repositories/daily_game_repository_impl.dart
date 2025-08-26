import 'package:dartz/dartz.dart';
import 'package:number_game/errors/exceptions.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_daily_task/data/datasources/daily_game_local_data_source.dart';
import 'package:number_game/features/game_daily_task/domain/repositories/daily_game_repositroy.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';

class DailyGameRepositoryImpl extends DailyGameRepositroy {
  final DailyGameLocalDataSource localDataSource;
  DailyGameRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<GameDataEntity>>> getAllGameHistory()async {
  try {
    final data = await localDataSource.getAllGameHistory();
    return Right(data); 
  }  on HiveException catch (e) {
      return Left(HIveFailure(e.errorResponseModel));
    }
}
}