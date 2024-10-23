// import 'package:flutter/cupertino.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDarkMode = false;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       title: 'Product Catalog',
//       theme: CupertinoThemeData(
//         primaryColor: CupertinoColors.systemBlue,
//         brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//       ),
//       home: ProductCatalogPage(
//         isDarkMode: _isDarkMode,
//         onToggleDarkMode: () {
//           setState(() {
//             _isDarkMode = !_isDarkMode;
//           });
//         },
//       ),
//     );
//   }
// }

// class ProductListPage extends StatelessWidget {
//   final bool isDarkMode;
//   final VoidCallback onToggleDarkMode;

//   const ProductListPage({
//     super.key,
//     required this.isDarkMode,
//     required this.onToggleDarkMode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: const Text('Product Catalog'),
//         trailing: CupertinoSwitch(
//           value: isDarkMode,
//           onChanged: (value) => onToggleDarkMode(),
//         ),
//       ),
//       child: const ProductList(),
//     );
//   }
// }

// // Product, ProductList and other classes remain unchanged.

// class Product {
//   final int id;
//   final String title;
//   final double price;
//   final String description;
//   final String image;
//   final String category;

//   Product({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.image,
//     required this.category,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'] as int,
//       title: json['title'] as String,
//       price: (json['price'] as num).toDouble(),
//       description: json['description'] as String,
//       image: json['image'] as String,
//       category: json['category'] as String,
//     );
//   }
// }

// class ProductCatalogPage extends StatelessWidget {
//   final bool isDarkMode;
//   final VoidCallback onToggleDarkMode;

//   const ProductCatalogPage({
//     super.key,
//     required this.isDarkMode,
//     required this.onToggleDarkMode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text('Product Catalog'),
//       ),
//       child: ProductList(),
//     );
//   }
// }

// class ProductList extends StatefulWidget {
//   const ProductList({super.key});

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   late Future<List<Product>> _productsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _productsFuture = fetchProducts();
//   }

//   Future<List<Product>> fetchProducts() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://fakestoreapi.com/products'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonList = jsonDecode(response.body);
//         return jsonList.map((json) => Product.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load products: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Network error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Product>>(
//       future: _productsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CupertinoActivityIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   CupertinoIcons.exclamationmark_triangle,
//                   color: CupertinoColors.destructiveRed,
//                   size: 60,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Error: ${snapshot.error}',
//                   style: const TextStyle(color: CupertinoColors.destructiveRed),
//                 ),
//                 const SizedBox(height: 16),
//                 CupertinoButton(
//                   onPressed: () {
//                     setState(() {
//                       _productsFuture = fetchProducts();
//                     });
//                   },
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text('No products found'),
//           );
//         }

//         return CustomScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           slivers: [
//             CupertinoSliverRefreshControl(
//               onRefresh: () async {
//                 setState(() {
//                   _productsFuture = fetchProducts();
//                 });
//                 await _productsFuture;
//               },
//             ),
//             SliverSafeArea(
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     final product = snapshot.data![index];
//                     return CupertinoListSection.insetGrouped(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       children: [
//                         GestureDetector(
//                           onTap: () => _showProductDetails(context, product),
//                           child: Container(
//                             color: CupertinoColors.systemBackground,
//                             padding: const EdgeInsets.all(12),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     product.image,
//                                     width: 80,
//                                     height: 80,
//                                     fit: BoxFit.cover,
//                                     loadingBuilder:
//                                         (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return const SizedBox(
//                                         width: 80,
//                                         height: 80,
//                                         child: Center(
//                                           child: CupertinoActivityIndicator(),
//                                         ),
//                                       );
//                                     },
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return const SizedBox(
//                                         width: 80,
//                                         height: 80,
//                                         child: Icon(CupertinoIcons.photo),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         product.title,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         '\$${product.price.toStringAsFixed(2)}',
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           color: CupertinoColors.systemBlue,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         product.category,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           color: CupertinoColors.secondaryLabel,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const CupertinoListTileChevron(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                   childCount: snapshot.data!.length,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showProductDetails(BuildContext context, Product product) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           middle: const Text('Product Details'),
//           leading: CupertinoButton(
//             padding: EdgeInsets.zero,
//             child: const Text('Done'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Image.network(
//                     product.image,
//                     height: 200,
//                     fit: BoxFit.contain,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return const SizedBox(
//                         height: 200,
//                         child: Center(
//                           child: CupertinoActivityIndicator(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   product.title,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   '\$${product.price.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: CupertinoColors.systemBlue,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Category: ${product.category}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: CupertinoColors.secondaryLabel,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Description',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   product.description,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/cupertino.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDarkMode = false;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       title: 'SHOP',
//       theme: CupertinoThemeData(
//         primaryColor: CupertinoColors.systemBlue,
//         brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: ProductCatalogPage(
//         isDarkMode: _isDarkMode,
//         onToggleDarkMode: () {
//           setState(() {
//             _isDarkMode = !_isDarkMode;
//           });
//         },
//       ),
//     );
//   }
// }

// class ProductCatalogPage extends StatelessWidget {
//   final bool isDarkMode;
//   final VoidCallback onToggleDarkMode;

//   const ProductCatalogPage({
//     super.key,
//     required this.isDarkMode,
//     required this.onToggleDarkMode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text(
//           'GARMENTS & JEWELERY',
//           style: TextStyle(
//             color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
//           ),
//         ),
//         trailing: CupertinoSwitch(
//           value: isDarkMode,
//           onChanged: (value) => onToggleDarkMode(),
//         ),
//       ),
//       child: const ProductList(),
//     );
//   }
// }

// class Product {
//   final int id;
//   final String title;
//   final double price;
//   final String description;
//   final String image;
//   final String category;

//   Product({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.image,
//     required this.category,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'] as int,
//       title: json['title'] as String,
//       price: (json['price'] as num).toDouble(),
//       description: json['description'] as String,
//       image: json['image'] as String,
//       category: json['category'] as String,
//     );
//   }
// }

// class ProductList extends StatefulWidget {
//   const ProductList({super.key});

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   late Future<List<Product>> _productsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _productsFuture = fetchProducts();
//   }

//   Future<List<Product>> fetchProducts() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://fakestoreapi.com/products'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonList = jsonDecode(response.body);
//         return jsonList.map((json) => Product.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load products: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Network error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Product>>(
//       future: _productsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CupertinoActivityIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   CupertinoIcons.exclamationmark_triangle,
//                   color: CupertinoColors.destructiveRed,
//                   size: 60,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Error: ${snapshot.error}',
//                   style: const TextStyle(color: CupertinoColors.destructiveRed),
//                 ),
//                 const SizedBox(height: 16),
//                 CupertinoButton(
//                   onPressed: () {
//                     setState(() {
//                       _productsFuture = fetchProducts();
//                     });
//                   },
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text('No products found'),
//           );
//         }

//         return CustomScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           slivers: [
//             CupertinoSliverRefreshControl(
//               onRefresh: () async {
//                 setState(() {
//                   _productsFuture = fetchProducts();
//                 });
//                 await _productsFuture;
//               },
//             ),
//             SliverSafeArea(
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     final product = snapshot.data![index];
//                     return CupertinoListSection.insetGrouped(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       children: [
//                         GestureDetector(
//                           onTap: () => _showProductDetails(context, product),
//                           child: Container(
//                             color: CupertinoColors.systemBackground,
//                             padding: const EdgeInsets.all(12),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     product.image,
//                                     width: 80,
//                                     height: 80,
//                                     fit: BoxFit.cover,
//                                     loadingBuilder:
//                                         (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return const SizedBox(
//                                         width: 80,
//                                         height: 80,
//                                         child: Center(
//                                           child: CupertinoActivityIndicator(),
//                                         ),
//                                       );
//                                     },
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return const SizedBox(
//                                         width: 80,
//                                         height: 80,
//                                         child: Icon(CupertinoIcons.photo),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         product.title,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         '\$${product.price.toStringAsFixed(2)}',
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           color: CupertinoColors.systemBlue,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         product.category,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           color: CupertinoColors.secondaryLabel,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const CupertinoListTileChevron(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                   childCount: snapshot.data!.length,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showProductDetails(BuildContext context, Product product) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           middle: const Text('Product Details'),
//           leading: CupertinoButton(
//             padding: EdgeInsets.zero,
//             child: const Text('Done'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Image.network(
//                     product.image,
//                     height: 200,
//                     fit: BoxFit.contain,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return const SizedBox(
//                         height: 200,
//                         child: Center(
//                           child: CupertinoActivityIndicator(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   product.title,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   '\$${product.price.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: CupertinoColors.systemBlue,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Category: ${product.category}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: CupertinoColors.secondaryLabel,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Description',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   product.description,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'SHOP',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: ProductCatalogPage(
        isDarkMode: _isDarkMode,
        onToggleDarkMode: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
      ),
    );
  }
}

class ProductCatalogPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  const ProductCatalogPage({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'GARMENTS & JEWELERY',
          style: TextStyle(
            color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
        trailing: CupertinoSwitch(
          value: isDarkMode,
          onChanged: (value) => onToggleDarkMode(),
        ),
      ),
      child: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<List<Map<String, dynamic>>>? _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();//
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.exclamationmark_triangle,
                  color: CupertinoColors.destructiveRed,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: CupertinoColors.destructiveRed),
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      _productsFuture = fetchProducts();
                    });
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
        }

        return CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                setState(() {
                  _productsFuture = fetchProducts();
                });
                await _productsFuture;
              },
            ),
            SliverSafeArea(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = snapshot.data![index];
                    return CupertinoListSection.insetGrouped(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      children: [
                        GestureDetector(
                          onTap: () => _showProductDetails(context, product),
                          child: Container(
                            color: CupertinoColors.systemBackground,
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product['image'],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Center(
                                          child: CupertinoActivityIndicator(),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Icon(CupertinoIcons.photo),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['title'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${(product['price'] as num).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: CupertinoColors.systemBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product['category'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: CupertinoColors.secondaryLabel,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const CupertinoListTileChevron(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: snapshot.data!.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Product Details'),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product['image'],
                    height: 200,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product['title'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${(product['price'] as num).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: CupertinoColors.systemBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Category: ${product['category']}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product['description'],
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
