import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final List<String> images;
  final int price;
  final String size;
  final String category;

  Product({this.id, this.title, this.description, this.images, this.price, this.size, this.category});

  factory Product.fromSnap(QueryDocumentSnapshot productSnap) {
    return Product(
        id: productSnap.data()['id'],
        title: productSnap.data()['title'],
        description: productSnap.data()['description'],
        images: productSnap.data()['images'].cast<String>(),
        price: productSnap.data()['price'],
        size: productSnap.data()['size'],
        category: productSnap.data()['category']);
  }
}
