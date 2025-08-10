import 'package:pillowtalk/common/providers/api_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final todosProvider = FutureProvider.autoDispose((ref) async {
  final api = ref.watch(apiServiceProvider);
  final todos = await api.get('/todos');
  return todos;
});
