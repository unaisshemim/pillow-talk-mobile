import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.pColor.primary.base,
                  context.pColor.secondary.base,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(PSizes.s24),
            ),
            child: Icon(
              Icons.favorite,
              size: 60,
              color: context.pColor.neutral.n10,
            ),
          ),
          const SizedBox(height: PSizes.s24),
          Text(
            'Welcome to Pillow Talk',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s24),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n90,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: PSizes.s8),
          Text(
            'Building stronger relationships through\nbetter communication',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s16),
              color: context.pColor.neutral.n60,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
