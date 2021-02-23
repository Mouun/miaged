import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final List<String> images;
  final int price;
  final String size;
  final String category;
  final String brand;
  final String condition;
  final String color;

  Product({
    this.id,
    this.title,
    this.description,
    this.images,
    this.price,
    this.size,
    this.category,
    this.brand,
    this.condition,
    this.color,
  });

  factory Product.fromSnap(QueryDocumentSnapshot productSnap) {
    return Product(
      id: productSnap.data()['id'],
      title: productSnap.data()['title'],
      description: productSnap.data()['description'],
      images: productSnap.data()['images'].cast<String>(),
      price: productSnap.data()['price'],
      size: productSnap.data()['size'],
      category: productSnap.data()['category'],
      brand: productSnap.data()['brand'],
      condition: productSnap.data()['condition'],
      color: productSnap.data()['color'],
    );
  }
}
