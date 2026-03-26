import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:firebase_app/model/menu_model.dart';
import 'package:firebase_database/firebase_database.dart';

class RTDBService {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addMenu(MenuModel menu) async {
    await _database.child("menu").push().set(menu.toJson());
    return _database.onChildAdded;
  }

  static Future<List<MenuModel>> getMenu() async {
    List<MenuModel> menus = [];
    Query _query = _database.ref.child("menu");
    DatabaseEvent event = await _query.once();
    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      var jsonMenu = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonMenu);
      var menu = MenuModel(name: map['name'], price: map['price']);
      menus.add(menu);
    }
    return menus;
  }



 static String formatPrice(String price) {
    final number = int.tryParse(price.replaceAll(" ", "")) ?? 0;
    final formatter = NumberFormat("#,###", "en_US");
    return formatter.format(number).replaceAll(",", " ");
  }
}
