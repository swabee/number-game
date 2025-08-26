import 'dart:convert';

import 'package:hive/hive.dart';

class HiveStorageService {
  static final HiveStorageService _instance = HiveStorageService._internal();
  factory HiveStorageService() => _instance;
  HiveStorageService._internal();

  Future<Box<String>> _openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<String>(boxName);
    }
    return Hive.box<String>(boxName);
  }

  /// Save JSON object
  Future<void> saveJson(String boxName, String key, Map<String, dynamic> json) async {
    final box = await _openBox(boxName);
    await box.put(key, jsonEncode(json));
  }

  /// Read JSON object
  Future<Map<String, dynamic>?> readJson(String boxName, String key) async {
    final box = await _openBox(boxName);
    final value = box.get(key);
    if (value == null) return null;
    return jsonDecode(value) as Map<String, dynamic>;
  }

  /// Delete
  Future<void> delete(String boxName, String key) async {
    final box = await _openBox(boxName);
    await box.delete(key);
  }

  /// Get all JSON objects
  Future<List<Map<String, dynamic>>> getAllJson(String boxName) async {
    final box = await _openBox(boxName);
    return box.values
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }

  ///box Clear
  Future<void> clear(String boxName) async {
    final box = await _openBox(boxName);
    await box.clear();
  }
}
