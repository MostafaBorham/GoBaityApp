import 'package:flutter/material.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/error_widget.dart';

class PhoneTextField extends StatelessWidget {
  final String? Function(String? text)? validator;
  final void Function(String text)? onChanged;
  final void Function(String? text)? onSaved;
  final String? message;
  final bool? showError;
  final AlignmentGeometry? alignment;
  const PhoneTextField({
    super.key,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.message,
    this.showError = false,
    this.alignment = Alignment.topLeft,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(//set widgets vertically
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.whiteGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            cursorColor: ColorsManager.maximumPurple,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: AppHeight.s17*Constants.height),
                hintText: AppStrings.translate(AppStrings.phoneNumber),
                hintStyle: getMediumStyle(
                  color: ColorsManager.graniteGray2,
                  fontSize: AppWidth.s14 * Constants.width,
                ),
                border: InputBorder.none,
                prefixIcon: Row(// set widgets horizontally
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppHeight.s17*Constants.height,
                          bottom: AppHeight.s17*Constants.height,
                          left: AppWidth.s18 * Constants.width,
                          right: AppWidth.s20 * Constants.width),
                      child: Text(
                        '+20',
                        style: getMediumStyle(
                          color: ColorsManager.black,
                          fontSize: AppWidth.s14 * Constants.width,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppHeight.s34*Constants.height,
                      child: const VerticalDivider(
                        color: ColorsManager.gainsboro2,
                        width: 0,
                      ),
                    ),
                    SizedBox(
                      width: AppWidth.s18 * Constants.width,
                    )
                  ],
                )),
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved,
          ),
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
