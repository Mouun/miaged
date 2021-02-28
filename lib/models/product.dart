class Product {
  final String firebaseRef;
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
    this.firebaseRef,
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

  factory Product.fromSnap(dynamic productSnap, String firebaseRef) {
    return Product(
      firebaseRef: firebaseRef,
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
