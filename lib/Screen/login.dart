import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logindemoapp/Screen/homesreen.dart';

import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(child: LoginDown()),
    );
  }
}

class LoginDown extends StatefulWidget {
  const LoginDown({super.key});

  @override
  State<LoginDown> createState() => _LoginDownState();
}

class _LoginDownState extends State<LoginDown> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController Pass = TextEditingController();

  bool obsectrue = true;
  // bool obsecfalse = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 247, 32, 32))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                hintText: "Enter Email Or Gmail",
                hintStyle: TextStyle(color: Color.fromARGB(96, 116, 116, 116)),
                labelText: "Email Address",
                labelStyle: TextStyle(fontSize: 23, color: Colors.black)),
            controller: Email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a Email";
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            obscureText: obsectrue,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsectrue = !obsectrue;
                      });
                    },
                    icon: Icon(
                        obsectrue ? Icons.visibility : Icons.visibility_off)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 247, 32, 32))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                hintText: "Password",
                hintStyle: TextStyle(color: Color.fromARGB(96, 116, 116, 116)),
                labelText: "Password",
                labelStyle: TextStyle(fontSize: 23, color: Colors.black)),
            controller: Pass,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a Password";
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(207, 207, 10, 76))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  loginn(Email.text, Pass.text);
                }
              },
              child: Text("Sign In")),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "or ",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Regis()));
                  },
                  child: Text(
                    "Signup".toUpperCase(),
                    // style: TextStyle(color: colourpink),
                  )),
            ],
          )
        ]),
      ),
    );
  }

  void loginn(String email, String pass) async {
    try {
      FirebaseFirestore kk = FirebaseFirestore.instance;
      FirebaseAuth userrr = FirebaseAuth.instance;
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
