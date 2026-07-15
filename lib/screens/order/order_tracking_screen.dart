// import 'package:flutter/material.dart';
// import '../../models/order.dart';
// import '../../theme/app_theme.dart';
// import '../../widgets/custom_button.dart';
// import '../../widgets/order_status_timeline.dart';
// import '../main_nav_screen.dart';

// /// Order tracking screen: order id, status timeline, delivery location
// /// card and a track button (simulated map placeholder).
// class OrderTrackingScreen extends StatelessWidget {
//   final Order order;

//   const OrderTrackingScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Track Order')),
//       body: ListView(
//         padding: const EdgeInsets.all(AppSpacing.md),
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: AppColors.success.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(AppRadius.md),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.delivery_dining_rounded, color: AppColors.success, size: 32),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         order.isCancelled ? 'Order Cancelled' : '${order.status.label}!',
//                         style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
//                       ),
//                       Text(
//                         'Order #${order.id}',
//                         style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           const Text('Order Status', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.border),
//               borderRadius: BorderRadius.circular(AppRadius.md),
//             ),
//             child: OrderStatusTimeline(order: order),
//           ),
//           const SizedBox(height: 24),
//           const Text('Delivery Location', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.border),
//               borderRadius: BorderRadius.circular(AppRadius.md),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   height: 120,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColors.surface,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   alignment: Alignment.center,
//                   child: const Icon(Icons.map_outlined, size: 40, color: AppColors.textSecondary),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, color: AppColors.primary, size: 18),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(order.deliveryAddress, style: const TextStyle(fontSize: 13)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 28),
//           if (!order.isCompleted && !order.isCancelled)
//             CustomButton(
//               label: 'Track on Map',
//               icon: Icons.my_location_rounded,
//               onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Live tracking is a UI-only demo'), behavior: SnackBarBehavior.floating),
//               ),
//             ),
//           const SizedBox(height: 12),
//           CustomButton(
//             label: 'Back to Home',
//             outlined: true,
//             onPressed: () => Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (_) => const MainNavScreen()),
//               (route) => false,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:async';
import 'package:customer_e_commerce/models/order.dart';
import 'package:customer_e_commerce/screens/main_nav_screen.dart';
import 'package:customer_e_commerce/service/location_service.dart';
import 'package:customer_e_commerce/theme/app_theme.dart';
import 'package:customer_e_commerce/widgets/custom_button.dart';
import 'package:customer_e_commerce/widgets/order_status_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:geolocator/geolocator.dart';

class OrderTrackingScreen extends StatefulWidget {
  final Order order;
  const OrderTrackingScreen({super.key, required this.order});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // Delivery pin (use real order coordinates in production)
  final LatLng _deliveryLatLng = const LatLng(10.0159, 76.3419);

  LatLng? _userLatLng;
  StreamSubscription<Position>? _positionSub;
  bool _locationLoading = false;
  String? _locationError;
  double? _distanceMeters;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  Future<void> _startTracking() async {
    setState(() { _locationLoading = true; _locationError = null; });
    try {
      final pos = await LocationService.getCurrentPosition();
      if (!mounted) return;
      _updateUserPosition(pos);
      _positionSub = LocationService.positionStream().listen((pos) {
        if (mounted) _updateUserPosition(pos);
      });
    } catch (e) {
      if (mounted) setState(() { _locationError = e.toString(); _locationLoading = false; });
    }
  }

  void _updateUserPosition(Position pos) {
    final latLng = LatLng(pos.latitude, pos.longitude);
    final distance = LocationService.distanceBetween(
      pos.latitude, pos.longitude,
      _deliveryLatLng.latitude, _deliveryLatLng.longitude,
    );
    setState(() { _userLatLng = latLng; _distanceMeters = distance; _locationLoading = false; });
    try {
      _mapController.move(
        LatLng(
          (latLng.latitude + _deliveryLatLng.latitude) / 2,
          (latLng.longitude + _deliveryLatLng.longitude) / 2,
        ),
        13,
      );
    } catch (_) {}
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    super.dispose();
  }

  String _formatDistance(double m) =>
      m >= 1000 ? '${(m / 1000).toStringAsFixed(1)} km away' : '${m.toStringAsFixed(0)} m away';

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Scaffold(
      appBar: AppBar(title: const Text('Track Order')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          // ── Status banner ────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: order.isCancelled
                  ? AppColors.error.withOpacity(0.08)
                  : AppColors.success.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                Icon(
                  order.isCancelled ? Icons.cancel_outlined : Icons.delivery_dining_rounded,
                  color: order.isCancelled ? AppColors.error : AppColors.success,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.isCancelled ? 'Order Cancelled' : '${order.status.label}!',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      Text('Order #${order.id}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                if (_distanceMeters != null && order.isActive)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Distance',
                          style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                      Text(_formatDistance(_distanceMeters!),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.primary)),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Order Status Timeline ────────────────────────────────────
          const Text('Order Status',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: OrderStatusTimeline(order: order),
          ),
          const SizedBox(height: 24),

          // ── Live Map ────────────────────────────────────────────────
          const Text('Delivery Location',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                SizedBox(height: 220, child: _buildMap()),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, color: AppColors.primary, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(order.deliveryAddress,
                              style: const TextStyle(fontSize: 13))),
                        ],
                      ),
                      if (_userLatLng != null && _distanceMeters != null) ...[
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.my_location_rounded, color: AppColors.secondary, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'You are ${_formatDistance(_distanceMeters!)} from delivery point',
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (_locationError != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 16),
                            const SizedBox(width: 6),
                            Expanded(child: Text(_locationError!,
                                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          if (!order.isCompleted && !order.isCancelled) ...[
            CustomButton(
              label: _locationLoading
                  ? 'Detecting Location…'
                  : _locationError != null
                      ? 'Retry Location'
                      : 'Refresh Location',
              icon: Icons.my_location_rounded,
              isLoading: _locationLoading,
              onPressed: _locationLoading ? null : _startTracking,
            ),
            const SizedBox(height: 12),
          ],
          CustomButton(
            label: 'Back to Home',
            outlined: true,
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainNavScreen()),
              (route) => false,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildMap() {
    if (_locationLoading) {
      return Container(
        color: AppColors.surface,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(height: 12),
              Text('Fetching your location…',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ],
          ),
        ),
      );
    }

    final markers = <Marker>[
      // Delivery destination pin
      Marker(
        point: _deliveryLatLng,
        width: 48, height: 48,
        child: const _MapPin(color: AppColors.primary, icon: Icons.location_on),
      ),
      if (_userLatLng != null)
        Marker(
          point: _userLatLng!,
          width: 44, height: 44,
          child: const _MapPin(color: AppColors.secondary, icon: Icons.my_location_rounded),
        ),
    ];

    final initialCenter = _userLatLng != null
        ? LatLng(
            (_userLatLng!.latitude + _deliveryLatLng.latitude) / 2,
            (_userLatLng!.longitude + _deliveryLatLng.longitude) / 2,
          )
        : _deliveryLatLng;

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: 13,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.ecommerce_app',
        ),
        if (_userLatLng != null)
          PolylineLayer(polylines: [
            Polyline(
              points: [_userLatLng!, _deliveryLatLng],
              color: AppColors.primary.withOpacity(0.6),
              strokeWidth: 3,
              //isDotted: true,
            ),
          ]),
        MarkerLayer(markers: markers),
      ],
    );
  }
}

// ── Custom map pin widget ─────────────────────────────────────────────────────

class _MapPin extends StatelessWidget {
  final Color color;
  final IconData icon;
  const _MapPin({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            color: color, shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 6, offset: const Offset(0, 2))],
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        CustomPaint(
          size: const Size(10, 6),
          painter: _TrianglePainter(color: color),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  const _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_TrianglePainter old) => old.color != color;
}