import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/app_data/data/models/app_data_model.dart';
import 'package:number_game/features/app_data/domain/entities/app_data_entity.dart';

abstract class AppDataRepository {
  Future<Either<Failure,AppDataEntity>> fetchAppData();
  Future<Either<Failure,Unit>> updateAppData(AppDataModel appData);
}