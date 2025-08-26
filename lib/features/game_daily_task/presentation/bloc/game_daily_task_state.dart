part of 'game_daily_task_bloc.dart';

abstract class GameDailyTaskState extends Equatable {
  const GameDailyTaskState();  

  @override
  List<Object> get props => [];
}
class GameDailyTaskInitial extends GameDailyTaskState {}
class GameDailyTaskLoding extends GameDailyTaskState{}
final class GameDailyTaskLoaded extends GameDailyTaskState {
  const GameDailyTaskLoaded(this.gameDailyHistory);
  final List<GameDataEntity> gameDailyHistory;

  @override
  List<Object> get props => [gameDailyHistory];
}

final class GameDailyTaskFetchError extends GameDailyTaskState{
  const GameDailyTaskFetchError(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}

