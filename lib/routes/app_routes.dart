import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/main_nav_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/checkout/checkout_screen.dart';
import '../screens/order/my_orders_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/store/store_listing_screen.dart';

/// Centralized named-route table. Screens that need arguments (Store
/// Details, Product Details, Order Tracking) are pushed directly via
/// MaterialPageRoute from within the calling screen instead, since they
/// require passing a specific model instance.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String storeListing = '/stores';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String myOrders = '/orders';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        login: (_) => const LoginScreen(),
        register: (_) => const RegisterScreen(),
        main: (_) => const MainNavScreen(),
        storeListing: (_) => const StoreListingScreen(),
        cart: (_) => const CartScreen(),
        checkout: (_) => const CheckoutScreen(),
        myOrders: (_) => const MyOrdersScreen(),
        profile: (_) => const ProfileScreen(),
      };
}
