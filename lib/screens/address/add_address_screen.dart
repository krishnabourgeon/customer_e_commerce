import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/address.dart';
import '../../providers/address_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _labelCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);

    context.read<AddressProvider>().addAddress(Address(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      label: _labelCtrl.text.trim(),
      fullAddress: _addressCtrl.text.trim(),
    ));
    Navigator.pop(context);
  }

  Future<void> _detectLocation() async {
    final provider = context.read<AddressProvider>();
    await provider.useCurrentLocation();
    if (!mounted) return;

    if (provider.fetchState == LocationFetchState.success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location detected!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.success,
      ));
      Navigator.pop(context); // provider already added & selected it
    } else if (provider.fetchState == LocationFetchState.error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(provider.fetchError),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.error,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFetching = context.watch<AddressProvider>().isFetching;

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Address')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── GPS detect button ──────────────────────────────────
              GestureDetector(
                onTap: isFetching ? null : _detectLocation,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.2),
                  ),
                  child: Row(
                    children: [
                      isFetching
                          ? const SizedBox(
                              width: 22, height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.primary),
                            )
                          : const Icon(Icons.my_location_rounded, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isFetching ? 'Detecting your location…' : 'Use Current Location',
                              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
                            ),
                            const Text('Tap to auto-fill address using GPS',
                                style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Divider ────────────────────────────────────────────
              Row(children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('OR ENTER MANUALLY',
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                ),
                const Expanded(child: Divider()),
              ]),
              const SizedBox(height: 20),

              // ── Manual fields ──────────────────────────────────────
              CustomTextField(
                label: 'Label',
                controller: _labelCtrl,
                hint: 'e.g. Home, Work, Other',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter a label' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Full Address',
                controller: _addressCtrl,
                hint: 'House no., Street, City, PIN',
                maxLines: 3,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter delivery address' : null,
              ),
              const Spacer(),
              CustomButton(label: 'Save Address', isLoading: _saving, onPressed: _save),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}