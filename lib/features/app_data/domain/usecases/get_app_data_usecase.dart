import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/app_data/domain/entities/app_data_entity.dart';
import 'package:number_game/features/app_data/domain/repositories/app_data_repository.dart';
import 'package:number_game/utils/usecase.dart';

class GetAppDataUsecase extends UseCase<AppDataEntity,NoParams> {
  final AppDataRepository repository;
  GetAppDataUsecase({required this.repository});

  @override
  Future<Either<Failure, AppDataEntity>> call(NoParams params) {
        return repository.fetchAppData();
  }
 
}