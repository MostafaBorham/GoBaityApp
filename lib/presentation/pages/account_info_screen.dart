import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/two_buttons_selected_widget.dart';
import 'package:yallabaity/presentation/widgets/custom_tile_%20button.dart';
import 'package:yallabaity/presentation/widgets/cart_item.dart';
import 'package:yallabaity/presentation/widgets/linear_gradient_body.dart';
import 'package:yallabaity/presentation/widgets/gradient_background.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';

import '../resources/assets_manager.dart';
import '../widgets/two_image_buttons_switch_widget.dart';

class AccountInfoScreen extends StatefulWidget {
  AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  List<ItemModel> genderList = [
    ItemModel(title: 'Male', active: true),
    ItemModel(title: 'Female', active: true),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LinearGradientBody(
      appbarTitle: 'Account Info',
      showCart: false,
      onBackPressed: () {
        Navigator.of(context).pop();
      },
      onCartPressed: () {
        Navigator.pushNamed(
          context,
          Routes.cartRoute,
        );
      },
      child: SafeArea(
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppWidth.s30 * Constants.width),
            child: _buildLanguageWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppHeight.s104*Constants.height,),
        AutoSizeText(AppStrings.translate(AppStrings.selectPreferedLanguage),textAlign: TextAlign.center,style: getRegularStyle(fontSize: 14),),
        SizedBox(height: AppHeight.s108*Constants.height,),
        TwoImageButtonsSwitchWidget(btn1ImageUrl: AssetsManager.britshFlag,btn2ImageUrl: AssetsManager.egyptFlag,btn1Label: 'English',btn2Label: 'العربية'),
      ],
    );
  }

  _buildUserInfoEditWidget() {
    return Column(//set widgets vertically
      children: [
        SizedBox(
          height: AppHeight.s30 * Constants.height,
        ),
        CustomTileButton(text: 'Mohamed Ghitany'),
        SizedBox(
          height: AppHeight.s18*Constants.height,
        ),
        CustomTileButton(text: 'Change phone no.'),
        SizedBox(
          height: AppHeight.s18*Constants.height,
        ),
        CustomTileButton(text: 'Change Password'),
        SizedBox(
          height: AppHeight.s29*Constants.height,
        ),
        TwoButtonsSelectWidget(
          btn1Text: AppStrings.translate(AppStrings.male),
          btn2Text: AppStrings.translate(AppStrings.female),
          whichButtonSelected: (Button btn) {

          },
        ),
        SizedBox(
          height: AppHeight.s8*Constants.height * Constants.height,
        ),
        SizedBox(
          width: double.maxFinite,
          child: CustomButton(
            text: 'Save Changes',
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
