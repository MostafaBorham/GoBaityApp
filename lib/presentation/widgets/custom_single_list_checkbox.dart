import 'package:flutter/material.dart';
import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_appbar.dart';
import 'package:yallabaity/presentation/widgets/custom_single_checkbox.dart';

class CustomSingleListCheckBox extends StatefulWidget {
  List<ItemModel>? _singleCheckBoxList;
  void Function(ItemModel selected)? _onItemSelected;
  int currentSelectedIndex;
  CustomSingleListCheckBox(
      {List<ItemModel>? singleCheckBoxList,
      void Function(ItemModel item)? onItemSelected,
        this.currentSelectedIndex=0,
      Key? key})
      : super(key: key) {
    _singleCheckBoxList = singleCheckBoxList;
    _onItemSelected = onItemSelected;
  }

  @override
  State<CustomSingleListCheckBox> createState() =>
      _CustomSingleListCheckBoxState();
}

class _CustomSingleListCheckBoxState extends State<CustomSingleListCheckBox> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget._singleCheckBoxList!.length,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (widget._singleCheckBoxList![widget.currentSelectedIndex].active) {

          setState(() {
            widget._singleCheckBoxList![widget.currentSelectedIndex].active =
            false;
          });
          }
          setState(() {
            widget._singleCheckBoxList![index].active =
                !widget._singleCheckBoxList![index].active;
          });
          if (widget._singleCheckBoxList![index].active) {

            widget._onItemSelected!(widget._singleCheckBoxList![index]);
            widget.currentSelectedIndex = index;
          }
        },
        child: CustomSingleCheckBox(
          text: widget._singleCheckBoxList![index].title,
          isChecked: widget._singleCheckBoxList![index].active,
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: AppHeight.s29*Constants.height,
      ),
    );
  }

}
