import 'package:firebase_app/add_menu_page.dart';
import 'package:firebase_app/model/menu_model.dart';
import 'package:firebase_app/service/auth_service.dart';
import 'package:firebase_app/service/rtdb_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuModel> items = [];
  bool isLoading = false;

  Future<void> _apiMenuList() async {
    setState(() {
      isLoading = true;
    });
    var list = await RTDBService.getMenu();
    items.clear();
    setState(() {
      isLoading = false;
      items = list;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiMenuList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logOut(context);
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return AddMenuPage();
              },
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(
                    items[index].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${RTDBService.formatPrice(items[index].price)} so'm",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
