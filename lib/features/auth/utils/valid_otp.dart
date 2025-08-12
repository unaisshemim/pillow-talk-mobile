bool isValidOtp(String otp) {
  return otp.length == 4 && RegExp(r'^\d{4}$').hasMatch(otp);
}
