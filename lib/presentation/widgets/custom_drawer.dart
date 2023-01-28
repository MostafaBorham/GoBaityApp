import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yallabaity/application/extensions.dart';
import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/items/drawer_items.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/fonts_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  void Function(ItemModel item)? _onTap;
  CustomDrawer({required Function(ItemModel item) onTap, super.key}) {
    _onTap = onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppWidth.s70 * Constants.width),
      child: Drawer(
        width: double.maxFinite,
        child: Column(
          //set widgets vertically
          children: [
            DrawerHeaderWidget(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: AppHeight.s40 * Constants.height,
                  left: AppWidth.s41 * Constants.width,
                  right: AppWidth.s41 * Constants.width,
                ),
                child: ListView.builder(
                  itemCount: DrawerItems.all.length,
                  itemBuilder: (context, index) {
                    if (DrawerItems.all[index].title ==
                        DrawerItems.addFood.title) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: AppHeight.s15 * Constants.height),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        ColorsManager.black.withOpacity(0.07),
                                    blurRadius: 15,
                                    spreadRadius: 1)
                              ]),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: AppWidth.s27 * Constants.width),
                            title: Text(
                              AppStrings.translate(AppStrings.addFood),
                              style: getSemiBoldStyle(
                                  color: ColorsManager.maximumPurple,
                                  fontSize: AppWidth.s17 * Constants.width),
                            ),
                            trailing: SvgPicture.asset(
                              AssetsManager.add,
                              color: ColorsManager.maximumPurple,
                            ),
                            onTap: () => _onTap!(DrawerItems.all[index]),
                          ),
                        ),
                      );
                    }
                    return ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 0,
                        leading: SvgPicture.asset(
                          DrawerItems.all[index].icon!,
                          color: ColorsManager.maximumPurple,
                        ),
                        title: Text(
                          AppStrings.translate(DrawerItems.all[index].title),
                          style: getSemiBoldStyle(
                            color: ColorsManager.chineseBlack,
                            fontSize: AppWidth.s17 * Constants.width,
                          ),
                        ),
                        selectedColor: ColorsManager.cultured,
                        minLeadingWidth: 0,
                        onTap: () => _onTap!(DrawerItems.all[index]));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
