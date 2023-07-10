import 'shared/navigation/routes.dart';
import 'shared/network/custom_dio.dart';
import 'shared/services/tts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/shared/services/auth_service.dart';
import 'dictionary/presenter/words/pages/dictionary_page.dart';
import 'dictionary/external/get_completely_word_external.dart';
import 'dictionary/domain/usecase/do_get_completely_word.dart';
import 'package:words/dictionary/internal/save_completely_word.dart';
import 'package:words/shared/services/real_time_data_base_service.dart';
import 'dictionary/data/repository/get_completely_word_internal_impl.dart';
import 'dictionary/data/repository/get_completely_word_external_impl.dart';
import 'package:words/user_session/splash/presenter/pages/splash_page.dart';
import 'package:words/dictionary/internal/get_completely_word_internal.dart';
import 'package:words/dictionary/presenter/words/cubit/all_words_cubit.dart';
import 'dictionary/presenter/completely_word/page/completely_word_page.dart';
import 'dictionary/presenter/completely_word/cubit/completely_word_cubit.dart';
import 'package:words/user_session/auth/presenter/signup/pages/sign_up_page.dart';
import 'package:words/user_session/auth/presenter/signin/pages/sign_in_page.dart';
import 'package:words/user_session/auth/presenter/signup/cubit/sign_up_cubit.dart';
import 'package:words/user_session/auth/presenter/signin/cubit/sign_in_cubit.dart';
import 'package:words/dictionary/domain/usecase/do_save_completely_word_usecase.dart';
import 'package:words/dictionary/data/repository/save_completeky_word_repository_impl.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //commons
        Bind((i) => CustomDio()),
        Bind((i) => AppTTS()),
        Bind((i) => RealTimeDataBaseService()),
        Bind((i) => AuthService()),

        //auth
        $SignInCubit,
        $SignUpCubit,

        //get Completely Word
        Bind.singleton((i) => DoGetCompletelyWordInternal()),
        Bind.singleton((i) => GetCompletelyWordInternalImpl(i<DoGetCompletelyWordInternal>())),
        Bind.singleton((i) => DoGetCompletelyWordExternal(i())),
        Bind.singleton((i) => GetCompletelyWordExternalImpl(i<DoGetCompletelyWordExternal>())),
        Bind.singleton((i) =>
            DoGetCompletelyWordUseCase( i(),i())),


        Bind.singleton((i) => SaveCountriesDatasourceInternal()),
        Bind.singleton((i) => DoSaveCompletelyWordUseCase(i())),
        Bind.singleton((i) => SaveCompletelyWordImpl(i())),

        $CompletelyWordCubit,
        $AllWordsCubit,
      ];

  @override
  List<ModularRoute> get routes => [

       ChildRoute(
          Routes.defaultRoute,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, args) => const SplashPage(),
        ),

        ChildRoute(
          Routes.signIn,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, args) => BlocProvider.value(
              value: Modular.get<SignInCubit>(),
              child: const SignInPage()),
        ),

        ChildRoute(
          Routes.signUp,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, args) => BlocProvider.value(
              value: Modular.get<SignUpCubit>(),
              child: const SignUpPage()),
        ),

        ChildRoute(
          Routes.dictionary,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, args) => BlocProvider.value(
              value: Modular.get<AllWordsCubit>(),
              child: const DictionaryPage()),
        ),

        ChildRoute(
          Routes.wordCompletely,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, args) => BlocProvider.value(
            value: Modular.get<CompletelyWordCubit>(),
            child: CompletelyWordPage(
              word: args.data,
            ),
          ),
        )
      ];
}
