import 'package:number_game/backend/hive_storage_service.dart';
import 'package:number_game/features/game_rewards/data/models/reward_data_model.dart';
import 'package:number_game/service_locator/service_locator.dart';

abstract class GameRewardsLocalDataSource {
  Future<List<RewardDataModel>> fetchAllGameRewardHistory();
  Future<void> updateGameRewardHistory(RewardDataModel rewardData);
}

class GameRewardsLocalDataSourceImpl extends GameRewardsLocalDataSource {
  final HiveStorageService storageService = locator<HiveStorageService>();

  final String boxName = 'reward_history_box';
  @override
  Future<List<RewardDataModel>> fetchAllGameRewardHistory() async {
    final all = await storageService.getAllJson(boxName);
    if (all.isEmpty) return [];
    return all.map((json) => RewardDataModel.fromJson(json)).toList();
  }

  @override
  Future<void> updateGameRewardHistory(RewardDataModel rewardData) async {
    await storageService.saveJson(boxName, rewardData.id, rewardData.toJson());
  }
}
