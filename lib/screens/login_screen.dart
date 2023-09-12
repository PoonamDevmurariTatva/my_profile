import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/utils/image_picker.dart';

import '../bloc/login/login_cubit.dart';
import '../bloc/login/repository/login_repository.dart';
import '../utils/navigation/app_routes.dart';
import '../utils/navigation/navigation_routes.dart';
import '../utils/progress_dialog.dart';
import '../values/app_colors.dart';
import '../widgets/app_buttons.dart';
import '../widgets/app_check_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentIndex = 0;
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepository()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            ProgressDialogUtil.showProgressDialog(context);
          } else if (state is LoginSucceed) {
            ProgressDialogUtil.dismissProgressDialog(context);
            context.showSnackBar("User Logged in successfully");
            NavigationRoutes.pushAndRemoveUntil(context, Screens.profile);
          } else if (state is LoginError) {
            ProgressDialogUtil.dismissProgressDialog(context);
            context.showSnackBar(state.error, isError: true);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = BlocProvider.of(context);
          return Scaffold(
            backgroundColor: Colors.deepOrange,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          border: Border.all(
                            color: AppColors.colorWhite,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                color: AppColors.colorBlack,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Please sign in to continue",
                            style: TextStyle(
                                color: AppColors.colorBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                              controller: cubit.emailController,
                              decoration: InputDecoration(
                                hintText: " Email",
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.colorBlack, width: 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.colorPrimary, width: 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              obscureText: (_showPassword),
                              controller: cubit.passwordController,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    child: Icon(
                                      _showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorBlack, width: 0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorPrimary, width: 0),
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                          const SizedBox(
                            height: 30,
                          ),
                          AppCheckBox(
                              isChecked: cubit.rememberMe,
                              label: "Remember me",
                              onChange: (bool isChecked) {
                                cubit.changeRememberMe(isChecked);
                              }),
                          const SizedBox(
                            height: 40,
                          ),
                          AppButton(
                            text: "Login",
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              cubit.login();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
