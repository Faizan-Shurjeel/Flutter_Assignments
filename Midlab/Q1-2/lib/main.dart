// import 'package:flutter/material.dart';
// import 'dart:async';

// void main() {
//   runApp(const MyApp());
// }

// // Custom AppBar Widget
// AppBar customAppBar(String title) {
//   return AppBar(
//     title: Text(title),
//     actions: <Widget>[
//       IconButton(
//         icon: const Icon(Icons.favorite),
//         onPressed: () {
//           // action for like button
//         },
//       ),
//       IconButton(
//         icon: const Icon(Icons.search),
//         onPressed: () {
//           // action for search button
//         },
//       ),
//       PopupMenuButton<String>(
//         onSelected: (value) {
//           // action for more button
//         },
//         itemBuilder: (BuildContext context) {
//           return {'Settings', 'Logout'}.map((String choice) {
//             return PopupMenuItem<String>(
//               value: choice,
//               child: Text(choice),
//             );
//           }).toList();
//         },
//       ),
//     ],
//   );
// }

// // Splash Screen Widget
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       const Duration(seconds: 5),
//       () => Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               const MyHomePage(title: 'Flutter Demo Home Page'),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.deepPurple.shade100,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.flutter_dash,
//                 size: 80,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             const SizedBox(height: 30),
//             // Progress Indicator
//             const CircularProgressIndicator(
//               color: Colors.deepPurple,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // MyApp Widget
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.orange,
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const SplashScreen(), // Start with SplashScreen
//     );
//   }
// }

// // MyHomePage Widget
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(widget.title),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// // Product Model
// class Product {
//   final int id;
//   final String title;
//   final double price;
//   final String description;
//   final String image;

//   Product({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.image,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       title: json['title'],
//       price: json['price'].toDouble(),
//       description: json['description'],
//       image: json['image'],
//     );
//   }
// }

// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({super.key});

//   @override
//   State<ProductsScreen> createState() => _ProductsScreenState();
// }

// class _ProductsScreenState extends State<ProductsScreen> {
//   List<Product> products = [];
//   bool isLoading = true;

//   // i) Create fetchData() to make http get request
//   Future<void> fetchData() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://fakestoreapi.com/products'),
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = json.decode(response.body);
//         setState(() {
//           products = jsonData.map((item) => Product.fromJson(item)).toList();
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load products');
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       debugPrint('Error: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   // ii) Create List CardList of Widgets (Cards)
//   Widget buildProductCard(Product product) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AspectRatio(
//             aspectRatio: 16 / 9,
//             child: Image.network(
//               product.image,
//               fit: BoxFit.contain,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   '\$${product.price.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   product.description,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // iii) Display data cards using appropriate Widget Builder
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               padding: const EdgeInsets.all(8),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return buildProductCard(products[index]);
//               },
//             ),
//     );
//   }
// }


// Removed duplicate SplashScreen and HomeScreen classes
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomeScreen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo in the center
            Image.asset(
              'assets/logo.png', // Replace with your logo image
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 30),
            // Circular Progress Indicator
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
