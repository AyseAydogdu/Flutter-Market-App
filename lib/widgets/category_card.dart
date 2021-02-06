import 'package:flutter/material.dart';
import 'package:marketapp/models/categories.dart';
import 'package:marketapp/provider/cart_provider.dart';
import 'package:marketapp/screens/product_page.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCategoriesFromApi();
    List<Categories> categories = cartProvider.getCategories();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: categories != null
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductPage(categories[index]),
                                  ));
                            },
                            child: Container(
                              height: 160,
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(categories[index].imageUrl),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(categories[index].categoryName),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
