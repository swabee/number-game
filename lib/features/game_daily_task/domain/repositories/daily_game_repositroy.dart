import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';

abstract class DailyGameRepositroy {
  Future<Either<Failure,List<GameDataEntity>>> getAllGameHistory();
}