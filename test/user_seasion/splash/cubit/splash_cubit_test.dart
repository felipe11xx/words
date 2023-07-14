import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/services/auth_service.dart';
import 'package:words/user_session/auth/data/model/sing_in_request.dart';
import 'package:words/user_session/auth/presenter/signin/cubit/cubits.dart';
import 'package:words/user_session/splash/cubit/splash_cubit.dart';
import 'package:words/user_session/splash/cubit/splash_state.dart';

class MockAuthService extends Mock implements AuthService {}

class UserMock extends Mock implements User {
  @override
  String? get email => 'test@test.com';
}

void main() {
  late SplashCubit signInCubit;
  late MockAuthService mockAuthService;
  setUp(() {
    mockAuthService = MockAuthService();
    signInCubit = SplashCubit(mockAuthService);
  });

  group('SplashCubit', () {



    test('initial state should be SplashInitialState', () {
      expect(signInCubit.state, equals(SplashInitialState()));
    });


    blocTest<SplashCubit, SplashState>(
      'getWords should emit SplashLoadingState and SplashSuccessState on success',

      build: () {
        when(() => mockAuthService.userAuth)
            .thenReturn(UserMock());


        TestWidgetsFlutterBinding.ensureInitialized();
        return signInCubit;
      },
      act: (cubit) => cubit.getUserSession(),
      expect: () => [
        isA<SplashUserSessionLoadingState>(),
        isA<SplashUserSessionSuccessState>(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'getWords should emit SplashLoadingState and SplashErrorState on fail',

      build: () {
        when(() => mockAuthService.userAuth)
            .thenReturn(null);


        TestWidgetsFlutterBinding.ensureInitialized();
        return signInCubit;
      },
      act: (cubit) => cubit.getUserSession(),
      expect: () => [
        isA<SplashUserSessionLoadingState>(),
        isA<SplashUserSessionErrorState>(),
      ],
    );

    test('isEnable should return true when both isValidPassword and isValidEmail are true', () {


      final result = signInCubit.isEnable(true, true);

      expect(result, isTrue);
    });


  });
}
