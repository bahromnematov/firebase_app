import 'package:firebase_app/add_menu_page.dart';
import 'package:firebase_app/model/menu_model.dart';
import 'package:firebase_app/service/auth_service.dart';
import 'package:firebase_app/service/rtdb_service.dart';
import 'package:flutter/foundation.dart';
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
        centerTitle: true,
        title: Text(
          "Foodee",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      floatingActionButton: kIsWeb
          ? SizedBox()
          : FloatingActionButton(
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
                return Container(
                  height: 170,
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: items[index].image == ""
                                  ? NetworkImage(
                                      "https://images.unsplash.com/photo-1594322436404-5a0526db4d13?q=80&w=2629&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                    )
                                  : NetworkImage(items[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                items[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${items[index].price} so'm",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color: Colors.cyanAccent.shade100
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.cyanAccent.shade700,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+ Qo'shish",
                                        style: TextStyle(
                                          color: Colors.cyanAccent.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
