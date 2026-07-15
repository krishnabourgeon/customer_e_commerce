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
import '../../providers/address_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../order/order_tracking_screen.dart';
import '../address/add_address_screen.dart';
import '../../dummy_data/dummy_orders.dart';

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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => OrderTrackingScreen(order: dummyOrders.first)),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final addrProv = context.watch<AddressProvider>();
    final selectedAddr = addrProv.selectedAddress;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          // ── Delivery Address card ────────────────────────────────────
          const Text('Delivery Address',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40, width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        selectedAddr.label == 'Current Location'
                            ? Icons.my_location_rounded
                            : selectedAddr.label == 'Work'
                                ? Icons.work_outline
                                : Icons.home_outlined,
                        color: AppColors.primary, size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(selectedAddr.label,
                                style: const TextStyle(fontWeight: FontWeight.w700)),
                            if (addrProv.isFetching) ...[
                              const SizedBox(width: 8),
                              const SizedBox(width: 12, height: 12,
                                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary)),
                            ],
                          ]),
                          const SizedBox(height: 2),
                          Text(
                            addrProv.isFetching ? 'Detecting location…' : selectedAddr.fullAddress,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                          if (selectedAddr.latitude != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${selectedAddr.latitude!.toStringAsFixed(4)}, ${selectedAddr.longitude!.toStringAsFixed(4)}',
                              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                            ),
                          ],
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => _showAddressPicker(context, addrProv),
                      child: const Text('Change'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // GPS detect inline button
                GestureDetector(
                  onTap: addrProv.isFetching ? null : () async {
                    await addrProv.useCurrentLocation();
                    if (!mounted) return;
                    if (addrProv.fetchState == LocationFetchState.error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(addrProv.fetchError),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.error,
                      ));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary.withOpacity(0.25)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.my_location_rounded, size: 15, color: AppColors.primary),
                        const SizedBox(width: 6),
                        Text(
                          addrProv.isFetching ? 'Detecting…' : 'Use Current Location',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

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
                _SummaryRow(label: 'Delivery Fee', value: '₹${cart.deliveryFee.toStringAsFixed(0)}'),
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

  void _showAddressPicker(BuildContext context, AddressProvider addrProv) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg))),
      builder: (sheetCtx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivery Address',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    TextButton.icon(
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add New'),
                      onPressed: () {
                        Navigator.pop(sheetCtx);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const AddAddressScreen()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // GPS option row
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: 40, width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.my_location_rounded, color: AppColors.secondary, size: 20),
                  ),
                  title: const Text('Use Current Location',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Detect via GPS automatically',
                      style: TextStyle(fontSize: 12)),
                  trailing: addrProv.isFetching
                      ? const SizedBox(width: 20, height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.secondary))
                      : const Icon(Icons.chevron_right),
                  onTap: () async {
                    Navigator.pop(sheetCtx);
                    await addrProv.useCurrentLocation();
                    if (!mounted) return;
                    if (addrProv.fetchState == LocationFetchState.error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(addrProv.fetchError),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.error,
                      ));
                    }
                  },
                ),
                const Divider(),

                // Saved addresses list
                ...List.generate(addrProv.addresses.length, (index) {
                  final addr = addrProv.addresses[index];
                  final isSelected = addrProv.selectedIndex == index;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 40, width: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.12)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        addr.label == 'Current Location'
                            ? Icons.my_location_rounded
                            : addr.label == 'Work'
                                ? Icons.work_outline
                                : Icons.home_outlined,
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    title: Text(addr.label,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary)),
                    subtitle: Text(addr.fullAddress,
                        maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12)),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: AppColors.primary)
                        : null,
                    onTap: () {
                      addrProv.selectAddress(index);
                      Navigator.pop(sheetCtx);
                    },
                  );
                }),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
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
