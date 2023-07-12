import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/utils/utils.dart';
import '../../../data/model/sing_in_request.dart';
import '../../../../../shared/widgets/widgets.dart';
import '../../../../../shared/navigation/routes.dart';
import 'package:flutter_modular/flutter_modular.dart'     hide ModularWatchExtension;
import '../../../../../shared/resources/resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/user_session/auth/presenter/signup/cubit/sign_up_cubit.dart';
import 'package:words/user_session/auth/presenter/signup/cubit/sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormFieldState>();
  final _formKeyPassword = GlobalKey<FormFieldState>();
  Debounce debounce = Debounce(const Duration(milliseconds: 500));
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();
  bool isValidPassword = false;
  bool isValidEmail = false;
  bool obscurePassword = true;
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Modular.to.pushReplacementNamed(Routes.home);
          }
          if (state is  SignUpErrorState) {
            showSnackBar(context,state.exception.message ?? '');
          }
        },
        builder: (context, state) {
          if(state is SignUpLoadingState){
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
      ),
    );
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
            _email(),
            _password(),
            Row(
              children: [
                Expanded(
                  child: AppSquareButton(
                    isEnable: isEnable,
                    onTap: () {
                      context.read<SignUpCubit>().doSignUp(
                          SignInRequest(_tPassword.text, _tEmail.text));
                    },
                    textButton: Strings.signUp,
                    fit: BoxFit.fitWidth,
                    color: AppColors.secondary_light[600],
                    style: AppTextStyles.bodyLargeBold
                        .copyWith(color: AppColors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _email() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: AppInputText(
          textFieldKey: _formKeyEmail,
          Strings.email,
          Strings.insertAEmail,
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
                isValidEmail = _formKeyEmail.currentState?.isValid ?? false;
                isEnable = context
                    .read<SignUpCubit>()
                    .isEnable(isValidPassword, isValidEmail);
              });
            });
          }),
    );
  }

  _password() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: AppInputText(
        textFieldKey: _formKeyPassword,
        Strings.password,
        Strings.insertAPassword,
        isPassword: obscurePassword,
        textEditingController: _tPassword,
        maxLength: 6,
        validator: (value) =>
          validatePassword(value),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          icon: obscurePassword
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
              isValidPassword = _formKeyPassword.currentState?.isValid ?? false;
              isEnable = context
                  .read<SignUpCubit>()
                  .isEnable(isValidPassword, isValidEmail);

            });
          });
        },
        keyboardType: TextInputType.number,
        focusNode: _focusPassword,
        nextFocus: _focusConfirmPassword,
      ),
    );
  }

}
