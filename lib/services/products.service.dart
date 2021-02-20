import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/product.dart';

class ProductsService {
  Future<List<Product>> getAllProducts() async {
    QuerySnapshot productsSnapshot =
        await FirebaseFirestore.instance.collection(kProductsCollectionName).orderBy('id').get();

    return productsSnapshot.docs.map((element) => Product.fromSnap(element)).toList();
  }
}
