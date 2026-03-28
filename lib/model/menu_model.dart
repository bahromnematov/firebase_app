class MenuModel {
  String name;
  String price;
  String image;

  MenuModel({required this.name, required this.price, required this.image});

  MenuModel.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      price = json['price'],
      image = json['image'];

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "image": image,
  };
}
