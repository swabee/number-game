import 'package:dartz/dartz.dart';
import 'package:number_game/errors/exceptions.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_session/data/datasources/game_local_data_source.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';
import 'package:number_game/features/game_session/domain/repositories/game_data_repository.dart';

class GameDataRepositoryImpl implements GameDataRepository {
  final GameLocalDataSource localDataSource;

  GameDataRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Unit>> endGame(GameDataModel game) async {
    try {
       await localDataSource.saveGame(game);
     return Right(unit);
    } on HiveException catch (e) {
      return Left(HIveFailure(e.errorResponseModel));
    }
  }

@override
Future<Either<Failure, GameDataEntity?>> getLastGame() async {
  try {
    final model = await localDataSource.getLastGame();
    return Right(model!); 
  }  on HiveException catch (e) {
      return Left(HIveFailure(e.errorResponseModel));
    }
}

  @override
  Future<Either<Failure, Unit>> startGame(GameDataModel game) async {
    try {
      await localDataSource.saveGame(game);

      return Right(unit);
    } on HiveException catch (e) {
      return Left(HIveFailure(e.errorResponseModel));
    }
  }

  // @override
  // Future<void> startGame(GameDataEntity game) async {
  // await localDataSource.saveGame(GameDataModel(
  //   id = game.id,
  //   date = game.date,
  //   levelType = game.levelType,
  //   isDailyChallenge = game.isDailyChallenge,
  //   currentScore = game.currentScore,
  //   timeRemaining = game.timeRemaining,
  //   addRowUsed = game.addRowUsed,
  //   hasCompleted = game.hasCompleted,
  //   totalScore = game.totalScore,
  // ));
  // }

  // @override
  // Future<GameDataEntity?> getLastGame() async {
  //   return await localDataSource.getLastGame();
  // }

  // @override
  // Future<void> endGame(GameDataEntity game) async {
    // await localDataSource.saveGame(GameDataModel(
    //   id = game.id,
    //   date = game.date,
    //   levelType = game.levelType,
    //   isDailyChallenge = game.isDailyChallenge,
    //   currentScore = game.currentScore,
    //   timeRemaining = game.timeRemaining,
    //   addRowUsed = game.addRowUsed,
    //   hasCompleted = game.hasCompleted,
    //   totalScore = game.totalScore,
    // ));
  // }
}
