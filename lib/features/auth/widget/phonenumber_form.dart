import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class PhoneNumberForm extends StatelessWidget {
  final TextEditingController controller;
  final String selectedCode;
  final List<Map<String, String>> countryCodes;
  final ValueChanged<String> onCountryChanged;

  const PhoneNumberForm({
    super.key,
    required this.controller,
    required this.selectedCode,
    required this.countryCodes,
    required this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.pColor.neutral.n30, width: 1.5),
        borderRadius: BorderRadius.circular(PSizes.s12),
      ),
      child: Row(
        children: [
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCode,
                isDense: true,
                onChanged: (value) => onCountryChanged(value!),
                items: countryCodes.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['code'],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          country['country']!,
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s14),
                            color: context.pColor.neutral.n70,
                          ),
                        ),
                        const SizedBox(width: PSizes.s8),
                        Text(
                          country['code']!,
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s16),
                            fontWeight: FontWeight.w500,
                            color: context.pColor.neutral.n90,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
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
                color: context.pColor.neutral.n90,
              ),
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: TextStyle(color: context.pColor.neutral.n50),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: PSizes.s16,
                  vertical: PSizes.s16,
                ),
              ),
              validator: (value) {
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
}
