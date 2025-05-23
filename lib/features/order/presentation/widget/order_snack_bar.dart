import 'package:coffee_shop/uikit/theme/app_colors.dart';
import 'package:flutter/material.dart';

SnackBar orderSnackBar(String message, BuildContext context) {
  return SnackBar(
    backgroundColor: AppColors.neutralThreeDark,
    content: Text(
      message,
      style: Theme.of(context).textTheme.displaySmall,
    ),
  );
}
