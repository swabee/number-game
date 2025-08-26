import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/app_data/data/models/app_data_model.dart';
import 'package:number_game/features/app_data/domain/repositories/app_data_repository.dart';
import 'package:number_game/utils/usecase.dart';

class UpdateAppDataUsecase extends UseCase<Unit, UpdateAppDataParams> {
  final AppDataRepository repository;
  UpdateAppDataUsecase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(UpdateAppDataParams params) {
    return repository.updateAppData(params.appDataModel);
  }
}

class UpdateAppDataParams {
  final AppDataModel appDataModel;
  UpdateAppDataParams({required this.appDataModel});
}
