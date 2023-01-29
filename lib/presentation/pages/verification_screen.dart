// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallabaity/application/app_failures/app_errors.dart';
import 'package:yallabaity/application/enums/dialog_types.dart';
import 'package:yallabaity/network_layer/models/data_models/SendOtpWithPhoneModel.dart';
import 'package:yallabaity/network_layer/models/data_models/check_otp_model.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';
import 'package:yallabaity/presentation/manager/cubit_errors/errors_manager_cubit.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_background.dart';
import 'package:yallabaity/presentation/widgets/custom_dialog.dart';
import 'package:yallabaity/presentation/widgets/custom_pincode_textfield.dart';
import 'package:yallabaity/presentation/widgets/custom_subtitle.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_title.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';
import '../manager/cubit_user_manager/cubit_user.dart';

class VerificationScreen extends StatelessWidget {
  static const String userInfo = 'user info';
  static const String userLoginOrRegister = 'login or register';
  String? userLoggedInOrRegister;
  UserModel? user;
  final GlobalKey<FormState> formKey = GlobalKey();
  int? pinCode;
  BuildContext? dialogContext;

  VerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arguments =
        (ModalRoute.of(context))!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      user = arguments[userInfo] as UserModel;
      userLoggedInOrRegister = arguments[userLoginOrRegister];
      debugPrint('here=${user!.phone.toString()}');
      debugPrint('here=$userLoggedInOrRegister');
      UserCubit.sendOtpEvent(
          context, SendOtpModel(userPhone: int.parse(user!.phone!)));
    }
    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: BlocProvider(
        create: (context) => ErrorsManagerCubit(),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            debugPrint(state.runtimeType.toString());

            ///login listener states
            if (state is UserLoggedInState) {
              debugPrint('here= UserLoggedInState');
              Navigator.pop(dialogContext!);
              if (state.userResponseEntity.state!) {
                _showDialog(
                    context: context,
                    message: state.userResponseEntity.message,
                    dialogType: DialogTypes.SUCCESS);
                Timer(const Duration(milliseconds: Constants.dm2), () {
                  Navigator.pop(dialogContext!);
                  Navigator.pushNamed(context, Routes.homeRoute);
                });
              } else {
                _showDialog(
                    context: context,
                    message: state.userResponseEntity.message,
                    dialogType: DialogTypes.ERROR);
                Timer(const Duration(milliseconds: Constants.dm2), () {
                  Navigator.pop(dialogContext!);
                });
              }
            }
            if (state is UserLoginingState) {
              debugPrint('here= UserLoginingState');
              _showDialog(
                  context: context,
                  message: AppStrings.translate(AppStrings.loadingText),
                  dialogType: DialogTypes.LOADING);
            }
            if (state is LoginUserFailedState) {
              debugPrint('here= LoginUserFailedState');
              Navigator.pop(dialogContext!);
              _showDialog(
                  context: context,
                  message: state.message,
                  dialogType: DialogTypes.ERROR);
              Timer(const Duration(milliseconds: Constants.dm2), () {
                Navigator.pop(dialogContext!);
              });
              debugPrint(state.message);
            }

            ///register listener states
            if (state is UserRegisteringState) {
              debugPrint('here= UserRegisteringState');
              _showDialog(
                  context: context,
                  message: AppStrings.translate(AppStrings.loadingText),
                  dialogType: DialogTypes.LOADING);
            }
            if (state is UserRegisteredState) {
              debugPrint('here= UserRegisteredState');
              Navigator.pop(dialogContext!);
              if (state.userResponseEntity.state!) {
                _showDialog(
                    context: context,
                    message: state.userResponseEntity.message,
                    dialogType: DialogTypes.SUCCESS);
                Timer(const Duration(milliseconds: Constants.dm2), () {
                  Navigator.pop(dialogContext!);
                  Navigator.pushNamed(context, Routes.clientLocationRoute);
                });
              } else {
                _showDialog(
                    context: context,
                    message: state.userResponseEntity.message,
                    dialogType: DialogTypes.ERROR);
                Timer(const Duration(milliseconds: Constants.dm2), () {
                  Navigator.pop(dialogContext!);
                });
              }
            }
            if (state is RegisteringUserFailedState) {
              debugPrint('here= RegisteringUserFailedState');
              Navigator.pop(dialogContext!);
              _showDialog(
                  context: context,
                  message: state.message,
                  dialogType: DialogTypes.ERROR);
              Timer(const Duration(milliseconds: Constants.dm2), () {
                Navigator.pop(dialogContext!);
              });
              debugPrint(state.message);
            }

            ///send otp listener states
            if (state is SendedOtpState) {
              debugPrint('here= SendedOtpState');
              pinCode = state.sendOtpResponseEntity.data;
              debugPrint('here= ${pinCode.toString()}');
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: CustomBackground(
                onBackBtnPressed: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    //set widgets vertically
                    children: [
                      SizedBox(
                        height: AppHeight.s31 * Constants.height,
                      ),
                      CustomTitle(
                        text:
                            AppStrings.translate(AppStrings.verificationTitle),
                      ),
                      SizedBox(
                        height: AppHeight.s10 * Constants.height,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s33 * Constants.width),
                        child: CustomRichText(
                          text:
                              '${AppStrings.translate(AppStrings.enterVerificationCodeMessage)}${user!.phone}. ',
                          textBtnColor: ColorsManager.maximumPurple,
                          btnText: AppStrings.translate(
                              AppStrings.reEnterNumberAgain),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.s40 * Constants.height,
                      ),
                      Column(
                        //set widgets vertically
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppWidth.s33 * Constants.width),
                            child: _buildInputFormField(),
                          ),
                          SizedBox(
                            height: AppHeight.s27 * Constants.height,
                          ),
                          CustomRichText(
                            text: AppStrings.translate(
                                AppStrings.didntGetCodeMessage),
                            btnText: AppStrings.translate(AppStrings.resend),
                            onPressed: () {
                              UserCubit.sendOtpEvent(
                                  context,
                                  SendOtpModel(
                                      userPhone: int.parse(user!.phone!)));
                            },
                            textBtnColor: ColorsManager.maximumPurple,
                          ),
                          SizedBox(
                            height: AppHeight.s12 * Constants.height,
                          ),
                          Text(
                            AppStrings.translate(
                                AppStrings.verificationCodeExpirationTime),
                            style: getSemiBoldStyle(
                                fontSize: AppWidth.s20 * Constants.width,
                                color: ColorsManager.eerieBlack),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildInputFormField() => BlocBuilder<ErrorsManagerCubit, ErrorsManagerState>(
        builder: (context, state) {
          debugPrint('rebuild');
          return Form(
            key: formKey,
            child: Column(
              //set widgets vertically
              children: [
                CustomPinCodeTextField(
                  alignment: Alignment.center,
                  showError: ErrorsManagerCubit.contains(
                          context, AppErrors.pinCodeEmpty) ||
                      ErrorsManagerCubit.contains(
                          context, AppErrors.pinCodeInvalid) ||
                      ErrorsManagerCubit.contains(
                          context, AppErrors.pinCodeNotMatch),
                  message: ErrorsManagerCubit.contains(
                          context, AppErrors.pinCodeEmpty)
                      ? ErrorsManagerCubit.getErrorMessage(
                          context, AppErrors.pinCodeEmpty)
                      : ErrorsManagerCubit.contains(
                              context, AppErrors.pinCodeInvalid)
                          ? ErrorsManagerCubit.getErrorMessage(
                              context, AppErrors.pinCodeInvalid)
                          : ErrorsManagerCubit.contains(
                                  context, AppErrors.pinCodeNotMatch)
                              ? ErrorsManagerCubit.getErrorMessage(
                                  context, AppErrors.pinCodeNotMatch)
                              : null,
                  onSaved: (text) {
                    if (text!.isEmpty) {
                      ErrorsManagerCubit.addErrorType(
                          context, AppErrors.pinCodeEmpty);
                      return;
                    } else if (text.length < Constants.pinCodeNumberOfDigits) {
                      ErrorsManagerCubit.addErrorType(
                          context, AppErrors.pinCodeInvalid);
                      return;
                    } else if (int.parse(text) != pinCode) {
                      ErrorsManagerCubit.addErrorType(
                          context, AppErrors.pinCodeNotMatch);
                      return;
                    }
                    // pinCode = text;
                    // checkOtpModel.code=int.parse(pinCode!);
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      ErrorsManagerCubit.addErrorType(
                          context, AppErrors.pinCodeEmpty);
                    } else if (text.length < Constants.pinCodeNumberOfDigits) {
                      ErrorsManagerCubit.addErrorType(
                          context, AppErrors.pinCodeInvalid);
                    } else if (int.parse(text) != pinCode) {
                      ErrorsManagerCubit.addErrorType(
                          context, AppErrors.pinCodeNotMatch);
                    }
                    return null;
                  },
                  onChanged: (text) {
                    debugPrint('change');
                    if (ErrorsManagerCubit.contains(
                        context, AppErrors.pinCodeEmpty)) {
                      ErrorsManagerCubit.removeError(
                          context, AppErrors.pinCodeEmpty);
                    }
                    if (text.length == 4 &&
                        ErrorsManagerCubit.contains(
                            context, AppErrors.pinCodeInvalid)) {
                      ErrorsManagerCubit.removeError(
                          context, AppErrors.pinCodeInvalid);
                    }
                    if (ErrorsManagerCubit.contains(
                        context, AppErrors.pinCodeNotMatch)) {
                      ErrorsManagerCubit.removeError(
                          context, AppErrors.pinCodeNotMatch);
                    }
                  },
                ),
                SizedBox(
                  height: AppHeight.s30 * Constants.height,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      text: AppStrings.translate(AppStrings.submit),
                      onPressed: () {
                        _onSubmitPressed(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

  void _onSubmitPressed(BuildContext context) {
    formKey.currentState!.validate();
    debugPrint(ErrorsManagerCubit.hasErrors(context).toString());
    if (!ErrorsManagerCubit.hasErrors(context)) {
      formKey.currentState!.save();
      if (userLoggedInOrRegister == AppStrings.translate(AppStrings.login)) {
        debugPrint('login process');
        UserCubit.loginUserEvent(
            context: context, phone: user!.phone!, password: user!.password!);
      } else {
        debugPrint('register process');
        UserCubit.registerUserEvent(
          context,
          user!,
        );
      }
    }
  }

  void _showDialog(
          {required BuildContext context,
          String? message,
          required DialogTypes dialogType}) =>
      showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return CustomDialog(
            message: message,
            dialogType: dialogType,
          );
        },
      );
}
