import 'package:number_game/features/app_data/domain/entities/app_data_entity.dart';

class AppDataModel extends AppDataEntity {
  const AppDataModel({
    required super.totalHindBalance,
    required super.soundPermissionEnabled,
    required super.notificationPermissionEnabled,
    required super.bestScore,
    required super.lastRewardTakenLevel,
  });

  factory AppDataModel.fromJson(Map<String, dynamic> json) {
    return AppDataModel(
      totalHindBalance: (json['total_hind_balance'] as num?)?.toDouble() ?? 0.0,
      soundPermissionEnabled: json['sound_permission_enabled'] ?? false,
      notificationPermissionEnabled: json['notification_permission_enabled'] ?? false,
      bestScore: (json['best_score'] as num?)?.toDouble() ?? 0.0,
      lastRewardTakenLevel: json['last_reward_taken_level'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_hind_balance': totalHindBalance,
      'sound_permission_enabled': soundPermissionEnabled,
      'notification_permission_enabled': notificationPermissionEnabled,
      'best_score': bestScore,
      'last_reward_taken_level': lastRewardTakenLevel,
    };
  }


  static const empty = AppDataModel(
    totalHindBalance: 5.0,
    soundPermissionEnabled: true,
    notificationPermissionEnabled: false,
    bestScore: 0.0,
    lastRewardTakenLevel: 0,
  );

  @override
  bool get isEmpty => this == AppDataModel.empty;
  @override
  bool get isNotEmpty => this != AppDataModel.empty;
}
