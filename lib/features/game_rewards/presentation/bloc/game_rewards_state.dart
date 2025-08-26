part of 'game_rewards_bloc.dart';

abstract class GameRewardsState extends Equatable {
  const GameRewardsState();  

  @override
  List<Object> get props => [];
}

class GameRewardsInitial extends GameRewardsState {}
class GameRewardsLoding extends GameRewardsState{}


final class GameRewardsLoaded extends GameRewardsState {
  const GameRewardsLoaded(this.gamerewards);
    final List<RewardDataEntity> gamerewards;

  @override
  List<Object> get props => [gamerewards];
}

final class GameRewardsFetchError extends GameRewardsState{
  const GameRewardsFetchError(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}

