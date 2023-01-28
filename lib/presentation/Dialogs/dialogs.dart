import 'package:flutter/material.dart';
import 'package:yallabaity/application/enums/dialog_types.dart';
import 'package:yallabaity/presentation/widgets/custom_dialog.dart';
BuildContext? dialogContext;
void showCustomDialog(BuildContext context,{String? message}) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) {
    dialogContext = context;
    return CustomDialog(message: message,dialogType: DialogTypes.LOADING,);
  },
);
dismissCustomDialog()=>Navigator.pop(dialogContext!);