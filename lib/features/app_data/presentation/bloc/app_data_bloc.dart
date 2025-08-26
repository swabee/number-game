import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_game/errors/failures.dart';
import 'package:number_game/features/app_data/data/models/app_data_model.dart';
import 'package:number_game/features/app_data/domain/entities/app_data_entity.dart';
import 'package:number_game/features/app_data/domain/usecases/get_app_data_usecase.dart';
import 'package:number_game/features/app_data/domain/usecases/update_app_data_usecase.dart';
import 'package:number_game/service_locator/service_locator.dart';
import 'package:number_game/utils/usecase.dart';

part 'app_data_event.dart';
part 'app_data_state.dart';

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  AppDataBloc() : super(AppDataInitial()) {
    on<FetchAppDataEvent>(_onFetchAppDataEvent);
    on<AppDataLoadedEvent>(_onAppDataLoadedEvent);

    on<AppDataUpdateEvent>(_onAppDataUpdateEvent);

    on<ResetAppDataEvent>(_onResetAppDataEvent);
    add(FetchAppDataEvent());
  }

  final GetAppDataUsecase getAppDataUsecase = locator<GetAppDataUsecase>();

  final UpdateAppDataUsecase updateAppDataUsecase =
      locator<UpdateAppDataUsecase>();

  FutureOr<void> _onFetchAppDataEvent(
    FetchAppDataEvent event,
    Emitter<AppDataState> emit,
  ) async {
    emit(AppDataLoding());
    final result = await getAppDataUsecase.call(NoParams());

    result.fold(
      (failure) => emit(AppDataFetchError(failure)),
      (data) => add(AppDataLoadedEvent(data)),
    );
    return null;
  }

  FutureOr<void> _onAppDataLoadedEvent(
    AppDataLoadedEvent event,
    Emitter<AppDataState> emit,
  ) {
    emit(AppDataLoaded(event.appDataEntity));
  }

  FutureOr<void> _onAppDataUpdateEvent(
    AppDataUpdateEvent event,
    Emitter<AppDataState> emit,
  ) async {
    final res = await updateAppDataUsecase
        .call(UpdateAppDataParams(appDataModel: event.appDataEntity));
    res.fold(
      (failure) {
        emit(AppDataFetchError(failure));
      },
      (success) {},
    );
    add(FetchAppDataEvent());
  }

  FutureOr<void> _onResetAppDataEvent(
    ResetAppDataEvent edevent,
    Emitter<AppDataState> emit,
  ) {
    emit(AppDataInitial());
  }
}
