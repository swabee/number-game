import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_rewards/data/models/reward_data_model.dart';
import 'package:number_game/features/game_rewards/domain/repositories/game_rewards_repositroy.dart';
import 'package:number_game/utils/usecase.dart';

class UpdateGameRewardHistoryUsecase extends UseCase<Unit,UpdateGameRewardHistoryParams> {
  UpdateGameRewardHistoryUsecase({required this.repositroy});
  final GameRewardsRepositroy repositroy;

  @override
  Future<Either<Failure, Unit>> call(UpdateGameRewardHistoryParams params) {
   return repositroy.updateGameRewardHistory(params.rewardDataModel);
  }
}

class UpdateGameRewardHistoryParams {
  final RewardDataModel rewardDataModel;
  UpdateGameRewardHistoryParams({required this.rewardDataModel});
}
