import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/features/game_daily_task/presentation/bloc/game_daily_task_bloc.dart';
import 'package:number_game/features/game_rewards/presentation/bloc/game_rewards_bloc.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';
import 'package:number_game/features/game_session/domain/usecases/end_game_session_usecase.dart';
import 'package:number_game/features/game_session/domain/usecases/get_last_game_session_usecase.dart';
import 'package:number_game/features/game_session/domain/usecases/start_game_session_usecase.dart';
import 'package:number_game/service_locator/service_locator.dart';
import 'package:number_game/utils/usecase.dart';

class GameSessionState extends Equatable {
  final GameDataEntity? currentGame;
  final bool loading;

  /// Board size
  final int rowLength;

  /// Game board numbers (null = empty)
  List<int?> numbers;

  /// Currently selected indexes
  final List<int> selected;

  /// Hint pair indexes
  List<int> hintPair;

  /// Invalid pair indexes (for shake animation)
  List<int> invalidPair;

  /// Matched (faded) indexes
  final Set<int> matched;

  GameSessionState({
    this.currentGame,
    this.loading = false,
    this.rowLength = 6,
    List<int?>? numbers,
    List<int>? selected,
    List<int>? hintPair,
    List<int>? invalidPair,
    Set<int>? matched,
  })  : numbers = numbers ?? [],
        selected = selected ?? [],
        hintPair = hintPair ?? [],
        invalidPair = invalidPair ?? [],
        matched = matched ?? {};

  GameSessionState copyWith({
    GameDataEntity? currentGame,
    bool? loading,
    int? rowLength,
    List<int?>? numbers,
    List<int>? selected,
    List<int>? hintPair,
    List<int>? invalidPair,
    Set<int>? matched,
  }) {
    return GameSessionState(
      currentGame: currentGame ?? this.currentGame,
      loading: loading ?? this.loading,
      rowLength: rowLength ?? this.rowLength,
      numbers: numbers ?? this.numbers,
      selected: selected ?? this.selected,
      hintPair: hintPair ?? this.hintPair,
      invalidPair: invalidPair ?? this.invalidPair,
      matched: matched ?? this.matched,
    );
  }

  @override
  List<Object?> get props => [
        currentGame,
        loading,
        rowLength,
        numbers,
        selected,
        hintPair,
        invalidPair,
        matched,
      ];
}

class GameSessionCubit extends Cubit<GameSessionState> {
  final StartGameSessionUsecase startGameUseCase =
      locator<StartGameSessionUsecase>();
  final GetLastGameSessionUsecase getLastGameUseCase =
      locator<GetLastGameSessionUsecase>();
  final EndGameSessionUsecase endGameUseCase = locator<EndGameSessionUsecase>();

  Timer? _timer;

  GameSessionCubit() : super(GameSessionState()) {
    loadLastGame();
    generateBoard();
  }

  Future<void> start(GameDataModel game) async {
    emit(state.copyWith(loading: true));
    generateBoard();
    await startGameUseCase.call(StartGameSessionParams(gameDataModel: game));
    if (game.isDailyChallenge) {
      _startTimer(game);
    }
    // _startTimer(game);

    emit(state.copyWith(currentGame: game, loading: false));
  }

  Future<void> saveGameData(GameDataModel game) async {
    await startGameUseCase
        .call(StartGameSessionParams(gameDataModel: game.toModel()));
  }

  Future<void> generateBoard() async {
    final random = Random();
    final newNumbers =
        List<int?>.generate(state.rowLength * state.rowLength, (i) {
      final row = i ~/ state.rowLength;
      // Fill only first 4 rows initially; rest empty
      if (row < 4) return random.nextInt(9) + 1;
      return null;
    });

    emit(state.copyWith(
      numbers: newNumbers,
      selected: [],
      hintPair: [],
      invalidPair: [],
      matched: {},
    ));
  }

  Future<void> loadLastGame() async {
    emit(state.copyWith(loading: true));
    final result = await getLastGameUseCase.call(NoParams());
    result.fold(
      (l) {},
      (lastGame) {
        if (!lastGame!.hasCompleted && lastGame.timeRemaining > 0) {
          _startTimer(lastGame);
        }

        emit(state.copyWith(currentGame: lastGame, loading: false));
      },
    );
    // final lastGame = await getLastGameUseCase.call(NoParams());
    // if (!lastGame.hasCompleted &&
    //     lastGame.timeRemaining > 0) {
    //   _startTimer(lastGame);
    // }

    // emit(state.copyWith(currentGame: lastGame, loading: false));
  }

  Future<void> end(GameDataEntity game) async {
    _timer?.cancel();
    emit(state.copyWith(loading: true));

    await endGameUseCase
        .call(EndGameSessionParams(gameDataModel: game.toModel()));

    emit(state.copyWith(currentGame: game, loading: false));
  }

  void _startTimer(GameDataEntity initialGame) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final current = state.currentGame ?? initialGame;

      if (current.isDailyChallenge && current.timeRemaining <= 0) {
        await end(current.copyWith(hasCompleted: true));
        timer.cancel();
        return;
      }

      final updated =
          current.copyWith(timeRemaining: current.timeRemaining - 1);

      await startGameUseCase
          .call(StartGameSessionParams(gameDataModel: updated.toModel()));

      emit(state.copyWith(currentGame: updated));
    });
  }

  bool isBlocked(int idx) {
    // blocked only if there's a value AND it's not a faded (matched) cell
    return state.numbers[idx] != null && !state.matched.contains(idx);
  }

  bool isNeighbor(int i, int j) {
    final rowI = i ~/ state.rowLength;
    final colI = i % state.rowLength;
    final rowJ = j ~/ state.rowLength;
    final colJ = j % state.rowLength;

    // same row
    if (rowI == rowJ) {
      final minCol = min(colI, colJ);
      final maxCol = max(colI, colJ);
      for (int c = minCol + 1; c < maxCol; c++) {
        final idx = rowI * state.rowLength + c;
        if (isBlocked(idx)) return false;
      }
      return true;
    }

    // same column
    if (colI == colJ) {
      final minRow = min(rowI, rowJ);
      final maxRow = max(rowI, rowJ);
      for (int r = minRow + 1; r < maxRow; r++) {
        final idx = r * state.rowLength + colI;
        if (isBlocked(idx)) return false;
      }
      return true;
    }

    // diagonal
    if ((rowI - rowJ).abs() == (colI - colJ).abs()) {
      final steps = (rowI - rowJ).abs();
      final rowStep = (rowJ - rowI) ~/ steps;
      final colStep = (colJ - colI) ~/ steps;
      for (int s = 1; s < steps; s++) {
        final checkRow = rowI + rowStep * s;
        final checkCol = colI + colStep * s;
        final idx = checkRow * state.rowLength + checkCol;
        if (isBlocked(idx)) return false;
      }
      return true;
    }

    return false;
  }

  bool canMatch(int a, int b) => a == b || a + b == 10;

  void tryMatch(
      {required BuildContext build,
      required double requiredScore,
      required double currentScore,
      required bool isDailyChallenge}) async {
    if (state.selected.length < 2) return;

    final i = state.selected[0];
    final j = state.selected[1];

    if (state.matched.contains(i) || state.matched.contains(j)) {
      emit(state.copyWith(selected: []));
      return;
    }

    final ni = state.numbers[i];
    final nj = state.numbers[j];
    final newMatched = Set<int>.from(state.matched);
    List<int> newInvalid = [];

    if (ni != null && nj != null && isNeighbor(i, j) && canMatch(ni, nj)) {
      newMatched.addAll([i, j]);
      emit(state.copyWith(
        currentGame: state.currentGame!
            .copyWith(currentScore: state.currentGame!.currentScore + 2),
      ));
      if (isDailyChallenge && (currentScore + 2) >= requiredScore) {
        final updated = state.currentGame!
            .copyWith(totalScore: currentScore + 2, hasCompleted: true);
        await startGameUseCase
            .call(StartGameSessionParams(gameDataModel: updated.toModel()));
   
            if(state.currentGame!.levelType==3){
                  build
            .read<GameRewardsBloc>()
            .add(GameRewardsUpdateEvent(DateTime.now(), build));
            }
  
        build.read<GameDailyTaskBloc>().add(FetchGameDailyTaskEvent());

        Navigator.pop(build);
     showDialog(
          context: build,
          barrierDismissible: false, // prevent manual tap to close
          builder: (context) {
            // Schedule auto-close after 2 sec
            Future.delayed(const Duration(seconds: 2), () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            });

            return AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: ContainerCustom(
                width: 300.w,
                height: 200.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'asset/images/success-popper.gif',
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        Text(
                          "🎉 Congratulations!",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Level Completed",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
        
      }
    } else {
      newInvalid = [i, j];
    }

    emit(state.copyWith(
      matched: newMatched,
      invalidPair: newInvalid,
      selected: [],
    ));
  }

  void showHint() {
    final hints = <List<int>>[];

    for (int i = 0; i < state.numbers.length; i++) {
      if (state.numbers[i] == null || state.matched.contains(i)) continue;

      for (int j = i + 1; j < state.numbers.length; j++) {
        if (state.numbers[j] == null || state.matched.contains(j)) continue;

        if (isNeighbor(i, j) &&
            canMatch(state.numbers[i]!, state.numbers[j]!)) {
          hints.add([i, j]);
        }
      }
    }

    emit(state.copyWith(hintPair: hints.isNotEmpty ? hints.first : []));
  }

  void addNumbers() {
    final random = Random();
    final newNumbers = List<int?>.from(state.numbers);

    final empties = <int>[];
    for (int i = 0; i < newNumbers.length; i++) {
      if (newNumbers[i] == null) empties.add(i);
    }

    if (empties.isEmpty) return;

    const toAdd = 12;
    final count = min(toAdd, empties.length);

    for (int k = 0; k < count; k++) {
      newNumbers[empties[k]] = random.nextInt(9) + 1;
    }

    newNumbers.addAll(List.filled(12, null));
    emit(state.copyWith(currentGame: state.currentGame!.copyWith(addRowUsed: state.currentGame!.addRowUsed-1),
      numbers: newNumbers,
      hintPair: [],
      invalidPair: [],
      selected: [],
    ));
  }

  void toggleSelection(
      {required int index,
      required BuildContext build,
      required double requiredScore,
      required double currentScore,
      required bool isDailyChallenge}) {
    final selected = List<int>.from(state.selected);

    if (selected.contains(index)) {
      selected.remove(index);
    } else {
      selected.add(index);
    }

    emit(state.copyWith(
      selected: selected,
      hintPair: [], // clear hint when tapping
    ));

    if (selected.length == 2) {
      tryMatch(
          build: build,
          currentScore: currentScore,
          requiredScore: requiredScore,
          isDailyChallenge: isDailyChallenge);
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
