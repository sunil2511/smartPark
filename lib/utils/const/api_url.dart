class ApiUrl {
  ApiUrl._();

  static const String baseUrl = "http://127.0.0.1:5000/api/";
  static const String loginUrl = "is_authenticate_user";
  static const String registerUrl = "user/register";
  static const String profileUrl = "static-content/get-countries-list";
  static const String createRideUrl = "auth/forgot-password";
  static const String searchRideUrl = "auth/resend-otp";
  static const String historyUrl = "auth/otp-verify";
}
