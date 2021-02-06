import 'package:flutter/material.dart';
import 'package:marketapp/provider/cart_provider.dart';
import 'package:marketapp/widgets/all_products.dart';
import 'package:marketapp/widgets/category_card.dart';
import 'package:provider/provider.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar:
            AppBar(title: Text('Home Page'), elevation: 0, actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
              ),
              Positioned(
                left: 5,
                top: 5,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text("${cartProvider.saved.length}"),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
        body: ListView(
          children: <Widget>[
            Center(
              child: Text(
                'Categories',
                style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CategoryCard(),
            Center(
              child: Text(
                'Products',
                style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25),
              ),
            ),
            Container(height: 400, child: AllProducts()),
          ],
        ));
  }
}
