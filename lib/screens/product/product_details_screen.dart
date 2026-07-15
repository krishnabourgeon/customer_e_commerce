import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/rating_badge.dart';
import '../cart/cart_screen.dart';

/// Product details: large image slider, name, rating, description, price,
/// quantity selector and Add To Cart button.
class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();
  int _quantity = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cart = context.watch<CartProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 320,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: product.imageGallery.isEmpty ? 1 : product.imageGallery.length,
                            itemBuilder: (context, index) {
                              final url = product.imageGallery.isEmpty
                                  ? product.imageUrl
                                  : product.imageGallery[index];
                              return Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(color: AppColors.surface),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: SafeArea(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back, size: 18),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ),
                        if (product.imageGallery.length > 1)
                          Positioned(
                            bottom: 12,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: product.imageGallery.length,
                                effect: const WormEffect(
                                  dotHeight: 6,
                                  dotWidth: 6,
                                  activeDotColor: AppColors.primary,
                                  dotColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  product.name,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: RatingBadge(rating: product.rating),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${product.unit} • ${product.ratingCount} ratings',
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹${product.effectivePrice.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                              ),
                              if (product.hasDiscount) ...[
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    '₹${product.price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: AppColors.textSecondary,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    '${product.discountPercent}% OFF',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text('Description', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary, height: 1.5),
                          ),
                          const SizedBox(height: 20),
                          const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => setState(() => _quantity = (_quantity - 1).clamp(1, 99)),
                                icon: const Icon(Icons.remove_circle_outline_rounded),
                                color: AppColors.primary,
                              ),
                              Text('$_quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                              IconButton(
                                onPressed: () => setState(() => _quantity = (_quantity + 1).clamp(1, 99)),
                                icon: const Icon(Icons.add_circle_outline_rounded),
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  icon: Icons.shopping_cart_outlined,
                  label: 'Add To Cart',
                  onPressed: () {
                    cart.addProduct(product, quantity: _quantity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {
                  cart.addProduct(product, quantity: _quantity);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  minimumSize: const Size(52, 52),
                ),
                icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
