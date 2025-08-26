import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/features/game_session/domain/repositories/game_data_repository.dart';
import 'package:number_game/utils/usecase.dart';



class StartGameSessionUsecase extends UseCase<Unit,StartGameSessionParams>  {
  final GameDataRepository repository;
  StartGameSessionUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(StartGameSessionParams params) {
    return repository.startGame(params.gameDataModel);
  }

  

}
class StartGameSessionParams{
StartGameSessionParams({required this.gameDataModel});
  final GameDataModel gameDataModel;
}