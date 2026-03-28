import 'dart:io';

import 'package:firebase_app/home_page.dart';
import 'package:firebase_app/model/menu_model.dart';
import 'package:firebase_app/service/rtdb_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  bool isLoading = false;
  File? _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        const snackBar = SnackBar(content: Text('Gallerydan rasm tanlanmadi!'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void _createMenu() {
    setState(() {
      isLoading = true;
    });
    String name = _nameController.text.trim().toString();
    String price = _priceController.text.trim().toString();
    String image = _imageController.text.trim().toString();

    if (name.isEmpty || price.isEmpty || image.isEmpty) return;
    _apiCreateMenu(name, price, image);
  }

  _apiCreateMenu(String name, String price, String image) {
    setState(() {
      isLoading = true;
    });
    MenuModel menu = MenuModel(name: name, price: price, image: image);
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
            onTap: () {
              _getImage();
            },
            child: Container(
              margin: EdgeInsets.all(12),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _image == null
                  ? Center(
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                    )
                  : Image.file(_image!, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              "Menu uchun taom rasmini kiriting",
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
              controller: _imageController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Masalan: https:///shajdh",
                hintStyle: TextStyle(color: Colors.grey),
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
