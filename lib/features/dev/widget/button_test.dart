import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pillowtalk/common/ui/button/button.dart';
import 'package:pillowtalk/common/ui/button/continue_button.dart';
import 'package:pillowtalk/common/ui/button/icon_button.dart';

import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class ButtonTest extends StatelessWidget {
  const ButtonTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PSizes.s16),
      child: _buildButtonShowcase(context),
    );
  }

  Widget _buildButtonShowcase(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'Primary Buttons',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        // Primary Button - Large
        PButton.primary(
          text: 'Large Primary Button',
          size: ButtonSize.large,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Large Primary Button Pressed!')),
            );
          },
        ),
        const SizedBox(height: PSizes.s12),

        // Primary Button - Medium with Icon
        PButton.primary(
          text: 'Medium Primary with Icon',
          size: ButtonSize.medium,
          icon: const Icon(Icons.star, size: 20),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Primary with Icon Pressed!')),
            );
          },
        ),
        const SizedBox(height: PSizes.s12),

        // Primary Button - Small
        PButton.primary(
          text: 'Small Primary Button',
          size: ButtonSize.small,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Small Primary Button Pressed!')),
            );
          },
        ),
        const SizedBox(height: PSizes.s24),

        // Secondary Buttons Section
        Text(
          'Secondary Buttons',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        PButton.secondary(
          text: 'Secondary Button',
          size: ButtonSize.medium,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Secondary Button Pressed!')),
            );
          },
        ),
        const SizedBox(height: PSizes.s12),

        PButton.secondary(
          text: 'Secondary with Icon',
          size: ButtonSize.medium,
          icon: const Icon(Icons.settings, size: 20),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Secondary with Icon Pressed!')),
            );
          },
        ),
        const SizedBox(height: PSizes.s24),

        // Outline Buttons Section
        Text(
          'Outline Buttons',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        PButton.outline(
          text: 'Outline Button',
          size: ButtonSize.medium,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Outline Button Pressed!')),
            );
          },
        ),
        const SizedBox(height: PSizes.s12),

        PButton.outline(
          text: 'Outline with Icon',
          size: ButtonSize.medium,
          icon: const Icon(Icons.download, size: 20),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Outline with Icon Pressed!')),
            );
          },
        ),
        const SizedBox(height: PSizes.s24),

        // Text Buttons Section
        Text(
          'Text Buttons',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        Row(
          children: [
            PButton.text(
              text: 'Text Button',
              size: ButtonSize.medium,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Text Button Pressed!')),
                );
              },
            ),
            const SizedBox(width: PSizes.s16),
            PButton.text(
              text: 'Skip',
              size: ButtonSize.small,
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Skip Pressed!')));
              },
            ),
          ],
        ),
        const SizedBox(height: PSizes.s24),

        // Loading States Section
        Text(
          'Loading States',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        PButton.primary(
          text: 'Loading Primary',
          size: ButtonSize.medium,
          isLoading: true,
          onPressed: () {},
        ),
        const SizedBox(height: PSizes.s12),

        PButton.outline(
          text: 'Loading Outline',
          size: ButtonSize.medium,
          isLoading: true,
          onPressed: () {},
        ),
        const SizedBox(height: PSizes.s24),

        // Disabled States Section
        Text(
          'Disabled States',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        PButton.primary(
          text: 'Disabled Primary',
          size: ButtonSize.medium,
          onPressed: null, // null makes it disabled
        ),
        const SizedBox(height: PSizes.s12),

        PButton.outline(
          text: 'Disabled Outline',
          size: ButtonSize.medium,
          onPressed: null, // null makes it disabled
        ),
        const SizedBox(height: PSizes.s24),

        // Icon Buttons Section
        Text(
          'Icon Buttons',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        Row(
          children: [
            PIconButton(
              icon: const Icon(Icons.favorite),
              variant: ButtonVariant.primary,
              size: ButtonSize.large,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Primary Icon Button Pressed!')),
                );
              },
            ),
            const SizedBox(width: PSizes.s12),
            PIconButton(
              icon: const Icon(Icons.share),
              variant: ButtonVariant.secondary,
              size: ButtonSize.medium,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Secondary Icon Button Pressed!'),
                  ),
                );
              },
            ),
            const SizedBox(width: PSizes.s12),
            PIconButton(
              icon: const Icon(Icons.bookmark_border),
              variant: ButtonVariant.outline,
              size: ButtonSize.medium,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Outline Icon Button Pressed!')),
                );
              },
            ),
            const SizedBox(width: PSizes.s12),
            PIconButton(
              icon: const Icon(Icons.more_vert),
              variant: ButtonVariant.text,
              size: ButtonSize.small,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Text Icon Button Pressed!')),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: PSizes.s24),

        // Continue Button (Your Custom Button)
        Text(
          'Custom Continue Button',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        ContinueButton(
          isLoading: false,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Continue Button Pressed!')),
            );
          },
          text: 'Send Verification Code',
        ),
        const SizedBox(height: PSizes.s12),

        ContinueButton(isLoading: true, onPressed: () {}, text: 'Loading...'),
        const SizedBox(height: PSizes.s24),

        // Theme Color Variants Section
        Text(
          'Theme Color Variants',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        Text(
          'All buttons automatically use theme colors for consistency',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s12),
            color: context.pColor.neutral.n70,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        Row(
          children: [
            Expanded(
              child: PButton.primary(
                text: 'Primary ',
                size: ButtonSize.small,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Primary Theme Color!')),
                  );
                },
              ),
            ),
            const SizedBox(width: PSizes.s8),
            Expanded(
              child: PButton.secondary(
                text: 'Secondary ',
                size: ButtonSize.small,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Secondary Theme Color!')),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
