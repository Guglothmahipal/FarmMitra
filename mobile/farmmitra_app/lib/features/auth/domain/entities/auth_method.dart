enum AuthMethod {
  otp,
  google;

  String get label => switch (this) {
    AuthMethod.otp => 'OTP',
    AuthMethod.google => 'Google',
  };
}
