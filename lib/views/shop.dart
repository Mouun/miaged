import 'package:flutter/material.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/cart.dart';
import 'package:miaged/models/category.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/services/carts.service.dart';
import 'package:miaged/services/categories.service.dart';
import 'package:miaged/services/products.service.dart';
import 'package:miaged/views/offer_details.dart';
import 'package:miaged/widgets/authentified_appbar.dart';
import 'package:miaged/widgets/categories_row.dart';
import 'package:miaged/widgets/loading_indicator.dart';
import 'package:miaged/widgets/product_card.dart';

import '../locators.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Future<ShopViewData> viewData;
  ProductsService _productsService = locator<ProductsService>();
  CategoriesService _categoriesService = locator<CategoriesService>();
  CartsService _cartsService = locator<CartsService>();

  int selectedCategoryIndex = 0;

  Future<ShopViewData> fetchScreenData() async {
    List<Product> products = await _productsService.getAllProducts();
    List<Category> categories = await _categoriesService.getAllCategories();
    Cart cart = await _cartsService.getCart();
    return ShopViewData(products: products, categories: categories, cart: cart);
  }

  Future<void> refreshScreenData() async {
    setState(() {
      viewData = fetchScreenData();
    });
  }

  List<Product> getFilteredProductsList(ShopViewData baseData) {
    if (selectedCategoryIndex != 0) {
      return baseData.products
          .where((product) =>
              product.category ==
              baseData.categories[selectedCategoryIndex].label)
          .toList();
    } else {
      return baseData.products;
    }
  }

  isProductInCart(Cart cart, Product product) {
    return cart.products
        .any((element) => element.firebaseRef == product.firebaseRef);
  }

  @override
  void initState() {
    viewData = fetchScreenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthentifiedAppBar(title: 'Boutique'),
      body: FutureBuilder<ShopViewData>(
        future: viewData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> filteredProducts =
                getFilteredProductsList(snapshot.data);
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: CategoriesRow(
                      categories: snapshot.data.categories,
                      handleClickCategory: (index) {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: kMainColor,
                      onRefresh: refreshScreenData,
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding - 8,
                        ),
                        itemCount: filteredProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPadding,
                          crossAxisSpacing: kDefaultPadding,
                          childAspectRatio: 0.5,
                        ),
                        itemBuilder: (context, index) => Material(
                          color: Colors.white,
                          child: ProductCard(
                            product: filteredProducts[index],
                            isInCart: isProductInCart(
                              snapshot.data.cart,
                              filteredProducts[index],
                            ),
                            handleOnTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetailsPage(
                                      product: filteredProducts[index],
                                    );
                                  },
                                ),
                              );
                            },
                            addToCartAction: () async {
                              await _cartsService.addProductToCart(
                                filteredProducts[index].firebaseRef,
                              );
                              refreshScreenData();
                            },
                            removeFromCartAction: () async {
                              await _cartsService.removeProductFromCart(
                                filteredProducts[index].firebaseRef,
                              );
                              refreshScreenData();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}

class ShopViewData {
  List<Product> products;
  List<Category> categories;
  Cart cart;

  ShopViewData({this.products, this.categories, this.cart});
}
