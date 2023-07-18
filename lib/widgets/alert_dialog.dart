import 'package:flutter/cupertino.dart';

class MyAlertdialog {
  static void showMyDialg(
      {required BuildContext context,
        required String title,
        required String content,
        required Function() tabYes}) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            onPressed: tabYes,
            isDestructiveAction: true,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
