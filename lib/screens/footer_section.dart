import 'package:flutter/material.dart';
import 'package:rishal/utils/app_colors.dart';

class ModernFooterSection extends StatelessWidget {
  const ModernFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: AppColors.background,
      child: Center(
        child: Text(
          'Made with ❤️ in Flutter',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ),
    );
  }
}
