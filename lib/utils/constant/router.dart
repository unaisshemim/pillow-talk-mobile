abstract class PRouter {
  static const PRouterDetail onBoarding =
      PRouterDetail('OnBoarding', '/onboarding');
  static const PRouterDetail getStarted =
      PRouterDetail('GetStarted', '/getstarted');
  static const PRouterDetail auth = PRouterDetail('Auth', '/auth');
  static const PRouterDetail otp = PRouterDetail('OTP', '/otp');
  static const PRouterDetail signupVerification =
      PRouterDetail('SignupVerification', 'signup-verification');
  static const PRouterDetail forgotPassword =
      PRouterDetail('ForgotPassword', 'forgot-password');
  static const PRouterDetail forgotPasswordOtpVerification = PRouterDetail(
      'ForgotPasswordOtpVerification', 'forgot-password-otp-verification');
  static const PRouterDetail forgotPasswordChangePassword = PRouterDetail(
      'ForgotPasswordChangePassword', 'forgot-password-change-password');
  static const PRouterDetail home = PRouterDetail('Home', '/home');
  static const PRouterDetail chat = PRouterDetail('Chat', '/chat');
  static const PRouterDetail profile = PRouterDetail('Profile', '/profile');
  static const PRouterDetail partner = PRouterDetail('Partner', '/partner');
  static const PRouterDetail notification =
      PRouterDetail('Notification', '/notification');
  static const PRouterDetail dev = PRouterDetail('Dev', '/dev');
}

class PRouterDetail {
  final String name;
  final String path;
  const PRouterDetail(this.name, this.path);
}
