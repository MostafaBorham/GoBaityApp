import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yallabaity/application/app_localization.dart';
import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';


class TwoImageButtonsSwitchWidget extends StatefulWidget {
  final String btn1ImageUrl;
  final String btn2ImageUrl;
  final String btn1Label;
  final String btn2Label;
  TwoImageButtonsSwitchWidget(
      {required this.btn1ImageUrl,
        required this.btn2ImageUrl,
        Key? key, required this.btn1Label, required this.btn2Label})
      : super(key: key);

  @override
  State<TwoImageButtonsSwitchWidget> createState() => _TwoImageButtonsSwitchWidgetState();
}

class _TwoImageButtonsSwitchWidgetState extends State<TwoImageButtonsSwitchWidget> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(// set widgets horizontally
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: Expanded(
            child: Column(
              children: [
                ElevatedButton(
                  child: SvgPicture.asset(widget.btn1ImageUrl,fit: BoxFit.contain,width: AppWidth.s88*Constants.width,height: AppHeight.s58*Constants.height,),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.white,
                      elevation: 5,
                      padding: EdgeInsets.symmetric(
                        vertical: AppHeight.s32 * Constants.height,
                        horizontal: AppHeight.s32 * Constants.height,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                  side: BorderSide(
                    color: selected!=0? ColorsManager.transparent : ColorsManager.maximumPurple
                  ),
                  ),
                  onPressed: () {
                    if (selected != 0) {
                      setState(() {
                        selected = 0;
                      });
                    }
                  },
                ),
                SizedBox(height: AppHeight.s15*Constants.height,),
                AutoSizeText(widget.btn1Label)
              ],
            ),
          ),
        ),
        SizedBox(
          width: Constants.margin,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: Expanded(
            child: Column(
              children: [
                ElevatedButton(
                  child: SvgPicture.asset(widget.btn2ImageUrl,fit: BoxFit.contain,width: AppWidth.s88*Constants.width,height: AppHeight.s58*Constants.height,),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.white,
                    elevation: 5,
                      padding: EdgeInsets.symmetric(
                        vertical: AppHeight.s32 * Constants.height,
                        horizontal: AppHeight.s32 * Constants.height,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    side: BorderSide(
                        color: selected!=1? ColorsManager.transparent : ColorsManager.maximumPurple
                    ),
                  ),
                  onPressed: () {
                    if (selected != 1) {
                      setState(() {
                        selected = 1;
                        AppLocalization.changeLanguage(context);
                      });
                    }
                  },
                ),
                SizedBox(height: AppHeight.s15*Constants.height,),
                AutoSizeText(widget.btn2Label)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
