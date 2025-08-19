import 'package:jwt_decode/jwt_decode.dart';

bool isTokenStillValid(
  String? token, {
  Duration leeway = const Duration(minutes: 1),
}) {
  if (token == null || token.isEmpty) return false;

  // Fast path: jwt_decode can check the `exp` field directly
  if (Jwt.isExpired(token)) return false;

  // Extra safety: consider near-expiry tokens invalid
  final DateTime? exp = Jwt.getExpiryDate(token);
  if (exp == null) return false;

  return exp.isAfter(DateTime.now().add(leeway));
}
