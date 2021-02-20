import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/category.dart';

class CategoriesService {
  Future<List<Category>> getAllCategories() async {
    QuerySnapshot categoriesSnapshot =
        await FirebaseFirestore.instance.collection(kCategoriesCollectionName).get();

    List<Category> finalList = categoriesSnapshot.docs.map((element) => Category.fromSnap(element)).toList();
    finalList.insert(0, new Category(label: 'tous'));
    
    return finalList;
  }
}
