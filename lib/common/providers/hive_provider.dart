//creating hive
import 'package:pillowtalk/common/services/hive_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});
