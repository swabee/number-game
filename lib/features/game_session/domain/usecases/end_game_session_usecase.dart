import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/features/game_session/domain/repositories/game_data_repository.dart';
import 'package:number_game/utils/usecase.dart';


class EndGameSessionUsecase extends UseCase<Unit,EndGameSessionParams>  {
  final GameDataRepository repository;
 EndGameSessionUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(EndGameSessionParams params) {
    return repository.endGame(params.gameDataModel);
  }

 
}
class EndGameSessionParams{
EndGameSessionParams({required this.gameDataModel});
  final GameDataModel gameDataModel;
}