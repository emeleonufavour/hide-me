import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/text_widget.dart';

class SeeMessageScreen extends StatefulWidget {
  const SeeMessageScreen({super.key});

  @override
  State<SeeMessageScreen> createState() => _SeeMessageScreenState();
}

class _SeeMessageScreenState extends State<SeeMessageScreen> {
  File? _selectedImageFile;
  final ImagePicker picker = ImagePicker();
  void onPickPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.decal,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xfff45b56), Color(0xffe32922)],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [TextWidget(title: "Woah")]),
        ),
      ),
    );
  }
}
