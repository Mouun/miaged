import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/cart.dart';
import 'package:miaged/models/product.dart';

class CartsService {
  Future<Cart> getCart() async {
    QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection(kCartCollectionName)
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    List<dynamic> productRefs = cartSnapshot.docs.first.data()['products'];
    List<Product> finalCart = [];
    for (final DocumentReference productRef in productRefs) {
      DocumentSnapshot productRefSnapshot = await productRef.get();
      finalCart.add(Product.fromSnap(productRefSnapshot, productRefSnapshot.id));
    }

    return Cart.fromSnap(cartSnapshot.docs.first, finalCart);
  }

  Future<bool> isInAppUserCart(String firebaseRef) async {
    Cart cart = await getCart();

    cart.products.forEach((product) {
      if (product.firebaseRef == firebaseRef) return true;
    });

    return false;
  }

  Future<void> addProductToCart(String firebaseRef) async {
    QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection(kCartCollectionName)
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    cartSnapshot.docs.first.reference.update({
      'products': FieldValue.arrayUnion(['/$kProductsCollectionName/$firebaseRef'])
    });
  }

  Future<void> removeProductFromCart(String firebaseRef) async {
    QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection(kCartCollectionName)
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    cartSnapshot.docs.first.reference.update({
      'products': FieldValue.arrayRemove(['/$kProductsCollectionName/$firebaseRef'])
    });
  }
}
