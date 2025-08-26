import 'package:dartz/dartz.dart';
import 'package:number_game/errors/exceptions.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/app_data/data/datasources/app_data_local_data_source.dart';
import 'package:number_game/features/app_data/data/models/app_data_model.dart';
import 'package:number_game/features/app_data/domain/entities/app_data_entity.dart';
import 'package:number_game/features/app_data/domain/repositories/app_data_repository.dart';

class AppDataRepositoryImpl extends AppDataRepository {
  AppDataLocalDataSource localDataSource;
  AppDataRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, AppDataEntity>> fetchAppData() async{
    try {
   final appData =  await  localDataSource.fetchAppData();
      return Right(appData); 
    } on HiveException catch (e) {
      return Left(HIveFailure(e.errorResponseModel));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAppData(AppDataModel appData)async {
      try {
      await localDataSource.updateAppData(appData);

      return Right(unit);
    } on HiveException catch (e) {
      return Left(HIveFailure(e.errorResponseModel));
    }
  }
}