class MenuModel {
  String name;
  String price;

  MenuModel({required this.name, required this.price});

  MenuModel.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      price = json['price'];

  Map<String, dynamic> toJson() => {"name": name, "price": price};
}
