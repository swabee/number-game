part of 'game_base_bloc.dart';

abstract class GameBaseState extends Equatable {
  const GameBaseState();  

  @override
  List<Object> get props => [];
}
class GameBaseInitial extends GameBaseState {}
