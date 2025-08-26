import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_home_event.dart';
part 'game_home_state.dart';

class GameHomeBloc extends Bloc<GameHomeEvent, GameHomeState> {
  GameHomeBloc() : super(GameHomeInitial()) {
    on<GameHomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
