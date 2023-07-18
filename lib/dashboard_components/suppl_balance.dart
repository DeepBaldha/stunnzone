import 'package:flutter/material.dart';
import 'package:stunnzone/widgets/appbar_widgets.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTItle(title: 'Balance'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
