// core/utils/phone_mask.dart
String maskPhone(String code, String phone) {
  if (phone.length <= 4) return '$code $phone';
  final visible = phone.substring(phone.length - 4);
  return '$code ${'*' * (phone.length - 4)}$visible';
}
