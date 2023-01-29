import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/error_widget.dart';

class CustomPinCodeTextField extends StatelessWidget {
  final String? Function(String? text)? validator;
  final void Function(String text) onChanged;
  final void Function(String? text)? onSaved;
  final String? message;
  final bool? showError;
  final AlignmentGeometry? alignment;
  const CustomPinCodeTextField({
    Key? key,
    this.validator,
    required this.onChanged,
    this.onSaved,
    this.message,
    this.showError = false,
    this.alignment = Alignment.topLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(//set widgets vertically
      children: [
        PinCodeTextField(
          appContext: context,
          length: 4,
          validator: validator,

          onSaved: onSaved,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          obscureText: false,
          animationType: AnimationType.fade,
          textStyle: const TextStyle(color: Colors.white),
          showCursor: true,
          cursorColor: ColorsManager.white,
          pinTheme: PinTheme(
            fieldHeight: AppWidth.s63 * Constants.width,
            fieldWidth: AppWidth.s63 * Constants.width,
            inactiveColor: ColorsManager.cultured,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(11),
            activeColor: ColorsManager.maximumPurple,
            inactiveFillColor: ColorsManager.cultured,
            selectedFillColor: ColorsManager.maximumPurple,
            selectedColor: ColorsManager.maximumPurple,
            activeFillColor: ColorsManager.maximumPurple,
          ),
          autoDismissKeyboard: true,
          enablePinAutofill: true,
          enableActiveFill: true,
        ),
        CustomErrorWidget(
          alignment: alignment,
          visible: showError!,
          message: message,
        )
      ],
    );
  }
}
