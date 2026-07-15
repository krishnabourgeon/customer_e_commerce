// import 'package:customer_e_commerce/dummy_data/dummy_categories.dart';
// import 'package:customer_e_commerce/dummy_data/dummy_products.dart';
// import 'package:customer_e_commerce/dummy_data/dummy_stores.dart';
// import 'package:customer_e_commerce/models/category.dart';
// import 'package:customer_e_commerce/screens/product/product_details_screen.dart';
// import 'package:customer_e_commerce/screens/store/store_details_screen.dart';
// import 'package:customer_e_commerce/screens/store/store_listing_screen.dart';
// import 'package:customer_e_commerce/theme/app_theme.dart';
// import 'package:customer_e_commerce/widgets/banner_carousel.dart';
// import 'package:customer_e_commerce/widgets/category_item.dart';
// import 'package:customer_e_commerce/widgets/product_card.dart';
// import 'package:customer_e_commerce/widgets/section_header.dart';
// import 'package:customer_e_commerce/widgets/store_card.dart';
// import 'package:flutter/material.dart';


// /// Main e-commerce dashboard: location/greeting header, search bar,
// /// banner carousel, categories, popular stores and a "Products For You"
// /// grid — matching the Amazon/Flipkart/Blinkit-style layout.
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? _selectedCategoryId;

//   @override
//   Widget build(BuildContext context) {
//     final filteredProducts = _selectedCategoryId == null
//         ? dummyProducts
//         : dummyProducts
//             .where((p) => p.category ==
//                 dummyCategories.firstWhere((c) => c.id == _selectedCategoryId).name)
//             .toList();

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on, color: AppColors.primary, size: 20),
//                         const SizedBox(width: 4),
//                         Expanded(
//                           child: Text(
//                             'Kakkanad, Kochi',
//                             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
//                         const SizedBox(width: 8),
//                         Container(
//                           height: 38,
//                           width: 38,
//                           decoration: BoxDecoration(
//                             color: AppColors.surface,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(Icons.notifications_none_rounded, size: 20),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Hello Aditya 👋',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                     ),
//                     const Text(
//                       'What are you looking for today?',
//                       style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
//                     ),
//                     const SizedBox(height: 16),
//                     _SearchBar(),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//             const SliverToBoxAdapter(child: BannerCarousel()),
//             const SliverToBoxAdapter(child: SizedBox(height: 24)),
//             SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SectionHeader(title: 'Categories'),
//                   const SizedBox(height: 12),
//                   SizedBox(
//                     height: 96,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
//                       itemCount: dummyCategories.length,
//                       separatorBuilder: (_, __) => const SizedBox(width: 12),
//                       itemBuilder: (context, index) {
//                         final Category category = dummyCategories[index];
//                         final isSelected = _selectedCategoryId == category.id;
//                         return CategoryItem(
//                           category: category,
//                           selected: isSelected,
//                           onTap: () => setState(() {
//                             _selectedCategoryId = isSelected ? null : category.id;
//                           }),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SectionHeader(
//                     title: 'Shop by Store',
//                     onSeeAll: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const StoreListingScreen()),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   SizedBox(
//                     height: 110,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
//                       itemCount: dummyStores.length,
//                       separatorBuilder: (_, __) => const SizedBox(width: 12),
//                       itemBuilder: (context, index) {
//                         final store = dummyStores[index];
//                         return StoreCard(
//                           store: store,
//                           horizontal: true,
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => StoreDetailsScreen(store: store)),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // ── Discount Products ────────────────────────────────────────
//                   SizedBox(height: 12,),
//                     SliverToBoxAdapter(
//                       child: Builder(
//                         builder: (context) {
//                           final discountProducts =
//                               dummyProducts.where((p) => p.hasDiscount).toList();

//                           if (discountProducts.isEmpty) return const SizedBox.shrink();

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SectionHeader(title: '🔥 Best Offers'),
//                               const SizedBox(height: 12),
//                               SizedBox(
//                                 height: 220,
//                                 child: ListView.separated(
//                                   scrollDirection: Axis.horizontal,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: AppSpacing.md),
//                                   itemCount: discountProducts.length,
//                                   separatorBuilder: (_, __) => const SizedBox(width: 12),
//                                   itemBuilder: (context, index) {
//                                     final product = discountProducts[index];
//                                     return SizedBox(
//                                       width: 150,
//                                       child: Stack(
//                                         children: [
//                                           ProductCard(
//                                             product: product,
//                                             onTap: () => Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (_) =>
//                                                     ProductDetailsScreen(product: product),
//                                               ),
//                                             ),
//                                           ),
//                                           // % OFF badge
//                                           Positioned(
//                                             top: 8,
//                                             left: 8,
//                                             child: Container(
//                                               padding: const EdgeInsets.symmetric(
//                                                   horizontal: 7, vertical: 3),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.red,
//                                                 borderRadius: BorderRadius.circular(6),
//                                               ),
//                                               child: Text(
//                                                 '${product.discountPercent?.toInt() ?? 0}% OFF',
//                                                 style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 10,
//                                                   fontWeight: FontWeight.w700,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(height: 24),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   const SizedBox(height: 24),
//                   SectionHeader(title: _selectedCategoryId == null ? 'Products For You' : 'Filtered Products'),
//                   const SizedBox(height: 12),
//                 ],
//               ),
//             ),
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
//               sliver: SliverGrid(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 14,
//                   crossAxisSpacing: 14,
//                   childAspectRatio: 0.66,
//                 ),
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     final product = filteredProducts[index];
//                     return ProductCard(
//                       product: product,
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
//                       ),
//                     );
//                   },
//                   childCount: filteredProducts.length,
//                 ),
//               ),
//             ),
//             const SliverToBoxAdapter(child: SizedBox(height: 24)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SearchBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(AppRadius.md),
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: 'Search products, stores...',
//           prefixIcon: Icon(Icons.search_rounded, color: AppColors.textSecondary),
//           border: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }






import 'package:customer_e_commerce/dummy_data/dummy_categories.dart';
import 'package:customer_e_commerce/dummy_data/dummy_products.dart';
import 'package:customer_e_commerce/dummy_data/dummy_stores.dart';
import 'package:customer_e_commerce/models/category.dart';
import 'package:customer_e_commerce/screens/product/product_details_screen.dart';
import 'package:customer_e_commerce/screens/store/store_details_screen.dart';
import 'package:customer_e_commerce/screens/store/store_listing_screen.dart';
import 'package:customer_e_commerce/theme/app_theme.dart';
import 'package:customer_e_commerce/widgets/banner_carousel.dart';
import 'package:customer_e_commerce/widgets/category_item.dart';
import 'package:customer_e_commerce/widgets/product_card.dart';
import 'package:customer_e_commerce/widgets/section_header.dart';
import 'package:customer_e_commerce/widgets/store_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategoryId;
  String? _selectedStoreId;

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _selectedCategoryId == null
        ? dummyProducts
        : dummyProducts
            .where((p) =>
                p.category ==
                dummyCategories
                    .firstWhere((c) => c.id == _selectedCategoryId)
                    .name)
            .toList();

    final storeProducts = _selectedStoreId == null
        ? <dynamic>[]
        : dummyProducts
            .where((p) => p.storeId == _selectedStoreId)
            .toList();

    final selectedStore = _selectedStoreId == null
        ? null
        : dummyStores.firstWhere((s) => s.id == _selectedStoreId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ──────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.sm, AppSpacing.md, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: AppColors.primary, size: 20),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Kakkanad, Kochi',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded,
                            color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                              Icons.notifications_none_rounded,
                              size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Hello Aditya 👋',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      'What are you looking for today?',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    _SearchBar(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ── Banner ───────────────────────────────────────────────
            const SliverToBoxAdapter(child: BannerCarousel()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // ── Categories ───────────────────────────────────────────
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Categories'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 96,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md),
                      itemCount: dummyCategories.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final Category category = dummyCategories[index];
                        final isSelected =
                            _selectedCategoryId == category.id;
                        return CategoryItem(
                          category: category,
                          selected: isSelected,
                          onTap: () => setState(() {
                            _selectedCategoryId =
                                isSelected ? null : category.id;
                          }),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // ── Shop by Store (chip row) ──────────────────────────────
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: 'Shop by Store',
                    onSeeAll: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StoreListingScreen()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md),
                      itemCount: dummyStores.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final store = dummyStores[index];
                        final isSelected = _selectedStoreId == store.id;
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedStoreId =
                                isSelected ? null : store.id;
                          }),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    store.imageUrl,
                                    height: 18,
                                    width: 18,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const SizedBox(width: 18),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  store.name,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Store Products (shown when store is selected) ──
                  if (_selectedStoreId != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'From ${selectedStore?.name ?? ''}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StoreDetailsScreen(
                                    store: selectedStore!),
                              ),
                            ),
                            child: Text(
                              'See Store',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    storeProducts.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.md, vertical: 16),
                            child: Text(
                              'No products available for this store.',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13),
                            ),
                          )
                        : SizedBox(
                            height: 220,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md),
                              itemCount: storeProducts.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final product = storeProducts[index];
                                return SizedBox(
                                  width: 150,
                                  child: ProductCard(
                                    product: product,
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ProductDetailsScreen(
                                                product: product),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    const SizedBox(height: 24),
                  ],

                  // ── Discount Products ─────────────────────────────
                  Builder(
                    builder: (context) {
                      final discountProducts = dummyProducts
                          .where((p) => p.hasDiscount)
                          .toList();

                      if (discountProducts.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeader(title: '🔥 Best Offers'),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 220,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md),
                              itemCount: discountProducts.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final product = discountProducts[index];
                                return SizedBox(
                                  width: 150,
                                  child: Stack(
                                    children: [
                                      ProductCard(
                                        product: product,
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ProductDetailsScreen(
                                                    product: product),
                                          ),
                                        ),
                                      ),
                                      // % OFF badge
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 7,
                                                  vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            '${product.discountPercent?.toInt() ?? 0}% OFF',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),

                  // ── Popular Stores ────────────────────────────────
                  // SectionHeader(
                  //   title: 'Popular Stores',
                  //   onSeeAll: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => const StoreListingScreen()),
                  //   ),
                  // ),
                  // const SizedBox(height: 12),
                  // SizedBox(
                  //   height: 110,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.horizontal,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: AppSpacing.md),
                  //     itemCount: dummyStores.length,
                  //     separatorBuilder: (_, __) =>
                  //         const SizedBox(width: 12),
                  //     itemBuilder: (context, index) {
                  //       final store = dummyStores[index];
                  //       return StoreCard(
                  //         store: store,
                  //         horizontal: true,
                  //         onTap: () => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (_) =>
                  //                   StoreDetailsScreen(store: store)),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(height: 24),

                  // ── Products For You header ───────────────────────
                  SectionHeader(
                    title: _selectedCategoryId == null
                        ? 'Products For You'
                        : 'Filtered Products',
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            // ── Products Grid ────────────────────────────────────────
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.66,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailsScreen(product: product)),
                      ),
                    );
                  },
                  childCount: filteredProducts.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search products, stores...',
          prefixIcon: Icon(Icons.search_rounded,
              color: AppColors.textSecondary),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}