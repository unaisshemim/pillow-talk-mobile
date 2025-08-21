abstract class PRouter {
  //onboarding
  static const PRouterDetail onBoarding = PRouterDetail(
    'OnBoarding',
    '/onboarding',
  );
  static const PRouterDetail getStarted = PRouterDetail(
    'GetStarted',
    '/getstarted',
  );

  static const PRouterDetail signupVerification = PRouterDetail(
    'SignupVerification',
    'signup-verification',
  );
  static const PRouterDetail forgotPassword = PRouterDetail(
    'ForgotPassword',
    'forgot-password',
  );
  static const PRouterDetail forgotPasswordOtpVerification = PRouterDetail(
    'ForgotPasswordOtpVerification',
    'forgot-password-otp-verification',
  );
  static const PRouterDetail forgotPasswordChangePassword = PRouterDetail(
    'ForgotPasswordChangePassword',
    'forgot-password-change-password',
  );

  //tab bar
  static const PRouterDetail home = PRouterDetail('Home', '/home');

  //chat screen
  static const PRouterDetail chat = PRouterDetail('Chat', '/chat');
  static const PRouterDetail chatConversation = PRouterDetail(
    'ChatConversation',
    '/chat/:id',
  );

  //profile
  static const PRouterDetail profile = PRouterDetail('Profile', '/profile');

  static const PRouterDetail profileOnboarding = PRouterDetail(
    'ProfileOnboarding',
    '/profile-onboarding',
  );

  static const PRouterDetail profileEdit = PRouterDetail(
    'ProfileEdit',
    '/profile-edit',
  );

  static const PRouterDetail setting = PRouterDetail('Setting', '/setting');

  static const PRouterDetail partner = PRouterDetail('Partner', '/partner');

  //notification
  static const PRouterDetail notification = PRouterDetail(
    'Notification',
    '/notification',
  );

  //exercises
  static const PRouterDetail exercises = PRouterDetail(
    'Exercises',
    '/exercises',
  );

  //insights
  static const PRouterDetail insights = PRouterDetail('Insights', '/insights');

  //dev
  static const PRouterDetail dev = PRouterDetail('Dev', '/dev');
}

class PRouterDetail {
  final String name;
  final String path;
  const PRouterDetail(this.name, this.path);
}
