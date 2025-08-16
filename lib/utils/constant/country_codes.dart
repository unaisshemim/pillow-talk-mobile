class CountryCodeData {
  static const List<Map<String, String>> countryCodes = [
    {'code': '+91', 'country': 'IN', 'name': 'India'},
    {'code': '+1', 'country': 'US/CA', 'name': 'United States/Canada'},
    {'code': '+44', 'country': 'UK', 'name': 'United Kingdom'},
    {'code': '+86', 'country': 'CN', 'name': 'China'},
    {'code': '+81', 'country': 'JP', 'name': 'Japan'},
    {'code': '+49', 'country': 'DE', 'name': 'Germany'},
    {'code': '+33', 'country': 'FR', 'name': 'France'},
    {'code': '+39', 'country': 'IT', 'name': 'Italy'},
    {'code': '+34', 'country': 'ES', 'name': 'Spain'},
    {'code': '+61', 'country': 'AU', 'name': 'Australia'},
    {'code': '+52', 'country': 'MX', 'name': 'Mexico'},
    {'code': '+55', 'country': 'BR', 'name': 'Brazil'},
    {'code': '+7', 'country': 'RU', 'name': 'Russia'},
    {'code': '+82', 'country': 'KR', 'name': 'South Korea'},
    {'code': '+27', 'country': 'ZA', 'name': 'South Africa'},
  ];

  /// Gets country code by dial code
  static Map<String, String>? getCountryByCode(String dialCode) {
    try {
      return countryCodes.firstWhere((country) => country['code'] == dialCode);
    } catch (e) {
      return null;
    }
  }

  /// Gets country name by dial code
  static String getCountryNameByCode(String dialCode) {
    final country = getCountryByCode(dialCode);
    return country?['name'] ?? 'Unknown';
  }

  /// Gets country abbreviation by dial code
  static String getCountryAbbreviationByCode(String dialCode) {
    final country = getCountryByCode(dialCode);
    return country?['country'] ?? 'Unknown';
  }

  /// Default country code
  static const String defaultCountryCode = '+91';
}
