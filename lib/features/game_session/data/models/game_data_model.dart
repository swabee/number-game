import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';



class GameDataModel extends GameDataEntity {
  const GameDataModel({
    required super.id,
    required super.date,
    required super.levelType,
    required super.isDailyChallenge,
    required super.currentScore,
    required super.timeRemaining,
    required super.addRowUsed,
    required super.hasCompleted,
    required super.totalScore,
  });

  factory GameDataModel.fromJson(Map<String, dynamic> json) {
    return GameDataModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      levelType: json['level_type'],
      isDailyChallenge: json['is_daily_challenge'],
      currentScore: (json['current_score'] as num).toDouble(),
      timeRemaining: json['time_remaining'],
      addRowUsed: json['add_row_used'],
      hasCompleted: json['has_completed'],
      totalScore: (json['total_score'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'level_type': levelType,
      'is_daily_challenge': isDailyChallenge,
      'current_score': currentScore,
      'time_remaining': timeRemaining,
      'add_row_used': addRowUsed,
      'has_completed': hasCompleted,
      'total_score': totalScore,
    };
  }
}
