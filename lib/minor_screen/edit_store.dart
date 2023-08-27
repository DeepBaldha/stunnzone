import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:stunnzone/widgets/appbar_widgets.dart';
import 'package:stunnzone/widgets/yellow_button.dart';
import 'package:stunnzone/widgets/snackbar.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final ImagePicker _picker = ImagePicker();
  dynamic _pickedImageError;
  XFile? imageFileLogo;
  XFile? imageFileCover;
  late String storeName;
  late String phone;
  late String storeLogo;
  late String coverImage;

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

  Future uploadStoreLogo() async {
    if (imageFileLogo != null) {
      try {
        print('logo upload');
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('supl-images/${widget.data['email']}.png');

        await ref.putFile(File(imageFileLogo!.path));
        storeLogo = await ref.getDownloadURL();
      } catch (e) {
        //print(e);
      }
    } else {
      print('logo upload');
      storeLogo = widget.data['storeLogo'];
    }
  }

  Future uploadCoverImage() async {
    if (imageFileCover != null) {
      try {
        firebase_storage.Reference ref2 = firebase_storage
            .FirebaseStorage.instance
            .ref('supl-images/${widget.data['email']}.jpg-cover');

        await ref2.putFile(File(imageFileCover!.path));

        coverImage = await ref2.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      coverImage = widget.data['coverImage'];
      print('Cover Image uploaded');
    }
  }

  saveChanges() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print('In method');
      await uploadStoreLogo().whenComplete(
          () async => uploadCoverImage().whenComplete(() => null));
    } else {
      MyMessageHandler.showSnackBar(scaffoldKey, 'Enter full details first');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const AppBarBackButton(),
            title: const AppBarTItle(
              title: 'Edit Store',
            ),
          ),
          body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                          backgroundImage:
                              NetworkImage(widget.data['storeLogo']),
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
                                backgroundImage:
                                    FileImage(File(imageFileLogo!.path)),
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
                        backgroundImage:
                            NetworkImage(widget.data['coverImage']),
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
                              backgroundImage:
                                  FileImage(File(imageFileCover!.path)),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter store name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        storeName = value!;
                      },
                      initialValue: widget.data['storeName'],
                      decoration: textFormDecoration.copyWith(
                          labelText: 'Store name',
                          hintText: 'Enter store name')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phone = value!;
                      },
                      initialValue: widget.data['phone'],
                      decoration: textFormDecoration.copyWith(
                          labelText: 'phone', hintText: 'Enter phone')),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      YellowButton(
                          width: 0.25,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: 'Cancel'),
                      YellowButton(
                          width: 0.5,
                          onPressed: () {
                            saveChanges();
                          },
                          label: 'Save Changes'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
