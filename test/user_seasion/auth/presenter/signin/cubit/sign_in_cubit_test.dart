import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/services/auth_service.dart';
import 'package:words/user_session/auth/data/model/sing_in_request.dart';
import 'package:words/user_session/auth/presenter/signin/cubit/cubits.dart';

class MockAuthService extends Mock implements AuthService {}

class UserMock extends Mock implements User {
  @override
  String? get email => 'test@test.com';
}

void main() {
  late SignInCubit signInCubit;
  late MockAuthService mockAuthService;
  late SignInRequest  signInRequest ;
  setUp(() {
    mockAuthService = MockAuthService();
    signInCubit = SignInCubit(mockAuthService);
    signInRequest = SignInRequest(email: 'test@test.com', password: '123456');
  });

  group('SignInCubit', () {



    test('initial state should be SignInInitialState', () {
      expect(signInCubit.state, equals(SignInInitialState()));
    });


    blocTest<SignInCubit, SignInState>(
      'getWords should emit SignInLoadingState and SignInSuccessState on success',

      build: () {
        when(() => mockAuthService.signIn(signInRequest))
            .thenAnswer((_) async => UserMock());


        TestWidgetsFlutterBinding.ensureInitialized();
        return signInCubit;
      },
      act: (cubit) => cubit.doSignIn(signInRequest),
      expect: () => [
        isA<SignInLoadingState>(),
        isA<SignInSuccessState>(),
      ],
    );

    blocTest<SignInCubit, SignInState>(
      'getWords should emit SignInLoadingState and SignInErrorState on fail',

      build: () {
        when(() => mockAuthService.signIn(signInRequest))
            .thenThrow(AuthException('error'));


        TestWidgetsFlutterBinding.ensureInitialized();
        return signInCubit;
      },
      act: (cubit) => cubit.doSignIn(signInRequest),
      expect: () => [
        isA<SignInLoadingState>(),
        isA<SignInErrorState>(),
      ],
    );

    test('isEnable should return true when both isValidPassword and isValidEmail are true', () {


      final result = signInCubit.isEnable(true, true);

      expect(result, isTrue);
    });


  });
}
