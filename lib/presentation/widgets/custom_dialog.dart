import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yallabaity/application/enums/dialog_types.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/gradient_circular_progress_indicator.dart';

class CustomDialog extends StatelessWidget {
  final String? message;
  final bool? showCircularLoading;
  final DialogTypes dialogType;
  CustomDialog(
      {this.message,
      this.showCircularLoading = true,
      Key? key,
      required this.dialogType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip
          .antiAliasWithSaveLayer, // is used to clip the internal child widget of container when u define border radius,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Container(
        width: double.maxFinite,
        color: ColorsManager.white,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppWidth.s40 * Constants.width),
          child: Column(
            //set widgets vertically
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: AppHeight.s43 * Constants.height,
              ),
              Image.asset(
                AssetsManager.gobaityIcon,
                height: AppHeight.s38 * Constants.height,
                width: AppWidth.s85 * Constants.width,
              ),
              SizedBox(
                height: AppHeight.s20 * Constants.height,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                child: showCircularLoading!
                    ? Column(
                        //set widgets vertically
                        children: [
                          if (dialogType == DialogTypes.LOADING)  GradientCircularProgressIndicator(
                              radius: 24,
                              strokeWidth: 4,
                              gradientColors: [
                                ColorsManager.maximumPurple,
                                ColorsManager.maximumPurple.withOpacity(0)
                              ],
                            )
                          else if (dialogType == DialogTypes.ERROR) Icon(Icons.error_outline,size: AppWidth.s50*Constants.width,color: ColorsManager.maximumPurple,)
                          else  Icon(Icons.done,size: AppWidth.s50*Constants.width,color: ColorsManager.maximumPurple,),
                          SizedBox(
                            height: AppHeight.s20 * Constants.height,
                          ),
                        ],
                      )
                    : null,
              ),
              if (message != null)
                Flexible(
                  child: Text(
                    message!,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      fontSize: AppWidth.s14 * Constants.width,
                      color: ColorsManager.black,
                    ),
                  ),
                ),
              if (message != null)
                SizedBox(
                  height: AppHeight.s20 * Constants.height,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
