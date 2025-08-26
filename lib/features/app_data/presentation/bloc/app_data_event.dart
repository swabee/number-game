part of 'app_data_bloc.dart';

abstract class AppDataEvent extends Equatable {
  const AppDataEvent();

  @override
  List<Object> get props => [];
}

class FetchAppDataEvent extends AppDataEvent {}

class AppDataLoadedEvent extends AppDataEvent {
  const AppDataLoadedEvent(this.appDataEntity);
  final AppDataEntity appDataEntity;

  @override
  List<Object> get props => [appDataEntity];
}

class ResetAppDataEvent extends AppDataEvent {}

class StartListeningToAppDataEvent extends AppDataEvent {}


class AppDataUpdateEvent extends AppDataEvent {
  const AppDataUpdateEvent(this.appDataEntity);
  final AppDataModel appDataEntity;

  @override
  List<Object> get props => [appDataEntity];
}
