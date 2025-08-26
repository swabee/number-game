import 'package:dartz/dartz.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/game_rewards/domain/entities/reward_data_entity.dart';
import 'package:number_game/features/game_rewards/domain/repositories/game_rewards_repositroy.dart';
import 'package:number_game/utils/usecase.dart';

class FetchAllGameRewardHistoryUsecase extends UseCase<List<RewardDataEntity>,NoParams> {
  FetchAllGameRewardHistoryUsecase({required this.repositroy});
  final GameRewardsRepositroy repositroy;

  @override
  Future<Either<Failure, List<RewardDataEntity>>> call(NoParams params) {
     return repositroy.fetchAllGameRewardHistory();
  }
 
}