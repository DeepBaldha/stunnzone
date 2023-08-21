import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stunnzone/widgets/appbar_widgets.dart';
import 'package:stunnzone/widgets/yellow_button.dart';

class EditStore extends StatefulWidget {
  final dynamic data;

  const EditStore({Key? key, required this.data}) : super(key: key);

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final ImagePicker _picker = ImagePicker();
  dynamic _pickedImageError;
  XFile? _imageFileLogo;

  void pickStoreLogo() async {
    try {
      final pickStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFileLogo = pickStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      // ignore: avoid_print
      print(_pickedImageError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBarBackButton(),
        title: const AppBarTItle(
          title: 'Edit Store',
        ),
      ),
      body: Column(
        children: [
          const Text('Store Logo',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.data['storeLogo']),
                radius: 60,
              ),
              YellowButton(
                  width: 0.25,
                  onPressed: () {
                    pickStoreLogo();
                  },
                  label: 'Change'),
              CircleAvatar(
                radius: 60,
                backgroundImage: FileImage(File(_imageFileLogo!.path)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
