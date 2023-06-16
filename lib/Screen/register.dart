import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logindemoapp/main.dart';

import 'login.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    width: 500,
                    height: 200,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 20),
                    width: 500,
                    height: 180,
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "New Account",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    )),
              ],
            ),
            LoginDown(),
          ],
        ),
      ),
    );
  }
}

class LoginDown extends StatefulWidget {
  const LoginDown({super.key});

  @override
  State<LoginDown> createState() => _LoginDownState();
}

class _LoginDownState extends State<LoginDown> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();

  TextEditingController Pass = TextEditingController();
  TextEditingController Username = TextEditingController();
  bool obsectrue = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: Form(
        key: _formkey,
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
                hintText: "Enter UserName",
                hintStyle: TextStyle(color: Color.fromARGB(96, 116, 116, 116)),
                labelText: "UserName",
                labelStyle: TextStyle(fontSize: 23, color: Colors.black)),
            controller: Username,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a UserName";
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
                if (_formkey.currentState!.validate()) {
                  regi(Email.text, Pass.text, Username.text);
                }
              },
              child: Text("Register Account")),
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
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  child: Text(
                    "SignIn",
                    // style: TextStyle(color: colourpink),
                  ))
            ],
          )
        ]),
      ),
    );
  }

  void regi(String email, String passs, String username) {
    try {
      FirebaseAuth userrr = FirebaseAuth.instance;
      userrr
          .createUserWithEmailAndPassword(email: email, password: passs)
          .then((value) {
        var user = FirebaseAuth.instance.currentUser;
        CollectionReference ref =
            FirebaseFirestore.instance.collection("loginappdemo");
        ref.doc(user!.uid).set({
          "Emailid": email,
          "Password": passs,
          "Username": username,
          "imageurl": null,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Register successful" + email)));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
