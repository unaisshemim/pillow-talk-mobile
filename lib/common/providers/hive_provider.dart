import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/common/services/hive_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hive_provider.g.dart';

@riverpod
HiveService hiveService(Ref ref) {
  return HiveService();
}
