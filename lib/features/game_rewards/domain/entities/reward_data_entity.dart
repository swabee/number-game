import 'package:number_game/features/game_rewards/data/models/reward_data_model.dart';

class RewardDataEntity {
  final String id;
  final DateTime date;
  final int hintCount;
  final DateTime dailyChallengeRewardDate;
  final bool hasCollected; // 🔹 New field

  const RewardDataEntity({
    required this.id,
    required this.date,
    required this.hintCount,
    required this.dailyChallengeRewardDate,
    required this.hasCollected,
  });

  /// 🔹 Empty instance
  static final empty = RewardDataEntity(
    id: '',
    date: DateTime.now(),
    hintCount: 0,
    dailyChallengeRewardDate: DateTime.now(),
    hasCollected: false,
  );

  bool get isEmpty => this == RewardDataEntity.empty;
  bool get isNotEmpty => this != RewardDataEntity.empty;

  RewardDataEntity copyWith({
    String? id,
    DateTime? date,
    int? hintCount,
    DateTime? dailyChallengeRewardDate,
    bool? hasCollected,
  }) {
    return RewardDataEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      hintCount: hintCount ?? this.hintCount,
      dailyChallengeRewardDate:
          dailyChallengeRewardDate ?? this.dailyChallengeRewardDate,
      hasCollected: hasCollected ?? this.hasCollected,
    );
  }

  /// 🔹 Convert Entity -> Model
  RewardDataModel toModel() {
    return RewardDataModel(
      id: id,
      date: date,
      hintCount: hintCount,
      dailyChallengeRewardDate: dailyChallengeRewardDate,
      hasCollected: hasCollected,
    );
  }
}
