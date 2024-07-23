import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:hide_me/services/exceptions.dart';
import 'package:hide_me/services/steganograph.dart';
import 'package:hide_me/ui/views/hide_message/widgets/image_box.dart';
import 'package:hide_me/ui/widgets/h_button.dart';
import 'package:hide_me/ui/widgets/h_textfield.dart';
import 'package:image_picker/image_picker.dart';

class HideMessageScreen extends StatefulWidget {
  HideMessageScreen({super.key});

  @override
  State<HideMessageScreen> createState() => _HideMessageScreenState();
}

class _HideMessageScreenState extends State<HideMessageScreen> {
  File? _selectedImageFile;
  final TextEditingController _secretTextCtr = TextEditingController();
  final TextEditingController _passwordCtr = TextEditingController();

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

  void encodePhoto() async {
    if (_selectedImageFile != null &&
        _passwordCtr.text.isNotEmpty &&
        _secretTextCtr.text.isNotEmpty) {
      try {
        log("Encoding...");
        if (_selectedImageFile != null) {
          await Steganograph.encodeMessageWithIsolate(
              _selectedImageFile!, _secretTextCtr.text, _passwordCtr.text);
        }

        log("Finished");
      } catch (e) {
        log(e.toString());
      }
    } else {
      log("Sth is missing");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.decal,
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xff5c8afd), Color(0xff346dfd)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    ImageBox(
                      image: _selectedImageFile,
                      fct: onPickPhoto,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    HTextfield(
                        label: "Write your secret message: ",
                        labelColor: Colors.white,
                        hintText: "",
                        textCtr: _secretTextCtr),
                    HTextfield(
                        label: "Write your password: ",
                        labelColor: Colors.white,
                        hintText: "",
                        maxLines: 1,
                        textCtr: _passwordCtr),
                    const SizedBox(
                      height: 10,
                    ),
                    HButton(
                      label: "Encode",
                      color: Colors.white.withOpacity(0.5),
                      fct: encodePhoto,
                    ),
                    SizedBox(
                      height: size.height * 0.5,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
