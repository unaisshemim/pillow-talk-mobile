import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:patrol/patrol.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:pillowtalk/common/providers/hive_provider.dart';

void main() {
  group('AuthNotifier Tests', () {
    late ProviderContainer container;

    setUpAll(() async {
      await Hive.initFlutter();
    });

    setUp(() async {
      container = ProviderContainer();
    });

    tearDown(() async {
      container.dispose();
      await Hive.deleteFromDisk();
    });

    group('Token Validation', () {
      test('isTokenExpired returns true for null token', () {
        final authNotifier = container.read(authNotifierProvider.notifier);
        expect(authNotifier.isTokenExpired(null), isTrue);
      });

      test('isTokenExpired returns true for empty token', () {
        final authNotifier = container.read(authNotifierProvider.notifier);
        expect(authNotifier.isTokenExpired(''), isTrue);
      });

      test('isTokenExpired returns true for expired token', () {
        final authNotifier = container.read(authNotifierProvider.notifier);
        // Create a JWT token that's already expired (exp claim in the past)
        const expiredToken =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE1MTYyMzkwMjJ9.invalid';
        expect(authNotifier.isTokenExpired(expiredToken), isTrue);
      });

      test('isTokenExpired returns true for invalid token format', () {
        final authNotifier = container.read(authNotifierProvider.notifier);
        expect(authNotifier.isTokenExpired('invalid-token'), isTrue);
      });
    });

    group('Authentication Status', () {
      test('isAuthenticated returns false when no token stored', () async {
        final authNotifier = container.read(authNotifierProvider.notifier);
        final result = await authNotifier.isAuthenticated();
        expect(result, isFalse);
      });

      test('hasWatchedOnboarding returns false when not set', () async {
        final authNotifier = container.read(authNotifierProvider.notifier);
        final result = await authNotifier.hasWatchedOnboarding();
        expect(result, isFalse);
      });
    });

    group('Token Storage', () {
      test('getAccessToken returns null when not stored', () async {
        final authNotifier = container.read(authNotifierProvider.notifier);
        final result = await authNotifier.getAccessToken();
        expect(result, isNull);
      });

      test('getRefreshToken returns null when not stored', () async {
        final authNotifier = container.read(authNotifierProvider.notifier);
        final result = await authNotifier.getRefreshToken();
        expect(result, isNull);
      });
    });

    group('Logout', () {
      test('logout clears stored tokens', () async {
        final authNotifier = container.read(authNotifierProvider.notifier);

        // First store some tokens (this would normally be done during login)
        final hiveService = container.read(hiveServiceProvider);
        await hiveService.put('accessToken', 'test-access-token');
        await hiveService.put('refreshToken', 'test-refresh-token');

        // Verify tokens are stored
        expect(
          await authNotifier.getAccessToken(),
          equals('test-access-token'),
        );
        expect(
          await authNotifier.getRefreshToken(),
          equals('test-refresh-token'),
        );

        // Perform logout
        await authNotifier.logout();

        // Verify tokens are cleared
        expect(await authNotifier.getAccessToken(), isNull);
        expect(await authNotifier.getRefreshToken(), isNull);
      });
    });

    group('Token Refresh Validation', () {
      test('isValidTokenAuthenticated returns false when no tokens', () async {
        final authNotifier = container.read(authNotifierProvider.notifier);
        final result = await authNotifier.isValidTokenAuthenticated();
        expect(result, isFalse);
      });

      test('refreshAccessToken returns false when no refresh token', () async {
        final authNotifier = container.read(authNotifierProvider.notifier);
        final result = await authNotifier.refreshAccessToken();
        expect(result, isFalse);
      });
    });
  });
}
