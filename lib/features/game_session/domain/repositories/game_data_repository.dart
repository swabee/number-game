

import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';

abstract class GameDataRepository {
  // Future<void> startGame(GameDataEntity game);
  Future<Either<Failure,Unit>>startGame(GameDataModel game);
Future<Either<Failure,GameDataEntity?>>   getLastGame();
 Future<Either<Failure,Unit>> endGame(GameDataModel game);
}
