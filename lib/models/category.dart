import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String label;

  Category({this.label});

  factory Category.fromSnap(QueryDocumentSnapshot categorySnap) {
    return Category(label: categorySnap.data()['label']);
  }
}
