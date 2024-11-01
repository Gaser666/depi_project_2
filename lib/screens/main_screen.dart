import 'package:ecommerce_app/screens/pages/home_page.dart';
import 'package:ecommerce_app/screens/pages/search_page.dart';
import 'package:ecommerce_app/screens/pages/shopping_cart.dart';
import 'package:ecommerce_app/screens/pages/profile_page.dart';
import 'package:ecommerce_app/screens/widgets/app_constants.dart';
import 'package:ecommerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  List<dynamic> _products = [];

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  fetchProducts() async {
    EcommerceServices services = EcommerceServices();
    _products = await services.fetchProducts();
    setState(() {
      _products;
    });
    print(_products.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        selectedItemColor: AppConstants.kPrimaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomePage(
            products: _products,
          ),
          const SearchPage(),
          ShoppingCart(
            products: _products,
          ),
          const ProfilePage(),
        ],
      ),
    );
  }
}
