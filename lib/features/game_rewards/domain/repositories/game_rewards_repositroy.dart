import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_rewards/data/models/reward_data_model.dart';
import 'package:number_game/features/game_rewards/domain/entities/reward_data_entity.dart';

abstract class GameRewardsRepositroy {
 Future<Either<Failure,List<RewardDataEntity>>> fetchAllGameRewardHistory();
 Future<Either<Failure,Unit>> updateGameRewardHistory(RewardDataModel rewardData);
}