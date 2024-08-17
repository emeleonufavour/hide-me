import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hide_me/services/exceptions.dart';
import 'package:hide_me/services/steganograph.dart';
import 'package:hide_me/ui/widgets/h_textfield.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/h_button.dart';
import '../../widgets/text_widget.dart';
import '../hide_message/widgets/image_box.dart';

class SeeMessageScreen extends StatefulWidget {
  const SeeMessageScreen({super.key});

  @override
  State<SeeMessageScreen> createState() => _SeeMessageScreenState();
}

class _SeeMessageScreenState extends State<SeeMessageScreen> {
  File? _selectedImageFile;
  String? message;
  final bool _loading = false;
  final ImagePicker picker = ImagePicker();
  final TextEditingController _passwordCtr = TextEditingController();

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

  void decodePhoto() async {
    if (_passwordCtr.text.isNotEmpty && _selectedImageFile != null) {
      log("decoding");
      try {
        String? message = await Steganograph.decodeMessage(
            image: _selectedImageFile!,
            password: _passwordCtr.text.toLowerCase());
        log("Password => ${_passwordCtr.text}");
        if (message != null) {
          log(message);
          setState(() {
            this.message = message;
          });
        } else {
          log("message is null");
        }
      } catch (e) {
        HideMeLogger.logWithException(message: "Unable to decode photo", e: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
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
                colors: [Color(0xfff45b56), Color(0xffe32922)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    ImageBox(
                      image: _selectedImageFile,
                      fct: onPickPhoto,
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    HTextfield(
                      label: "Enter the password here",
                      labelColor: Colors.white,
                      hintText: "",
                      textCtr: _passwordCtr,
                    ),
                    HButton(
                      label: "Decode",
                      buttonWidget: _loading
                          ? CircularProgressIndicator(
                              color: Colors.white.withOpacity(0.5),
                            )
                          : null,
                      color: Colors.white.withOpacity(0.5),
                      fct: decodePhoto,
                    ),
                    if (message != null)
                      Column(
                        children: [
                          const TextWidget(
                            title: "Message:",
                            textColor: Colors.white,
                          ),
                          TextWidget(title: message!)
                        ],
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
