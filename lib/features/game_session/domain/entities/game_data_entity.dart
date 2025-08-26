import 'package:number_game/features/game_session/data/models/game_data_model.dart';

class GameDataEntity {
  final String id;
  final DateTime date;
  final int levelType;
  final bool isDailyChallenge;
  final double currentScore;
  final int timeRemaining;
  final int addRowUsed;
  final bool hasCompleted;
  final double totalScore;

  const GameDataEntity({
    required this.id,
    required this.date,
    required this.levelType,
    required this.isDailyChallenge,
    required this.currentScore,
    required this.timeRemaining,
    required this.addRowUsed,
    required this.hasCompleted,
    required this.totalScore,
  });

  /// 🔹 Empty instance
  static final empty = GameDataEntity(
    id: '',
    date: DateTime.now(),
    levelType: 0,
    isDailyChallenge: false,
    currentScore: 0.0,
    timeRemaining: 0,
    addRowUsed: 0,
    hasCompleted: false,
    totalScore: 0.0,
  );

  bool get isEmpty => this == GameDataEntity.empty;
  bool get isNotEmpty => this != GameDataEntity.empty;

  GameDataEntity copyWith({
    String? id,
    DateTime? date,
    int? levelType,
    bool? isDailyChallenge,
    double? currentScore,
    int? timeRemaining,
    int? addRowUsed,
    bool? hasCompleted,
    double? totalScore,
  }) {
    return GameDataEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      levelType: levelType ?? this.levelType,
      isDailyChallenge: isDailyChallenge ?? this.isDailyChallenge,
      currentScore: currentScore ?? this.currentScore,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      addRowUsed: addRowUsed ?? this.addRowUsed,
      hasCompleted: hasCompleted ?? this.hasCompleted,
      totalScore: totalScore ?? this.totalScore,
    );
  }

  /// 🔹 Convert Entity -> Model
  GameDataModel toModel() {
    return GameDataModel(
      id: id,
      date: date,
      levelType: levelType,
      isDailyChallenge: isDailyChallenge,
      currentScore: currentScore,
      timeRemaining: timeRemaining,
      addRowUsed: addRowUsed,
      hasCompleted: hasCompleted,
      totalScore: totalScore,
    );
  }
}
