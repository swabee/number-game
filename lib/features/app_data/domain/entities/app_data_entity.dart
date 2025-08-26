import 'package:number_game/features/app_data/data/models/app_data_model.dart';

class AppDataEntity {
  final double totalHindBalance;
  final bool soundPermissionEnabled;
  final bool notificationPermissionEnabled;
  final double bestScore;
  final int lastRewardTakenLevel;

  const AppDataEntity({
    required this.totalHindBalance,
    required this.soundPermissionEnabled,
    required this.notificationPermissionEnabled,
    required this.bestScore,
    required this.lastRewardTakenLevel,
  });


  static final empty = AppDataEntity(
    totalHindBalance: 0.0,
    soundPermissionEnabled: false,
    notificationPermissionEnabled: false,
    bestScore: 0.0,
    lastRewardTakenLevel: 0,
  );

  bool get isEmpty => this == AppDataEntity.empty;
  bool get isNotEmpty => this != AppDataEntity.empty;

  AppDataEntity copyWith({
    double? totalHindBalance,
    bool? soundPermissionEnabled,
    bool? notificationPermissionEnabled,
    double? bestScore,
    int? lastRewardTakenLevel,
  }) {
    return AppDataEntity(
      totalHindBalance: totalHindBalance ?? this.totalHindBalance,
      soundPermissionEnabled: soundPermissionEnabled ?? this.soundPermissionEnabled,
      notificationPermissionEnabled: notificationPermissionEnabled ?? this.notificationPermissionEnabled,
      bestScore: bestScore ?? this.bestScore,
      lastRewardTakenLevel: lastRewardTakenLevel ?? this.lastRewardTakenLevel,
    );
  }


  AppDataModel toModel() {
    return AppDataModel(
      totalHindBalance: totalHindBalance,
      soundPermissionEnabled: soundPermissionEnabled,
      notificationPermissionEnabled: notificationPermissionEnabled,
      bestScore: bestScore,
      lastRewardTakenLevel: lastRewardTakenLevel,
    );
  }
}

