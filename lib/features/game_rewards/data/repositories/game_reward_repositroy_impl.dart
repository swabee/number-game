import 'package:dartz/dartz.dart';
import 'package:number_game/errors/exceptions.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_rewards/data/datasources/game_rewards_local_data_source.dart';
import 'package:number_game/features/game_rewards/data/models/reward_data_model.dart';
import 'package:number_game/features/game_rewards/domain/entities/reward_data_entity.dart';
import 'package:number_game/features/game_rewards/domain/repositories/game_rewards_repositroy.dart';

class GameRewardRepositroyImpl extends GameRewardsRepositroy {
  final GameRewardsLocalDataSource dataSource;
  GameRewardRepositroyImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<RewardDataEntity>>>
      fetchAllGameRewardHistory() async {
    try {
      final data = await dataSource.fetchAllGameRewardHistory();
      return Right(data);
    } on HiveException catch (e) {
      return Left(HIveFailure(e.errorResponseModel));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateGameRewardHistory(
      RewardDataModel rewardData) async {
    try {
      await dataSource.updateGameRewardHistory(rewardData);

      return Right(unit);
    } on HiveException catch (e) {
      return Left(HIveFailure(e.errorResponseModel));
    }
  }
}
