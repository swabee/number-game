import 'package:number_game/backend/hive_storage_service.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/service_locator/service_locator.dart';

abstract class DailyGameLocalDataSource {
  Future<List<GameDataModel>> getAllGameHistory();
}
class DailyGameLocalDataSourceImpl extends DailyGameLocalDataSource{
    final HiveStorageService storageService = locator<HiveStorageService>();

  final String boxName = 'game_history_box';
   @override
  Future<List<GameDataModel>> getAllGameHistory() async {
    final all = await storageService.getAllJson(boxName);
    if (all.isEmpty) return [];
    return all.map((json) => GameDataModel.fromJson(json)).toList();
  }

}