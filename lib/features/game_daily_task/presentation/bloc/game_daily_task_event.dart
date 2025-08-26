part of 'game_daily_task_bloc.dart';

abstract class GameDailyTaskEvent extends Equatable {
  const GameDailyTaskEvent();

  @override
  List<Object> get props => [];
}

class FetchGameDailyTaskEvent extends GameDailyTaskEvent {}

class GameDailyTaskLoadedEvent extends GameDailyTaskEvent {
  const GameDailyTaskLoadedEvent(this.gameDailyHistory);
   final List<GameDataEntity> gameDailyHistory;

  @override
  List<Object> get props => [gameDailyHistory];
}

class ResetGameDailyTaskEvent extends GameDailyTaskEvent {}

class StartListeningToGameDailyTaskEvent extends GameDailyTaskEvent {}


