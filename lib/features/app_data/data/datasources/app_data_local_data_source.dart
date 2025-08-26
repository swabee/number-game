import 'package:number_game/backend/hive_storage_service.dart';
import 'package:number_game/features/app_data/data/models/app_data_model.dart';
import 'package:number_game/service_locator/service_locator.dart';

abstract class AppDataLocalDataSource {
  Future<AppDataModel> fetchAppData();
  Future<void> updateAppData(AppDataModel appData);
}
class AppDataLocalDataSourceImpl extends AppDataLocalDataSource{
    final HiveStorageService storageService = locator<HiveStorageService>();

  final String boxName = 'app_data_box';
  @override
  Future<AppDataModel> fetchAppData() async {
    final all = await storageService.getAllJson(boxName);
    if (all.isEmpty) return AppDataModel.empty;

    final last = all.last;
    try {
      return AppDataModel.fromJson(last);
    } catch (e) {
    
      return AppDataModel.empty;
    }
  }
  
  @override
  Future<void> updateAppData(AppDataModel appData)async {
    
      await storageService.saveJson(boxName, 'app_data', appData.toJson());
  }

}