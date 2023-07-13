import 'package:hive/hive.dart';
import 'package:words/shared/services/hive_service.dart';

import 'shared/navigation/routes.dart';
import 'shared/network/custom_dio.dart';
import 'home/presenter/pages/pages.dart';
import 'shared/services/tts_service.dart';
import 'home/presenter/cubit/cubits.dart';
import 'user_session/splash/cubit/cubits.dart';
import 'dictionary/presenter/cubit/cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/shared/services/auth_service.dart';
import 'dictionary/presenter/page/completely_word_page.dart';
import 'dictionary/external/get_completely_word_external.dart';
import 'dictionary/domain/usecase/do_get_completely_word_usecase.dart';
import 'user_history/internal/get_user_datasource_internal.dart';
import 'package:words/user_favorites/presenter/cubit/cubits.dart';
import 'user_favorites/data/repository/set_user_favorites_impl.dart';
import 'package:words/dictionary/internal/save_completely_word_internal.dart';
import 'user_history/domain/usecase/do_get_user_history_usecase.dart';
import 'user_history/domain/usecase/do_save_user_history_usecase.dart';
import 'package:words/shared/services/real_time_data_base_service.dart';
import 'user_favorites/domain/usecase/do_set_user_favorites_usecase.dart';
import 'user_favorites/domain/usecase/do_get_user_favorites_usecase.dart';
import 'user_favorites/data/repository/get_favorites_repository_impl.dart';
import 'dictionary/data/repository/get_completely_word_internal_impl.dart';
import 'dictionary/data/repository/get_completely_word_external_impl.dart';
import 'user_history/data/repository/get_user_history_repository_impl.dart';
import 'user_favorites/internal/get_user_favorite_datasource_internal.dart';
import 'package:words/user_session/splash/presenter/pages/splash_page.dart';
import 'package:words/dictionary/internal/get_completely_word_internal.dart';
import 'user_favorites/internal/set_user_favorites_datasource_internal.dart';
import 'package:words/user_session/auth/presenter/signup/pages/sign_up_page.dart';
import 'package:words/user_session/auth/presenter/signin/pages/sign_in_page.dart';
import 'package:words/user_session/auth/presenter/signup/cubit/sign_up_cubit.dart';
import 'package:words/user_session/auth/presenter/signin/cubit/sign_in_cubit.dart';
import 'package:words/dictionary/domain/usecase/do_save_completely_word_usecase.dart';
import 'package:words/user_history/internal/save_user_history_datasource_internal.dart';
import 'package:words/user_history/data/repository/save_user_history_repository_impl.dart';
import 'package:words/dictionary/data/repository/save_completely_word_repository_impl.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //commons
        Bind((i) => CustomDio()),
        Bind((i) => AppTTS()),
        Bind((i) => RealTimeDataBaseService()),
        Bind((i) => AuthService()),
        Bind((i) => HiveService()),

        //auth
        $SignInCubit,
        $SignUpCubit,
        $SplashCubit,

        //get Completely Word
        Bind.singleton((i) => DoGetCompletelyWordInternalDatasource(i())),
        Bind.singleton((i) => GetCompletelyWordInternalImpl(
            i<DoGetCompletelyWordInternalDatasource>())),
        Bind.singleton((i) => DoGetCompletelyWordExternalDatasource(i())),
        Bind.singleton((i) => GetCompletelyWordExternalImpl(
            i<DoGetCompletelyWordExternalDatasource>())),
        Bind.singleton((i) => DoGetCompletelyWordUseCase(i(), i())),
        Bind.singleton((i) => SaveCompleteWordInternalDatasource(i())),
        Bind.singleton((i) => DoSaveCompletelyWordUseCase(i())),
        Bind.singleton((i) => SaveCompletelyWordImpl(i())),
        $CompletelyWordCubit,

        //history
        Bind.singleton((i) => DoSaveUserHistoryUseCase(i())),
        Bind.singleton((i) => SaveUserHistoryInternalImpl(i())),
        Bind.singleton((i) => DoSaveUserHistoryDatasourceInternal(i())),
        Bind.singleton((i) => DoGetUserHistoryUseCase(i())),
        Bind.singleton((i) => GetUserHistoryInternalImpl(i())),
        Bind.singleton((i) => DoGetUserHistoryDatasourceInternal(i())),
        $HistoryCubit,

        //Favorites
        Bind.singleton((i) => DoSetUserFavoritesUseCase(i())),
        Bind.singleton((i) => SetUserFavoritesInternalImpl(i())),
        Bind.singleton((i) => DoSetUserFavoritesDatasourceInternal(i())),
        Bind.singleton((i) => DoGetUserFavoritesUseCase(i())),
        Bind.singleton((i) => GetUserFavoritesInternalImpl(i())),
        Bind.singleton((i) => DoGetUserFavoritesDatasourceInternal(i())),
        $FavoritesCubit,
        //HOME
        $HomeCubit,
        $AllWordsCubit,

      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.defaultRoute,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, __) => BlocProvider.value(
              value: Modular.get<SplashCubit>(), child: const SplashPage()),
        ),
        ChildRoute(
          Routes.signIn,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, __) => BlocProvider.value(
              value: Modular.get<SignInCubit>(), child: const SignInPage()),
        ),
        ChildRoute(
          Routes.signUp,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, __) => BlocProvider.value(
              value: Modular.get<SignUpCubit>(), child: const SignUpPage()),
        ),
        ChildRoute(
          Routes.home,
          transition: TransitionType.rightToLeftWithFade,
          child: (_, __) => BlocProvider.value(
              value: Modular.get<HomeCubit>(), child: const HomePage()),
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
