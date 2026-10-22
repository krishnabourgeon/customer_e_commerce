// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../dummy_data/dummy_user.dart';
// import '../../providers/cart_provider.dart';
// import '../../theme/app_theme.dart';
// import '../../widgets/custom_button.dart';
// import '../order/order_tracking_screen.dart';
// import '../../dummy_data/dummy_orders.dart';

// enum PaymentMethod { cod, online }

// /// Checkout screen: delivery address card, payment method selection,
// /// order summary and a "Place Order" button.
// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   PaymentMethod _selectedPayment = PaymentMethod.cod;
//   int _selectedAddressIndex = 0;
//   bool _placingOrder = false;

//   Future<void> _placeOrder(BuildContext context) async {
//     setState(() => _placingOrder = true);
//     await Future.delayed(const Duration(milliseconds: 1000));
//     if (!mounted) return;

//     context.read<CartProvider>().clear();
//     setState(() => _placingOrder = false);

//     // Navigate to order tracking for the most recent dummy order to
//     // demonstrate the post-checkout flow, then clear back to Home.
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => OrderTrackingScreen(order: dummyOrders.first)),
//       (route) => route.isFirst,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = context.watch<CartProvider>();
//     final address = dummyAddresses[_selectedAddressIndex];

//     return Scaffold(
//       appBar: AppBar(title: const Text('Checkout')),
//       body: ListView(
//         padding: const EdgeInsets.all(AppSpacing.md),
//         children: [
//           const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.border),
//               borderRadius: BorderRadius.circular(AppRadius.md),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: AppColors.primary.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(Icons.home_outlined, color: AppColors.primary, size: 20),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(address.label, style: const TextStyle(fontWeight: FontWeight.w700)),
//                       const SizedBox(height: 2),
//                       Text(
//                         address.fullAddress,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
//                       ),
//                     ],
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => _showAddressPicker(context),
//                   child: const Text('Change'),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           const Text('Payment Options', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//           const SizedBox(height: 10),
//           _PaymentOptionTile(
//             icon: Icons.payments_outlined,
//             title: 'Cash on Delivery',
//             subtitle: 'Pay when your order arrives',
//             selected: _selectedPayment == PaymentMethod.cod,
//             onTap: () => setState(() => _selectedPayment = PaymentMethod.cod),
//           ),
//           const SizedBox(height: 10),
//           _PaymentOptionTile(
//             icon: Icons.credit_card_rounded,
//             title: 'Online Payment',
//             subtitle: 'UPI, Cards, Net Banking & Wallets',
//             selected: _selectedPayment == PaymentMethod.online,
//             onTap: () => setState(() => _selectedPayment = PaymentMethod.online),
//           ),
//           const SizedBox(height: 24),
//           const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.border),
//               borderRadius: BorderRadius.circular(AppRadius.md),
//             ),
//             child: Column(
//               children: [
//                 ...cart.items.map(
//                   (item) => Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             '${item.product.name} x${item.quantity}',
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontSize: 13),
//                           ),
//                         ),
//                         Text('₹${item.totalPrice.toStringAsFixed(0)}',
//                             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Subtotal', style: TextStyle(color: AppColors.textSecondary)),
//                     Text('₹${cart.subtotal.toStringAsFixed(0)}'),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Delivery Fee', style: TextStyle(color: AppColors.textSecondary)),
//                     Text('₹${cart.deliveryFee.toStringAsFixed(0)}'),
//                   ],
//                 ),
//                 const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider()),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Total', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
//                     Text('₹${cart.total.toStringAsFixed(0)}',
//                         style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 28),
//           CustomButton(
//             label: 'Place Order',
//             isLoading: _placingOrder,
//             onPressed: cart.isEmpty ? null : () => _placeOrder(context),
//           ),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }

//   void _showAddressPicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
//       ),
//       builder: (sheetContext) {
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(AppSpacing.md),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Choose Delivery Address', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
//                 const SizedBox(height: 12),
//                 ...List.generate(dummyAddresses.length, (index) {
//                   final addr = dummyAddresses[index];
//                   return RadioListTile<int>(
//                     value: index,
//                     groupValue: _selectedAddressIndex,
//                     onChanged: (value) {
//                       setState(() => _selectedAddressIndex = value!);
//                       Navigator.pop(sheetContext);
//                     },
//                     title: Text(addr.label, style: const TextStyle(fontWeight: FontWeight.w600)),
//                     subtitle: Text(addr.fullAddress, style: const TextStyle(fontSize: 12)),
//                     activeColor: AppColors.primary,
//                   );
//                 }),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _PaymentOptionTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final bool selected;
//   final VoidCallback onTap;

//   const _PaymentOptionTile({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.6 : 1),
//           borderRadius: BorderRadius.circular(AppRadius.md),
//           color: selected ? AppColors.primary.withOpacity(0.04) : Colors.white,
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: selected ? AppColors.primary : AppColors.textSecondary),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
//                   Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
//                 ],
//               ),
//             ),
//             Radio<bool>(
//               value: true,
//               groupValue: selected,
//               onChanged: (_) => onTap(),
//               activeColor: AppColors.primary,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';

enum PaymentMethod { cod, online }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _selectedPayment = PaymentMethod.cod;
  bool _placingOrder = false;

  Future<void> _placeOrder(BuildContext context) async {
    setState(() => _placingOrder = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    context.read<CartProvider>().clear();
    setState(() => _placingOrder = false);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 56),
            const SizedBox(height: 12),
            const Text('Order Placed!',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 6),
            const Text(
              'Your order has been placed successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: 'Done',
              onPressed: () => Navigator.pop(dialogCtx),
            ),
          ),
        ],
      ),
    );
    if (!mounted) return;
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          // ── Payment Options ──────────────────────────────────────────
          const Text('Payment Options',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          _PaymentOptionTile(
            icon: Icons.payments_outlined,
            title: 'Cash on Delivery',
            subtitle: 'Pay when your order arrives',
            selected: _selectedPayment == PaymentMethod.cod,
            onTap: () => setState(() => _selectedPayment = PaymentMethod.cod),
          ),
          const SizedBox(height: 10),
          _PaymentOptionTile(
            icon: Icons.credit_card_rounded,
            title: 'Online Payment',
            subtitle: 'UPI, Cards, Net Banking & Wallets',
            selected: _selectedPayment == PaymentMethod.online,
            onTap: () => setState(() => _selectedPayment = PaymentMethod.online),
          ),
          const SizedBox(height: 24),

          // ── Order Summary ────────────────────────────────────────────
          const Text('Order Summary',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              children: [
                ...cart.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${item.product.name} x${item.quantity}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13)),
                      ),
                      Text('₹${item.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                )),
                const Divider(),
                _SummaryRow(label: 'Subtotal', value: '₹${cart.subtotal.toStringAsFixed(0)}'),
                const SizedBox(height: 6),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text('₹${cart.total.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          CustomButton(
            label: 'Place Order',
            isLoading: _placingOrder,
            onPressed: cart.isEmpty ? null : () => _placeOrder(context),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// ── Small helper widgets ──────────────────────────────────────────────────────

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Text(value),
      ],
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOptionTile({
    required this.icon, required this.title,
    required this.subtitle, required this.selected, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.6 : 1),
          borderRadius: BorderRadius.circular(AppRadius.md),
          color: selected ? AppColors.primary.withOpacity(0.04) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Radio<bool>(
              value: true, groupValue: selected,
              onChanged: (_) => onTap(),
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
