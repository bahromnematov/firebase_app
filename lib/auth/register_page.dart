import 'package:firebase_app/auth/login_page.dart';
import 'package:firebase_app/home_page.dart';
import 'package:firebase_app/service/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
  bool isLoading = false;

  void register() {
    setState(() {
      isLoading = true;
    });
    String name = _nameController.text.trim().toString();
    String email = _emailController.text.trim().toString();
    String password = _passwordController.text.trim().toString();
    String confirmpassword = _cpasswordController.text.trim().toString();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Qaysidir parametr tuldirilmagan")),
      );
    }
    if (password != confirmpassword) return;

    AuthService.register(name, email, password).then((value) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                "Full Name",
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "John",
                    contentPadding: EdgeInsetsGeometry.all(12),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
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
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 30,
                    ),
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
                  controller: _cpasswordController,
                  decoration: InputDecoration(
                    hintText: "**********",
                    contentPadding: EdgeInsetsGeometry.all(12),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.safety_check,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.black))
                : InkWell(
                    onTap: () {
                      register();
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
                        child: Text(
                          "Create Account",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.orange.shade800,
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
      ),
    );
  }
}
