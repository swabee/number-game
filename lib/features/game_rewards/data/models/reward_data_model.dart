import 'package:number_game/features/game_rewards/domain/entities/reward_data_entity.dart';

class RewardDataModel extends RewardDataEntity {
  const RewardDataModel({
    required super.id,
    required super.date,
    required super.hintCount,
    required super.dailyChallengeRewardDate,
    required super.hasCollected,
  });

  factory RewardDataModel.fromJson(Map<String, dynamic> json) {
    return RewardDataModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      hintCount: json['hint_count'],
      dailyChallengeRewardDate:
          DateTime.parse(json['daily_challenge_reward_date']),
      hasCollected: json['has_collected'] ?? false, // 🔹 default false if missing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'hint_count': hintCount,
      'daily_challenge_reward_date':
          dailyChallengeRewardDate.toIso8601String(),
      'has_collected': hasCollected,
    };
  }
}
