import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/product.dart';

class ProductsService {
  Future<List<Product>> getAllProducts() async {
    QuerySnapshot productsSnapshot = await FirebaseFirestore.instance
        .collection(kProductsCollectionName)
        .orderBy('id')
        .get();

    return productsSnapshot.docs
        .map((element) => Product.fromSnap(element, element.id))
        .toList();
  }

  Future<Product> getProduct(int productId) async {
    QuerySnapshot productsSnapshot = await FirebaseFirestore.instance
        .collection(kProductsCollectionName)
        .where('id', isEqualTo: productId)
        .get();

    return Product.fromSnap(productsSnapshot.docs.first, productsSnapshot.docs.first.id);
  }
}
