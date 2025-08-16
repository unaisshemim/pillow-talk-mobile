class ApiEndpoints {
  static const String baseUrl = 'https://api.pillow-talk.live/api';
  // static const String baseUrl = "http://10.0.2.2:50051";

  //auth
  static const String sendOtp = "/auth/otp/request";
  static const String verifyOtp = "/auth/otp/verify";
  static const String refreshToken = "/auth/refresh-token";

  //users
  static const String postUserProfile = "/users/profile";
  static const String updateUserProfile = "/users/profile";
}
