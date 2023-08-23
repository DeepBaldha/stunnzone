import 'package:stunnzone/widgets/appbar_widgets.dart';
import 'package:stunnzone/widgets/yellow_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class EditStore extends StatefulWidget {
  final dynamic data;

  const EditStore({Key? key, required this.data}) : super(key: key);

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final ImagePicker _picker = ImagePicker();
  dynamic _pickedImageError;
  XFile? imageFileLogo;
  XFile? imageFileCover;

  void pickStoreLogo() async {
    try {
      final pickStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileLogo = pickStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      // ignore: avoid_print
      print(_pickedImageError);
    }
  }

  void pickCoverImage() async {
    try {
      final pickedCoverImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileCover = pickedCoverImage;
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
      body: Column(children: [
        Column(
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
                Column(children: [
                  YellowButton(
                      width: 0.25,
                      onPressed: () {
                        pickStoreLogo();
                      },
                      label: 'Change'),
                  const SizedBox(height: 10),
                  imageFileLogo == null
                      ? const SizedBox()
                      : YellowButton(
                          width: 0.25,
                          onPressed: () {
                            setState(() {
                              imageFileLogo = null;
                            });
                          },
                          label: 'Reset')
                ]),
                imageFileLogo == null
                    ? const SizedBox()
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(imageFileLogo!.path)),
                      ),
              ],
            ),
            const Padding(
                padding: EdgeInsets.all(8),
                child: Divider(
                  thickness: 2.5,
                  color: Colors.yellow,
                )),
          ],
        ),
        Column(children: [
          const Text('Cover Image',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.data['coverImage']),
                radius: 60,
              ),
              Column(children: [
                YellowButton(
                    width: 0.25,
                    onPressed: () {
                      pickCoverImage();
                    },
                    label: 'Change'),
                const SizedBox(height: 10),
                imageFileCover == null
                    ? const SizedBox()
                    : YellowButton(
                        width: 0.25,
                        onPressed: () {
                          setState(() {
                            imageFileCover = null;
                          });
                        },
                        label: 'Reset')
              ]),
              imageFileCover == null
                  ? const SizedBox()
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(File(imageFileCover!.path)),
                    ),
            ],
          ),
          const Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 2.5,
                color: Colors.yellow,
              )),
        ]),
        TextFormField(decoration: textFormDecoration)
      ]),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: '',
  hintText: '',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.yellow,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2)),
);
