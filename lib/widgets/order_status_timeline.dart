import 'package:flutter/material.dart';
import '../models/order.dart';
import '../theme/app_theme.dart';

/// Vertical checklist-style timeline showing order progress, e.g.:
/// ✓ Order Placed, ✓ Confirmed, ○ Out For Delivery, ○ Delivered.
class OrderStatusTimeline extends StatelessWidget {
  final Order order;

  const OrderStatusTimeline({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final steps = Order.timelineSteps;
    final currentIndex = steps.indexOf(order.status);

    return Column(
      children: List.generate(steps.length, (index) {
        final isCompleted = order.isCancelled ? false : index <= currentIndex;
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? AppColors.success : AppColors.surface,
                    border: Border.all(
                      color: isCompleted ? AppColors.success : AppColors.border,
                      width: 1.4,
                    ),
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 36,
                    color: isCompleted ? AppColors.success : AppColors.border,
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                steps[index].label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isCompleted ? FontWeight.w700 : FontWeight.w500,
                  color: isCompleted ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
