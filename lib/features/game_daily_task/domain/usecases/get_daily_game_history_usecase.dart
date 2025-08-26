import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_daily_task/domain/repositories/daily_game_repositroy.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';
import 'package:number_game/utils/usecase.dart';

class GetDailyGameHistoryUsecase extends UseCase<List<GameDataEntity>,NoParams> {
  final DailyGameRepositroy repositroy;
  GetDailyGameHistoryUsecase({required this.repositroy});
  @override
  Future<Either<Failure, List<GameDataEntity>>> call(NoParams params) {
    return repositroy.getAllGameHistory();
  }
}