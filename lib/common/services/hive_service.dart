import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const _boxName = 'pillowtalk-db';

  Future<void> init() async {
    await Hive.initFlutter();
    await _openBox();
  }

  Future<Box> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox(_boxName);
    }

    return Hive.box(_boxName);
  }

  Future<void> put(key, value) async {
    final box = await _openBox();
    await box.put(key, value);
  }

  Future get(String key) async {
    final box = await _openBox();
    return box.get(key);
  }

  Future<void> delete(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}
