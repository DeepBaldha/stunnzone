import 'package:flutter/material.dart';
import 'package:stunnzone/widgets/appbar_widgets.dart';

class EditBusiness extends StatelessWidget {
  const EditBusiness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTItle(title: 'Edit Business'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
