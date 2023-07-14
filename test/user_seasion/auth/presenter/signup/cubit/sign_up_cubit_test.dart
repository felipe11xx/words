import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:words/shared/services/auth_service.dart';
import 'package:words/user_session/auth/data/model/sing_in_request.dart';
import 'package:words/user_session/auth/presenter/signup/cubit/sign_up_cubit.dart';
import 'package:words/user_session/auth/presenter/signup/cubit/sign_up_state.dart';

class MockAuthService extends Mock implements AuthService {}

class UserMock extends Mock implements User {
  @override
  String? get email => 'test@test.com';
}

void main() {
  late SignUpCubit signUpCubit;
  late MockAuthService mockAuthService;
  late SignInRequest  signInRequest ;
  setUp(() {
    mockAuthService = MockAuthService();
    signUpCubit = SignUpCubit(mockAuthService);
    signInRequest = SignInRequest(email: 'test@test.com', password: '123456');
  });

  group('SignUpCubit', () {



    test('initial state should be SignUpInitialState', () {
      expect(signUpCubit.state, equals(SignUpInitialState()));
    });


    blocTest<SignUpCubit, SignUpState>(
      'getWords should emit SignUpLoadingState and SignUpSuccessState on success',

      build: () {
        when(() => mockAuthService.signUp(signInRequest))
            .thenAnswer((_) async => UserMock());


        TestWidgetsFlutterBinding.ensureInitialized();
        return signUpCubit;
      },
      act: (cubit) => cubit.doSignUp(signInRequest),
      expect: () => [
        isA<SignUpLoadingState>(),
        isA<SignUpSuccessState>(),
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'getWords should emit SignUpLoadingState and SignUpErrorState on fail',

      build: () {
        when(() => mockAuthService.signUp(signInRequest))
            .thenThrow(AuthException('error'));


        TestWidgetsFlutterBinding.ensureInitialized();
        return signUpCubit;
      },
      act: (cubit) => cubit.doSignUp(signInRequest),
      expect: () => [
        isA<SignUpLoadingState>(),
        isA<SignUpErrorState>(),
      ],
    );

    test('isEnable should return true when both isValidPassword and isValidEmail are true', () {


      final result = signUpCubit.isEnable(true, true);

      expect(result, isTrue);
    });


  });
}
