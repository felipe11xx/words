import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/home/presenter/cubit/cubits.dart';
import 'package:words/shared/services/auth_service.dart';

class AuthServiceMock extends Mock implements AuthService {}
class UserMock extends Mock implements User{
  @override
  String? get email =>'user@example.com' ;
}
void main() {
  late HomeCubit homeCubit;
  late AuthServiceMock mockAuthService;

  setUp(() {
    mockAuthService = AuthServiceMock();
    homeCubit = HomeCubit(mockAuthService);
  });

  group('HomeCubit', () {
    test('initial state should be HomeInitialState', () {
      expect(homeCubit.state, equals(HomeInitialState()));
    });



    blocTest<HomeCubit,HomeState>('signOut should emit HomeLoadingState, UserSignOutSuccessState and homeInitialState when sign out succeeds', build: () {

      TestWidgetsFlutterBinding.ensureInitialized();
      return homeCubit;
    },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<UserSignOutSuccessState>(),
        isA<HomeInitialState>(),
      ],);

    blocTest<HomeCubit,HomeState>('signOut should emit HomeLoadingState, UserSignOutErrorState  when sign out fails', build: () {
      when(() => mockAuthService.signOut())
          .thenThrow(AuthException(  'error'));
      return homeCubit;
    },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<UserSignOutErrorState>(),
      ],);


    test('getUserEmail should return the user email from AuthService', () {
      const userEmail = 'user@example.com';
      when(() => mockAuthService.userAuth).thenReturn(UserMock());

      final result = homeCubit.getUserEmail();

      expect(result, equals(userEmail));
      verify(() => mockAuthService.userAuth).called(1);
    });

  });
}

