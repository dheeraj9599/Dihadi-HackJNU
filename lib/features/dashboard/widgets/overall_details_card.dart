import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';

class OverallDetailsCard extends StatelessWidget {
  final Color? cardColor;
  final LinearGradient? cardGradient;
  final String title;
  final String data;
  final IconData icon;
  const OverallDetailsCard({
    super.key,
    this.cardColor,
    this.cardGradient,
    required this.title,
    required this.data,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: cardGradient,
          color: cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.textRegular.copyWith(
                      color: AppColors.lightWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    data,
                    style: AppTextStyle.displayHeavy
                        .copyWith(fontSize: 26, color: AppColors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            icon,
                            color: AppColors.green,
                          ),
                          Text(
                            '+66%',
                            style: AppTextStyle.textSemiBold.copyWith(
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.arrow_drop_up,
                                  color: AppColors.green,
                                ),
                                Text(
                                  '320',
                                  style: AppTextStyle.textSemiBold.copyWith(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.red,
                                ),
                                Text(
                                  '4',
                                  style: AppTextStyle.textSemiBold.copyWith(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}