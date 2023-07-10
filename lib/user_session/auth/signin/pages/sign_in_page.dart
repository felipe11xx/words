import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import '../../../../shared/utils/delay_future.dart';
import '../../data/model/sing_in_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/utils/validator.dart';
import '../../../../shared/theme/typography.dart';
import '../../../../shared/navigation/routes.dart';
import '../../../../shared/resources/strings.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import '../../../../shared/widgets/app_input_text.dart';
import '../../../../shared/widgets/app_square_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_progress_indicator.dart';
import 'package:words/user_session/auth/signin/cubit/sign_in_cubit.dart';
import 'package:words/user_session/auth/signin/cubit/sign__in_state.dart';

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
  String onError = '';
  bool isValidPassword = false;
  bool isValidEmail = false;
  bool obscureText = true;
  Debounce debounce = Debounce(const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          Modular.to.pushReplacementNamed(Routes.dictionary);
        }
        if (state is SignInErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.exception.message ?? ''),
          ));
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
        return _body(state);
      },
    ));
  }

  _body(state) {
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
                    isEnable: context
                        .read<SignInCubit>()
                        .isEnable(isValidPassword, isValidEmail),
                    onTap: () {
                      context.read<SignInCubit>().doSignIn(
                          SignInRequest(_tPassword.text, _tEmail.text));
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

            Padding(padding: EdgeInsets.only(top:42.w, left: 16.w, right: 16.w),

            child: InkWell(
                child: Text(Strings.signUp, style: AppTextStyles.overline,)),)
          ],
        ),
      ),
    );
  }
}
