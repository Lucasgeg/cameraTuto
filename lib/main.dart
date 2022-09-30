import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Toto(title: "Camera app"),
    );
  }
}

class Toto extends StatefulWidget {
  const Toto({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Toto> createState() => _TotoState();
}

class _TotoState extends State<Toto> {
  File? imageFile;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Camera app"),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              (imageFile == null)
                  ? const Text("Aucune image")
                  : Image.file(
                      imageFile!,
                      height: MediaQuery.of(context).size.height / 2,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FloatingActionButton(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: const Icon(Icons.folder)),
                  FloatingActionButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      child: const Icon(Icons.camera))
                ],
              )
            ],
          )),
        ));
  }

  Future pickImage(ImageSource source) async {
    XFile? chosenImage = await picker.pickImage(source: source);
    setState(() {
      if (chosenImage == null) {
        print("nous n'avons pas pu récupérer d'image");
      } else {
        imageFile = File(chosenImage.path);
      }
    });
  }
}
