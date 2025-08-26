class AppLevelCondition {
  // level 1
  final int level1pointNeeded = 10;
  final int level1secondsAvailable = 60;
  final int level1availableAddRow = 9;

  // level 2
  final int level2pointNeeded = 15;
  final int level2secondsAvailable = 55;
  final int level2availableAddRow = 7;

  // level 3
  final int level3pointNeeded = 20;
  final int level3secondsAvailable = 50;
  final int level3availableAddRow = 5;

  /// 🔹 Getters
  int getPointsNeeded(int level) {
    switch (level) {
      case 1:
        return level1pointNeeded;
      case 2:
        return level2pointNeeded;
      case 3:
        return level3pointNeeded;
      default:
        throw Exception("Invalid level: $level");
    }
  }

  int getSecondsAvailable(int level) {
    switch (level) {
      case 1:
        return level1secondsAvailable;
      case 2:
        return level2secondsAvailable;
      case 3:
        return level3secondsAvailable;
      default:
        throw Exception("Invalid level: $level");
    }
  }

  int getAddRowsAvailable(int level) {
    switch (level) {
      case 1:
        return level1availableAddRow;
      case 2:
        return level2availableAddRow;
      case 3:
        return level3availableAddRow;
      default:
        throw Exception("Invalid level: $level");
    }
  }
}
