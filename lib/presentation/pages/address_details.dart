import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallabaity/application/app_failures/app_errors.dart';
import 'package:yallabaity/domain/entities/requests_entites/address_entity.dart';
import 'package:yallabaity/injection_container.dart' as di;
import 'package:geocoding/geocoding.dart';
import 'package:yallabaity/network_layer/models/data_models/address_model.dart';
import 'package:yallabaity/presentation/Dialogs/dialogs.dart';
import 'package:yallabaity/presentation/manager/cubit_errors/errors_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_user_manager/cubit_user.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/pages/checkout_screen.dart';
import 'package:yallabaity/presentation/widgets/my_current_location_details_widget.dart';
import 'package:yallabaity/presentation/widgets/linear_gradient_body.dart';
import 'package:yallabaity/presentation/widgets/custom_checkbox.dart';
import 'package:yallabaity/presentation/widgets/custom_textfield.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';

class AddressDetailsScreen extends StatelessWidget {
  static const String placeKey = 'place from map ';
  AddressDetailsScreen({Key? key}) : super(key: key);
  Placemark? place;
  AddressModel userAddress = AddressModel(userId: 1);
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      place = arguments[placeKey] as Placemark;
      debugPrint(place!.street);
    }
    return LinearGradientBody(
      appbarTitle: 'Address Details',
      showCart: false,
      onBackPressed: () {
        Navigator.pop(context);
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppWidth.s30 * Constants.width),
            child: Column(
              //set widgets vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppHeight.s45 * Constants.height,
                ),
                MyCurrentLocationDetails(
                  governorate: place!.administrativeArea,
                  city: place!.subAdministrativeArea!,
                  street: place!.street,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Change',
                        style: getMediumStyle(
                            fontSize: AppWidth.s14 * Constants.width,
                            color: ColorsManager.maximumPurple),
                      ),
                    )),
                SizedBox(
                  height: AppHeight.s16 * Constants.height,
                ),
                BlocProvider<ErrorsManagerCubit>(
                  create: (BuildContext context) => ErrorsManagerCubit(),
                  child: BlocBuilder<ErrorsManagerCubit, ErrorsManagerState>(
                    builder: (context, state) => Form(
                        key: formKey,
                        child: Column(
                          //set widgets vertically
                          children: [
                            CustomTextField(
                              hintText: 'street',
                              showError: ErrorsManagerCubit.contains(
                                  context, AppErrors.street),
                              message: ErrorsManagerCubit.getErrorMessage(
                                  context, AppErrors.street),
                              validator: (text) {
                                if (text!.isEmpty || text.length < 20) {
                                  ErrorsManagerCubit.addErrorType(
                                      context, AppErrors.street);
                                }
                                return null;
                              },
                              onSaved: (text) {
                                userAddress.street = text;
                              },
                              onChanged: (text) {
                                if (ErrorsManagerCubit.contains(
                                    context, AppErrors.street)) {
                                  ErrorsManagerCubit.removeError(
                                      context, AppErrors.street);
                                }
                              },
                            ),
                            SizedBox(
                              height: AppHeight.s19 * Constants.height,
                            ),
                            CustomTextField(
                              hintText: 'Building Name/Number',
                              isNumber: true,
                              showError: ErrorsManagerCubit.contains(
                                  context, AppErrors.buildingName),
                              message: ErrorsManagerCubit.getErrorMessage(
                                  context, AppErrors.buildingName),
                              validator: (text) {
                                if (text!.isEmpty || text.length < 3) {
                                  ErrorsManagerCubit.addErrorType(
                                      context, AppErrors.buildingName);
                                }
                                return null;
                              },
                              onSaved: (text) {
                                userAddress.buildingNo = int.parse(text!);
                              },
                              onChanged: (text) {
                                if (ErrorsManagerCubit.contains(
                                    context, AppErrors.buildingName)) {
                                  ErrorsManagerCubit.removeError(
                                      context, AppErrors.buildingName);
                                }
                              },
                            ),
                            SizedBox(
                              height: AppHeight.s19 * Constants.height,
                            ),
                            CustomTextField(
                              hintText: 'Floor',
                              isNumber: true,
                              showError: ErrorsManagerCubit.contains(
                                  context, AppErrors.floor),
                              message: ErrorsManagerCubit.getErrorMessage(
                                  context, AppErrors.floor),
                              validator: (text) {
                                if (text!.isEmpty || text.length < 3) {
                                  ErrorsManagerCubit.addErrorType(
                                      context, AppErrors.floor);
                                }
                                return null;
                              },
                              onSaved: (text) {
                                userAddress.floor = int.parse(text!);
                              },
                              onChanged: (text) {
                                if (ErrorsManagerCubit.contains(
                                    context, AppErrors.floor)) {
                                  ErrorsManagerCubit.removeError(
                                      context, AppErrors.floor);
                                }
                              },
                            ),
                            SizedBox(
                              height: AppHeight.s19 * Constants.height,
                            ),
                            CustomTextField(
                              hintText: 'apartment no',
                              isNumber: true,
                              showError: ErrorsManagerCubit.contains(
                                  context, AppErrors.apartmentNumber),
                              message: ErrorsManagerCubit.getErrorMessage(
                                  context, AppErrors.apartmentNumber),
                              validator: (text) {
                                if (text!.isEmpty || text.length < 3) {
                                  ErrorsManagerCubit.addErrorType(
                                      context, AppErrors.apartmentNumber);
                                }
                                return null;
                              },
                              onSaved: (text) {
                                userAddress.apartmentNo = int.parse(text!);
                              },
                              onChanged: (text) {
                                if (ErrorsManagerCubit.contains(
                                    context, AppErrors.apartmentNumber)) {
                                  ErrorsManagerCubit.removeError(
                                      context, AppErrors.apartmentNumber);
                                }
                              },
                            ),
                            SizedBox(
                              height: AppHeight.s30 * Constants.height,
                            ),
                            BlocConsumer<UserCubit, UserState>(
                              listener: (context, state) {
                                debugPrint('address Listener');
                                if (state is UserFailedSaveAddressState) {
                                  dismissCustomDialog();
                                  showCustomDialog(context,
                                      message: state.message);
                                  Timer(Duration(milliseconds: Constants.dm2),
                                      () {
                                    dismissCustomDialog();
                                  });
                                }
                                if (state is UserSavingAddressState) {
                                  showCustomDialog(context,
                                      message: 'Loading ...');
                                }
                                if (state is UserSavedAddressState) {
                                  dismissCustomDialog();
                                  Navigator.pushNamed(
                                    context,
                                    Routes.checkoutRoute,
                                  );
                                }
                              },
                              builder: (context, state) => SizedBox(
                                width: double.maxFinite,
                                child: CustomButton(
                                  text: 'Save Address',
                                  onPressed: () {
                                    formKey.currentState!.validate();
                                    if (!ErrorsManagerCubit.hasErrors(
                                        context)) {
                                      formKey.currentState!.save();
                                      UserCubit.saveUserAddressEvent(
                                          context, userAddress);
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
