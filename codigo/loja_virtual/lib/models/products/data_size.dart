class DataSize{

  DataSize.fromMap(Map<String, dynamic>? map){
    if(map != null){
      data = map['data'] as String ;
      price = map['price'] as num;
      stock = map['stock'] as int;
    }
  }

  String? data;
  num? price;
  int? stock;

  bool get hasStock => stock! > 0;

  @override
  String toString() {
    return 'DataSize{data: $data, price: $price, stock: $stock}';
  }
}
