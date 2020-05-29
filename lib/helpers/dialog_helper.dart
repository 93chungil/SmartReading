import 'package:flutter/material.dart';
import 'package:smart_reading/dialogs/what_2_write_dialog.dart';

class DialogHelper {
  static exit(context) => showDialog(
        context: context,
        builder: (context) => What2WriteDialog(),
      );
}
