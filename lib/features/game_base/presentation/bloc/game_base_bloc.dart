import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_base_event.dart';
part 'game_base_state.dart';

class GameBaseBloc extends Bloc<GameBaseEvent, GameBaseState> {
  GameBaseBloc() : super(GameBaseInitial()) {
    on<GameBaseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
