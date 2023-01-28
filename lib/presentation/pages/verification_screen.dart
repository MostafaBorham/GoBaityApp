import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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

import '../../application/app_failures/app_errors.dart';
import '../manager/cubit_user_manager/cubit_user.dart';

class VerificationScreen extends StatelessWidget {
  static const String userInfo = 'user info';
  static const String userLoginOrRegister = 'login or register';
  String? userLoggedInOrRegister;
  UserModel? user;
  bool isUserValidate=false;
  CheckOtpModel checkOtpModel=CheckOtpModel();
  final GlobalKey<FormState> formKey = GlobalKey();
  String? pinCode;
  BuildContext? dialogContext;

  VerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arguments =
        (ModalRoute.of(context))!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      user = arguments[userInfo] as UserModel;
      userLoggedInOrRegister = arguments[userLoginOrRegister];
      UserCubit.sendOtpEvent(context, SendOtpModel(userPhone: int.parse(user!.phone!)));
      checkOtpModel.userPhone=int.parse(user!.phone!);
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
              Navigator.pop(dialogContext!);
              if(state.userResponseEntity.state!){
                _showDialog(context: context,message: state.userResponseEntity.message,dialogType: DialogTypes.SUCCESS);
                Timer(Duration(milliseconds: Constants.dm2), () {
                  Navigator.pop(dialogContext!);
                  Navigator.pushNamed(context, Routes.homeRoute);
                });
              }
              else{
                _showDialog(context: context,message: state.userResponseEntity.message,dialogType: DialogTypes.ERROR);
                Timer(Duration(milliseconds: Constants.dm2), () {
                  Navigator.pop(dialogContext!);
                });
              }
            }
            if(state is UserLoginingState){
              _showDialog(context: context,message: 'Loading...',dialogType: DialogTypes.LOADING);
            }
            if(state is LoginUserFailedState){
              Navigator.pop(dialogContext!);
              _showDialog(context: context,message: state.message,dialogType: DialogTypes.ERROR);
              Timer(Duration(milliseconds: Constants.dm2), () {
                Navigator.pop(dialogContext!);
              });
              debugPrint(state.message);
            }
            ///register listener states
            if (state is UserRegisteringState) {
              _showDialog(context: context,message: 'Loading...',dialogType: DialogTypes.LOADING);
            }
            if (state is UserRegisteredState) {
              Navigator.pop(dialogContext!);
              if(state.userResponseEntity.state!){
                _showDialog(context: context,message: state.userResponseEntity.message,dialogType: DialogTypes.SUCCESS);
                Timer(Duration(milliseconds: Constants.dm2), () {
                  Navigator.pop(dialogContext!);
                  Navigator.pushNamed(context, Routes.clientLocationRoute);
                });
              }
              else{
                _showDialog(context: context,message: state.userResponseEntity.message,dialogType: DialogTypes.ERROR);
                Timer(Duration(milliseconds: Constants.dm2), () {
                  Navigator.pop(dialogContext!);
                });
              }
            }
            if (state is RegisteringUserFailedState) {
              Navigator.pop(dialogContext!);
              _showDialog(context: context,message: state.message,dialogType: DialogTypes.ERROR);
              Timer(Duration(milliseconds: Constants.dm2), () {
                Navigator.pop(dialogContext!);
              });
              debugPrint(state.message);
            }
            ///check otp listener states
            if (state is CheckedOtpState) {
              isUserValidate=state.checkOtpResponseEntity.state!;
              if (userLoggedInOrRegister == AppStrings.login) {
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
                        text: AppStrings.verification,
                      ),
                      SizedBox(
                        height: AppHeight.s10 * Constants.height,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s33 * Constants.width),
                        child: CustomRichText(
                          text:
                              '${AppStrings.enterVerificationCode}${user!.phone}. ',
                          textBtnColor: ColorsManager.maximumPurple,
                          btnText: AppStrings.reEnterNumberAgain,
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
                            text: AppStrings.didntGetCode,
                            btnText: AppStrings.resend,
                            onPressed: (){
                              UserCubit.sendOtpEvent(context, SendOtpModel(userPhone: int.parse(user!.phone!)));
                            },
                            textBtnColor: ColorsManager.maximumPurple,
                          ),
                          SizedBox(
                            height: AppHeight.s12 * Constants.height,
                          ),
                          Text(
                            '00:15',
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
                          context, AppErrors.pinCodeInvalid),
                  message: ErrorsManagerCubit.contains(
                          context, AppErrors.pinCodeEmpty)
                      ? ErrorsManagerCubit.getErrorMessage(
                          context, AppErrors.pinCodeEmpty)
                      : ErrorsManagerCubit.contains(
                              context, AppErrors.pinCodeInvalid)
                          ? ErrorsManagerCubit.getErrorMessage(
                              context, AppErrors.pinCodeInvalid)
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
                    }
                    pinCode = text;
                    checkOtpModel.code=int.parse(pinCode!);
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
                      text: AppStrings.submit,
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
    formKey.currentState!.save();
    if (!ErrorsManagerCubit.hasErrors(context)) {
      UserCubit.checkOtpEvent(context, checkOtpModel);
    }
  }

  void _showDialog({required BuildContext context,String? message,required DialogTypes dialogType}) => showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return CustomDialog(message: message,dialogType: dialogType,);
        },
      );
}
