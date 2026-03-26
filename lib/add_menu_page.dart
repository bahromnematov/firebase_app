import 'package:firebase_app/home_page.dart';
import 'package:firebase_app/model/menu_model.dart';
import 'package:firebase_app/service/rtdb_service.dart';
import 'package:flutter/material.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool isLoading = false;

  void _createMenu() {
    setState(() {
      isLoading = true;
    });
    String name = _nameController.text.trim().toString();
    String price = _priceController.text.trim().toString();

    if (name.isEmpty || price.isEmpty) return;
    _apiCreateMenu(name, price);
  }

  _apiCreateMenu(String name, String price) {
    setState(() {
      isLoading = true;
    });
    MenuModel menu = MenuModel(name: name, price: price);
    RTDBService.addMenu(menu).then(
      (value) => {
        setState(() {
          isLoading = false;
        }),
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("Menu Add", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              "Menu uchun rasm tanlang",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(12),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              "Menu uchun taom nomini kiriting",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 54,
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Masalan: Qiyma Shashlik",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              "Menu uchun taom narxini kiriting",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 54,
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _priceController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Masalan: 40 000 so'm",
                hintStyle: TextStyle(color: Colors.grey),
                suffixText: "so'm",
              ),
            ),
          ),
          SizedBox(height: 50),
          InkWell(
            onTap: () {
              _createMenu();
            },
            child: Container(
              height: 56,
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Saqlash",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
