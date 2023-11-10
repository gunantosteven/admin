import 'package:admin/shared/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomLoading extends ConsumerWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.black.withOpacity(0.3),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.primary(ref)),
      ),
    );
  }
}
