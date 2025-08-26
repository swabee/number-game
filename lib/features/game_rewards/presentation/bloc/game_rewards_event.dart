part of 'game_rewards_bloc.dart';

abstract class GameRewardsEvent extends Equatable {
  const GameRewardsEvent();

  @override
  List<Object> get props => [];
}
class FetchGameRewardsEvent extends GameRewardsEvent {}

class GameRewardsLoadedEvent extends GameRewardsEvent {
  const GameRewardsLoadedEvent(this.gamerewards);
   final List<RewardDataEntity> gamerewards;

  @override
  List<Object> get props => [gamerewards];
}

class ResetGameRewardsEvent extends GameRewardsEvent {}

class StartListeningToGameRewardsEvent extends GameRewardsEvent {}

class GameRewardsUpdateEvent extends GameRewardsEvent {
  const GameRewardsUpdateEvent(this.rewardDate,this.context);
  final DateTime rewardDate;
  final BuildContext context;


  @override
  List<Object> get props => [rewardDate];
}


class GameRewardsCollectedEvent extends GameRewardsEvent {
  const GameRewardsCollectedEvent(this.rewardDataModel,this.context);

  final BuildContext context;
final RewardDataModel rewardDataModel;

  @override
  List<Object> get props => [rewardDataModel];
}


