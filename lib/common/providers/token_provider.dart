import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/common/providers/hive_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_provider.g.dart';

@riverpod
Future<String?> token(Ref ref) async {
  final hive = ref.read(hiveServiceProvider);
  return await hive.get('accessToken');
}
