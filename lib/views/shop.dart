import 'package:flutter/material.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/category.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/services/categories.service.dart';
import 'package:miaged/services/products.service.dart';
import 'package:miaged/views/offer_details.dart';
import 'package:miaged/widgets/authentified_appbar.dart';
import 'package:miaged/widgets/categories_row.dart';
import 'package:miaged/widgets/loading_indicator.dart';
import 'package:miaged/widgets/shop/product_card.dart';

import '../locators.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Future<ShopViewData> viewData;
  ProductsService _productsService = locator<ProductsService>();
  CategoriesService _categoriesService = locator<CategoriesService>();

  int selectedCategoryIndex = 0;

  Future<ShopViewData> fetchScreenData() async {
    List<Product> products = await _productsService.getAllProducts();
    List<Category> categories = await _categoriesService.getAllCategories();
    return ShopViewData(products: products, categories: categories);
  }

  Future<void> _handleRefresh() async {
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
                      onRefresh: _handleRefresh,
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

  ShopViewData({this.products, this.categories});
}
