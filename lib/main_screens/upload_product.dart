import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stunnzone/widgets/snackbar.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

List<String> categ = [
  'select category',
  'men',
  'women',
  'shoes',
  'bags',
];

List<String> categMen = [
  'subcategory',
  'shirt',
  't-shirt',
  'jacket',
  'vest',
];

List<String> categWomen = [
  'subcategory',
  'w shirt',
  'w t-shirt',
  'w jacket',
  'w vest',
];

List<String> categShoes = [
  'subcategory',
  'sh shirt',
  'sh t-shirt',
  'sh jacket',
  'sh vest',
];

List<String> categBags = [
  'subcategory',
  'b shirt',
  'b t-shirt',
  'b jacket',
  'b vest',
];

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  String mainCategValue = 'select category';
  String subCategValue = 'subcategory';
  List<String> subCategList = [];

  final ImagePicker _picker = ImagePicker();

  List<XFile>? imagesFileList = [];
  dynamic _pickedImageError;

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imagesFileList = pickedImages;
      });
    } catch (e) {
      setState(() {
        print(_pickedImageError);
      });
    }
  }

  Widget previewImage() {
    if (imagesFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imagesFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imagesFileList![index].path));
          });
    } else {
      return const Center(
        child: Text(
          'you have not \n \n picked images yet !',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }

  void uploadProduct() {
    if (_formKey.currentState!.validate()) {
      if (imagesFileList!.isNotEmpty) {
        _formKey.currentState!.save();
        print('valid');
        print(price);
        print(quantity);
        print(proName);
        print(proDesc);
        setState(() {
          imagesFileList = [];
        });
        _formKey.currentState!.reset();
      } else {
        MyMessageHandler.showSnackBar(_scaffoldKey, 'Pick images first');
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, 'Some error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    //double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.blueGrey.shade100,
                        height: width * 0.5,
                        width: width * 0.5,
                        child: imagesFileList != null
                            ? previewImage()
                            : const Center(
                                child: Text(
                                  'you have not \n \n picked images yet !',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                      ),
                      Column(
                        children: [
                          const Text('select main category'),
                          DropdownButton(
                              value: mainCategValue,
                              items:
                                  categ.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value == 'men') {
                                  subCategList = categMen;
                                } else if (value == 'women') {
                                  subCategList = categWomen;
                                } else if (value == 'shoes') {
                                  subCategList = categShoes;
                                }
                                setState(() {
                                  mainCategValue = value.toString();
                                  subCategValue = 'subcategory';
                                });
                              }),
                          const Text('select sub category'),
                          DropdownButton(
                              value: subCategValue,
                              items: subCategList
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  subCategValue = value.toString();
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width * 0.38,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter price';
                          } else if (value.isValidPrice() != true) {
                            return 'not valid price';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Price',
                          hintText: 'peice.. \$',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width * 0.45,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter quantity';
                          } else if (value.isValidQuantity() != true) {
                            return 'not valid quantity';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Quantity',
                          hintText: 'add quantity',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter product name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proName = value!;
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Product Name',
                          hintText: 'enter product name',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter product description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proDesc = value!;
                        },
                        maxLength: 800,
                        maxLines: 5,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Product Description',
                          hintText: 'enter product description',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: imagesFileList!.isEmpty
                  ? () {
                      pickProductImages();
                    }
                  : () {
                      setState(() {
                        imagesFileList = [];
                      });
                    },
              backgroundColor: Colors.yellow,
              child: imagesFileList!.isEmpty
                  ? const Icon(
                      Icons.photo_library,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.delete_forever,
                      color: Colors.black,
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                uploadProduct();
              },
              backgroundColor: Colors.yellow,
              child: const Icon(
                Icons.upload,
                color: Colors.black,
              ),
            ),
          ],
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

extension QuallityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.])||([0][\.]))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
