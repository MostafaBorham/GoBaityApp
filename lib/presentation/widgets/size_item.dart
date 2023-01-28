import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yallabaity/application/app_failures/app_errors.dart';
import 'package:yallabaity/application/extensions.dart';
import 'package:yallabaity/network_layer/models/data_models/size_model.dart';
import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/manager/cubit_errors/errors_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_size_item/size_item_edit_cubit.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_tile_%20button.dart';

import 'package:yallabaity/presentation/widgets/two_buttons_selected_widget.dart';
import 'package:yallabaity/presentation/widgets/single_select_drop_down_menu.dart';
import 'package:yallabaity/presentation/widgets/custom_textfield.dart';

class SizeItem extends StatelessWidget {
  List<ItemModel>? sizes;
  bool? isLoaded;
  SizeModel? foodSize;
  void Function(SizeModel? sizeModel)? onSave;
  void Function()? onCancel;
  void Function(SizeModel? sizeModel)? onEdit;

  SizeItem({
    required this.sizes,
    this.isLoaded = false,
    this.onSave,
    this.onCancel,
    required this.foodSize,
    this.onEdit,
    Key? key,
  }) : super(key: key);

  String? title;
  String? description;
  String? price;
  int? id;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  int? index = 0;

  @override
  Widget build(BuildContext context) {
    id = sizes![0].id;
    title = sizes![0].title;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ErrorsManagerCubit(),
        ),
        BlocProvider(
          create: (context) => SizeItemCubit(),
        )
      ],
      child: BlocBuilder<SizeItemCubit, SizeItemState>(
        builder: (BuildContext context, state) {
          if (state is SaveSizeItemState || state is EditSizeItemState) {
            if (foodSize!.sizeDescription != null) {
              _descriptionController.text = foodSize!.sizeDescription!;
              description = foodSize!.sizeDescription;
            }
            if (foodSize!.sizeId != null) {
              id =foodSize!.sizeId!;
              title = sizes![sizes!.indexWhere(
                      (element) => element.id == foodSize!.sizeId!)]
                  .title;
            }
            index = sizes!.indexWhere(
                (element) => element.id == int.parse(foodSize!.sizeId!.toString()));
            sizes![0].active = false;
            sizes![index!].active = true;
            sizes![sizes!.indexWhere(
                    (element) => element.id == foodSize!.sizeId!)]
                .active = true;
          }
          if (state is EditSizeItemState) {
            if (foodSize!.price != null) {
              _priceController.text = foodSize!.price!.toString();
            }
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: state is EditSizeItemState || state is AddSizeItemState
                ? Form(
                    key: formState,
                    child: Column(//set widgets vertically
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s10 * Constants.width,
                          ),
                          child: _buildDropDown(),
                        ),
                        SizedBox(
                          height: AppHeight.s15 * Constants.height,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s10 * Constants.width,
                          ),
                          child: _buildDescription(),
                        ),
                        SizedBox(
                          height: AppHeight.s15 * Constants.height,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s10 * Constants.width,
                          ),
                          child: Row(// set widgets horizontally
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: AppWidth.s137 * Constants.width,
                                child: _buildPrice(),
                              ),
                              SizedBox(
                                width: AppWidth.s11 * Constants.width,
                              ),
                              Text(
                                AppStrings.translate(AppStrings.egp),
                                style: getSemiBoldStyle(
                                    color: ColorsManager.eerieBlack,
                                    fontSize: AppWidth.s17 * Constants.width),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.s15 * Constants.height,
                        ),
                        TwoButtonsSelectWidget(
                          btn1Text: state is EditSizeItemState
                              ? AppStrings.translate(AppStrings.edit.capitalizeFirst!)
                              : AppStrings.translate(AppStrings.save.capitalizeFirst!),
                          btn2Text: AppStrings.translate(AppStrings.cancel.capitalizeFirst!),
                          whichButtonSelected: (button) {
                            _buttonSelected(button, context);
                          },
                        )
                      ],
                    ))
                : CustomTileButton(
                    text: '$title - $description',
                    suffix: Icon(Icons.edit),
                    onTap: () {
                      SizeItemCubit.editSizeItemEvent(context);
                    },
                  ),
          );
        },
      ),
    );
  }

  _buildPrice() => BlocBuilder<ErrorsManagerCubit, ErrorsManagerState>(
        builder: (context, state) {
          return CustomTextField(
            controller: _priceController,
            hintText: AppStrings.translate(AppStrings.price),
            isNumber: true,
            message:
                ErrorsManagerCubit.getErrorMessage(context, AppErrors.price),
            showError: ErrorsManagerCubit.contains(context, AppErrors.price),
            onSaved: (text) => price = text,
            onChanged: (text) {
              if (ErrorsManagerCubit.contains(context, AppErrors.price)) {
                ErrorsManagerCubit.removeError(context, AppErrors.price);
              }
            },
            validator: (text) {
              if (text.isNullOrEmpty &&
                  !ErrorsManagerCubit.contains(context, AppErrors.price)) {
                ErrorsManagerCubit.addErrorType(context, AppErrors.price);
              }
              return null;
            },
          );
        },
      );

  _buildDescription() {
    return BlocBuilder<ErrorsManagerCubit, ErrorsManagerState>(
      builder: (context, state) => CustomTextField(
        controller: _descriptionController,
        hintText: AppStrings.translate(AppStrings.sizeDescription),
        maxLines: 3,
        message:
            ErrorsManagerCubit.getErrorMessage(context, AppErrors.description),
        showError: ErrorsManagerCubit.contains(context, AppErrors.description),
        onSaved: (text) => description = text,
        onChanged: (text) {
          if (ErrorsManagerCubit.contains(context, AppErrors.description)) {
            ErrorsManagerCubit.removeError(context, AppErrors.description);
          }
        },
        validator: (text) {
          if (text.isNullOrEmpty &&
              !ErrorsManagerCubit.contains(context, AppErrors.description)) {
            ErrorsManagerCubit.addErrorType(context, AppErrors.description);
          }
        },
      ),
    );
  }

  _buttonSelected(Button btn, BuildContext context) {
    if (btn == Button.save) {
      formState.currentState!.validate();

      bool hasErrors = ErrorsManagerCubit.hasErrors(context);
      if (!hasErrors && onSave != null) {
       debugPrint('added');
        formState.currentState!.save();
        foodSize!.sizeId = id;
        foodSize!.sizeDescription = description;
        foodSize!.price = double.parse(price!);
        onSave!(foodSize);
        SizeItemCubit.saveSizeItemEvent(context);
      }
    } else if (btn == Button.cancel) {
      if (onCancel != null) {
        onCancel!();
      }
    }
  }

  _buildDropDown() => SingleSelectDropDownMenu(
        list: sizes!,
        isLoaded: true,
        title: title,
        onSelectedItem: (size) {
          id = size.id;
         debugPrint(id.toString());
        },
      );
}
