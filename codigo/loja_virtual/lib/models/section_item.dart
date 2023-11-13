class SectionItem {

    SectionItem.fromMap(Map<String, dynamic> map){
      image = map['image'] as String;
      product = map['product'] as String?;
      category = map['category'] as String?;

    }

    String? image;
    String? product;
    String? category;

    @override
     String toString() {
      return 'SectionItem{image: $image, product: $product, category: $category}';
    }
}