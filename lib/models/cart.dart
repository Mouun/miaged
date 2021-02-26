import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/models/product.dart';

class Cart {
  final String uid;
  final List<Product> products;

  Cart({
    this.uid,
    this.products,
  });

  factory Cart.fromSnap(QueryDocumentSnapshot cartSnap, List<Product> cartItems) {
    return Cart(
      uid: cartSnap.data()['uid'],
      products: cartItems,
    );
  }
}
