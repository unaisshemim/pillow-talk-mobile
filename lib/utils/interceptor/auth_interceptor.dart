// import 'package:dio/dio.dart';

// class PAuthInterceptor extends Interceptor {
//   final Future<dynamic> Function() tokenProvider;
//   final String tokenType;
//   final bool enabled;

//   PAuthInterceptor({
//     required this.tokenProvider,
//     this.tokenType = 'Bearer',
//     this.enabled = true,
//   });

//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     if (!enabled) {
//       return handler.next(options);
//     }

//     if (options.uri.path.contains('/auth')) {
//       print('Skipping authentication for ${options.uri.path}');
//       options.headers['web-api-key'] = 'my-secure-secret';
//       return handler.next(options);
//     }

//     try {
//       final token = await tokenProvider();
//       if (token != null && token.isNotEmpty) {
//         options.headers['Authorization'] = '$tokenType $token';
//       }
//     } catch (error) {
//       // Handle token retrieval errors if needed
//     }

//     handler.next(options);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode == 401) {
//       try {
//         // Get the CognitoService instance
//         // final cognitoService = getIt<CognitoService>();

//         // Refresh the session
//         // final response = await cognitoService.refreshToken();
//         // print('Error in onError 12 $response');
//         // // Retry the original request
//         // final request = err.requestOptions;
//         // final token = response['accessToken'];
//         // request.headers['Authorization'] = '$tokenType $token';

//         try {
//           final response = await Dio().fetch(request);
//           return handler.resolve(response);
//         } catch (e) {
//           return handler.next(err);
//         }
//       } catch (e) {
//         // If refresh fails, clear tokens and redirect to login
//         // await getIt<HiveService>().delete('accessToken');
//         // await getIt<HiveService>().delete('refreshToken');
//         // await getIt<CognitoService>().updateGuestLogin(true);
//         // You might want to navigate to login screen here
//       }
//     }
//     return handler.next(err);
//   }
// }
