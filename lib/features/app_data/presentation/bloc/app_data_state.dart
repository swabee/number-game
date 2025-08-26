part of 'app_data_bloc.dart';

abstract class AppDataState extends Equatable {
  const AppDataState();  

  @override
  List<Object> get props => [];
}
class AppDataInitial extends AppDataState {}

class AppDataLoding extends AppDataState{}
final class AppDataLoaded extends AppDataState {
  const AppDataLoaded(this.appDataEntity);
  final AppDataEntity appDataEntity;

  @override
  List<Object> get props => [appDataEntity];
}

final class AppDataFetchError extends AppDataState{
  const AppDataFetchError(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}

