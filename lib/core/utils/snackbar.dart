import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'color_utility.dart';

void showCustomSnackbar(BuildContext context, String message) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SizedBox(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 22,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                // border:
                // Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(
                    18,), // Adjust the border radius as needed
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(getColorHexFromStr("#EA9F57")),
                    Color(getColorHexFromStr("#DD6F85")),
                  ],
                ),
              ),
              child: Center(
                child: Text(message,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.displaySemiBold.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    )),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white.withOpacity(0.6),
                  size: 16,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor:
          Colors.transparent, // Make Snackbar background transparent
      elevation: 0, // Remove Snackbar elevation
      behavior:
          SnackBarBehavior.floating, // Floating behavior for custom height
    ),
  );
}
