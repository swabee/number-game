import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';
import 'package:number_game/features/game_session/domain/repositories/game_data_repository.dart';
import 'package:number_game/utils/usecase.dart';

class GetLastGameSessionUsecase extends  UseCase<GameDataEntity?,NoParams>{
  final GameDataRepository repository;
 GetLastGameSessionUsecase(this.repository);

  @override
  Future<Either<Failure, GameDataEntity?>> call(NoParams params) {
    return repository.getLastGame();
  }

 
}
