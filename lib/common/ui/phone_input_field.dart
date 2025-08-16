import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final CountryCode? initialCountryCode;
  final ValueChanged<CountryCode>? onCountryCodeChanged;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final List<String>? favorites;
  final List<String>? filteredCountries;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.initialCountryCode,
    this.onCountryCodeChanged,
    this.hintText = 'Phone number',
    this.validator,
    this.enabled = true,
    this.favorites,
    this.filteredCountries,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late CountryCode _selectedCountryCode;
  late FlCountryCodePicker _countryPicker;

  @override
  void initState() {
    super.initState();
    _selectedCountryCode =
        widget.initialCountryCode ??
        const CountryCode(name: 'India', code: 'IN', dialCode: '+91');

    _countryPicker = FlCountryCodePicker(
      localize: true,
      showDialCode: true,
      showSearchBar: true,
      favorites: widget.favorites ?? ['IN', 'US', 'GB', 'AU'],
      filteredCountries: widget.filteredCountries ?? [],
      countryTextStyle: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
      dialCodeTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.pColor.neutral.n30, width: 1.5),
        borderRadius: BorderRadius.circular(PSizes.s12),
      ),
      child: Row(
        children: [
          // Country Code Section
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PSizes.s16,
              vertical: PSizes.s16,
            ),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: context.pColor.neutral.n30, width: 1),
              ),
            ),
            child: GestureDetector(
              onTap: widget.enabled ? _showCountryPicker : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Country Flag
                  SizedBox(
                    width: 24,
                    height: 16,
                    child: _selectedCountryCode.flagImage(
                      width: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: PSizes.s8),
                  // Country Code
                  Text(
                    _selectedCountryCode.dialCode,
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s16),
                      fontWeight: FontWeight.w600,
                      color: widget.enabled
                          ? context.pColor.neutral.n90
                          : context.pColor.neutral.n50,
                    ),
                  ),
                  const SizedBox(width: PSizes.s4),
                  // Dropdown Icon
                  Icon(
                    Icons.arrow_drop_down,
                    color: widget.enabled
                        ? context.pColor.neutral.n60
                        : context.pColor.neutral.n40,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          // Phone Number Input Section
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              enabled: widget.enabled,
              keyboardType: TextInputType.phone,
              onTapOutside: (e) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
              ],
              style: TextStyle(
                fontSize: responsive(context, PSizes.s18),
                fontWeight: FontWeight.w500,
                color: widget.enabled
                    ? context.pColor.neutral.n90
                    : context.pColor.neutral.n50,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: context.pColor.neutral.n50,
                  fontSize: responsive(context, PSizes.s16),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: PSizes.s16,
                  vertical: PSizes.s16,
                ),
                errorStyle: TextStyle(
                  fontSize: responsive(context, PSizes.s12),
                  color: context.pColor.error.base,
                ),
              ),
              validator:
                  widget.validator ??
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCountryPicker() async {
    final picked = await _countryPicker.showPicker(
      context: context,
      backgroundColor: context.pColor.neutral.n10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PSizes.s16),
      ),
      initialSelectedLocale: _selectedCountryCode.code,
    );

    if (picked != null) {
      setState(() {
        _selectedCountryCode = picked;
      });
      widget.onCountryCodeChanged?.call(picked);
    }
  }

  /// Get the complete phone number with country code
  String get fullPhoneNumber =>
      '${_selectedCountryCode.dialCode}${widget.controller.text}';

  /// Get the selected country code object
  CountryCode get selectedCountryCode => _selectedCountryCode;

  /// Get the selected dial code as string
  String get selectedDialCode => _selectedCountryCode.dialCode;
}
