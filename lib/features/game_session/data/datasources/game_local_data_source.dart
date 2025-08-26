import 'package:number_game/backend/hive_storage_service.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/service_locator/service_locator.dart';

abstract class GameLocalDataSource {
  Future<void> saveGame(GameDataModel game);
  Future<GameDataModel?> getLastGame();
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  final HiveStorageService storageService = locator<HiveStorageService>();

  final String boxName = 'game_history_box';

  GameLocalDataSourceImpl();

  @override
  Future<void> saveGame(GameDataModel game) async {

    
    await storageService.saveJson(boxName, game.id, game.toJson());
  }

  @override
  Future<GameDataModel?> getLastGame() async {
    final all = await storageService.getAllJson(boxName);
    if (all.isEmpty) return null;
    final last = all.last;
    return GameDataModel.fromJson(last);
  }
}
