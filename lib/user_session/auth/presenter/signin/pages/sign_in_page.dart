import '../cubit/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/utils/utils.dart';
import '../../../data/model/sing_in_request.dart';
import '../../../../../shared/widgets/widgets.dart';
import '../../../../../shared/navigation/routes.dart';
import '../../../../../shared/resources/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormFieldState>();
  final _formKeyPassword = GlobalKey<FormFieldState>();
  final _focusPassword = FocusNode();
  bool isValidPassword = false;
  bool isValidEmail = false;
  bool obscureText = true;
  bool isEnable = false;
  Debounce debounce = Debounce(const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          Modular.to.pushReplacementNamed(Routes.home);
        }
        if (state is SignInErrorState) {
          showSnackBar(context, state.exception.message ?? '');
        }
      },
      builder: (context, state) {
        if (state is SignInLoadingState) {
          return Center(
            child: AppProgressIndicator(
              color: AppColors.secondary_light,
              width: 100.w,
              height: 100.w,
            ),
          );
        }
        return _body();
      },
    ));
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        color: AppColors.secondary_light[100],
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppInputText(
                textFieldKey: _formKeyEmail,
                Strings.email,
                Strings.insertYourEmail,
                textEditingController: _tEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  return validateEmail(value);
                },
                action: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                nextFocus: _focusPassword,
                onChanged: (value) {
                  debounce.call(() {
                    _formKeyEmail.currentState?.validate();
                    setState(() {
                      isValidEmail =
                          _formKeyEmail.currentState?.isValid ?? false;
                      isEnable = context
                          .read<SignInCubit>()
                          .isEnable(isValidPassword, isValidEmail);
                    });
                  });
                }),
            SizedBox(
              height: 16.w,
            ),
            AppInputText(
                textFieldKey: _formKeyPassword,
                Strings.password,
                Strings.insertYourPassword,
                isPassword: obscureText,
                textEditingController: _tPassword,
                maxLength: 6,
                validator: (value) => validatePassword(value),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText
                      ? const Icon(
                          Icons.remove_red_eye_outlined,
                        )
                      : const Icon(
                          Icons.remove_red_eye,
                        ),
                ),
                onChanged: (value) {
                  debounce.call(() {
                    _formKeyPassword.currentState?.validate();
                    setState(() {
                      isValidPassword =
                          _formKeyPassword.currentState?.isValid ?? false;
                      isEnable = context
                          .read<SignInCubit>()
                          .isEnable(isValidPassword, isValidEmail);
                    });
                  });
                },
                keyboardType: TextInputType.number,
                focusNode: _focusPassword),
            SizedBox(
              height: 20.w,
            ),
            Row(
              children: [
                Expanded(
                  child: AppSquareButton(
                    isEnable: isEnable,
                    onTap: () {
                      context.read<SignInCubit>().doSignIn(
                          SignInRequest(password :_tPassword.text,email:_tEmail.text));
                    },
                    textButton: Strings.signIn,
                    fit: BoxFit.fitWidth,
                    color: AppColors.secondary_light[600],
                    style: AppTextStyles.bodyLargeBold
                        .copyWith(color: AppColors.white),
                  ),
                )
              ],
            ),
            InkWell(
                onTap: () {
                  Modular.to.pushNamed(Routes.signUp);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 42.w, left: 16.w, right: 16.w),
                  child: Text(
                    Strings.signUp,
                    style: AppTextStyles.overline.copyWith().copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
