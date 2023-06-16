import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logindemoapp/Screen/login.dart';
import 'package:logindemoapp/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore data = FirebaseFirestore.instance;

  String? _profileImageUrl;

  PlatformFile? pickedFile;
  @override
  void initState() {
    super.initState();

    pic();
  }

  void pic() async {
    var pic = await data
        .collection("loginappdemo")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) =>
            documentSnapshot.get("imageurl"));
    setState(() {
      _profileImageUrl = pic;
    });
  }

  fileupload() async {
    final path = "file/${pickedFile!.name}";
    final file = File(pickedFile!.path!);
    final ref = await FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);
    final downloadUrl = await ref.getDownloadURL();
/////////////////////
    setState(() {
      _profileImageUrl = downloadUrl;
    });
    var id = _auth.currentUser!.uid;
    FirebaseFirestore kk = await FirebaseFirestore.instance;
    kk.collection("loginappdemo").doc(id).update({"imageurl": downloadUrl});
  }

/////////////////
  Future selecfile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      pickedFile = result!.files.first;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("profile updating.....")));
    fileupload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          ElevatedButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              child: Text("logout"))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: CircleAvatar(
                  radius: 80,
                  backgroundImage: _profileImageUrl != null
                      ? CachedNetworkImageProvider(_profileImageUrl!)
                          as ImageProvider<Object>?
                      : AssetImage('assets/profile.png')),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: selecfile,
              child: Text('Choose'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
