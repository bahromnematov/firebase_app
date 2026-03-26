import 'package:firebase_app/auth/register_page.dart';
import 'package:firebase_app/home_page.dart';
import 'package:firebase_app/service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void login() {
    setState(() {
      isLoading = true;
    });
    String email = _emailController.text.trim().toString();
    String password = _passwordController.text.trim().toString();
    if (email.isEmpty || password.isEmpty) return;
    try {
      AuthService.login(email, password).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) {
              return HomePage();
            },
          ),
        );
      });
    } catch (e) {
      print("hello");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Email yoki Password xato")));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Culinary Editorial",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              "Exprence the Digital Maitre D",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Phone or Email",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.only(right: 20, left: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.shade300,
            ),
            child: Center(
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "admin@gmail.com",
                  contentPadding: EdgeInsetsGeometry.all(12),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person, color: Colors.grey, size: 30),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.only(right: 20, left: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.shade300,
            ),
            child: Center(
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "**********",
                  contentPadding: EdgeInsetsGeometry.all(12),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock, color: Colors.grey, size: 30),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              login();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade900,
                    Colors.orange.shade800,
                    Colors.orange.shade700,
                    Colors.orange.shade600,
                    Colors.orange.shade500,
                  ],
                ),
              ),
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return RegisterPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
