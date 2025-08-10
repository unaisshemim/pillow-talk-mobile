// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:pillowtalk/features/auth/model/auth_request_model.dart';
// import 'package:pillowtalk/features/auth/model/auth_response_model.dart';
// import 'package:pillowtalk/features/auth/model/send_otp_request.dart';
// import 'package:pillowtalk/features/auth/model/send_otp_response.dart';
// import 'package:pillowtalk/features/auth/model/verify_otp_request.dart';
// import 'package:pillowtalk/features/auth/model/auth_user.dart';

// abstract class AuthRepository {
//   Future<SendOtpResponse> sendOtp(SendOtpRequest body);
//   Future<AuthUser> verifyOtp(VerifyOtpRequest body);
// }

// class AuthRepositoryImpl implements AuthRepository {
//   AuthRepositoryImpl(this._dio);
//   final Dio _dio;

//   // 🔁 Replace baseUrl/endpoints to your backend (or implement Firebase here)
//   static const _baseUrl = 'https://api.your-backend.com';

//   @override
//   Future<SendOtpResponse> sendOtp(SendOtpRequest body) async {
//     // Example API call (change to your endpoint)
//     // final res = await _dio.post('$_baseUrl/auth/send-otp', data: body.toJson());
//     // return SendOtpResponse.fromJson(res.data as Map<String, dynamic>);

//     // --- Demo/mock implementation (remove when wired) ---
//     await Future.delayed(const Duration(seconds: 1));
//     final masked =
//         '${body.phone.substring(0, 3)} ${'*' * (body.phone.length - 7)}${body.phone.substring(body.phone.length - 4)}';
//     return SendOtpResponse(requestId: 'req_${DateTime.now().millisecondsSinceEpoch}', maskedNumber: masked, retryAfter: 30);
//   }

//   @override
//   Future<AuthUser> verifyOtp(VerifyOtpRequest body) async {
//     // Example API call:
//     // final res = await _dio.post('$_baseUrl/auth/verify-otp', data: body.toJson());
//     // return AuthUser.fromJson(res.data as Map<String, dynamic>);

//     // --- Demo/mock implementation (remove when wired) ---
//     await Future.delayed(const Duration(seconds: 1));
//     return AuthUser(
//       id: 'user_123',
//       phone: '+19999999999',
//       displayName: 'PillowTalk User',
//       accessToken: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
//     );
//   }
// }
