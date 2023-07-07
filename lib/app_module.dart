import 'dicionary/data/repository/get_completely_word_impl.dart';
import 'dicionary/external/get_completely_word_external.dart';
import 'shared/navigation/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dicionary/domain/usecase/do_get_completely_word.dart';
import 'package:words/user_session/presenter/pages/splash_page.dart';


class AppModule extends Module {

  @override
  List<Bind<Object>> get binds => [
   //get Word Completely
   Bind((i) =>  DoGetCompletelyWordUseCase(iGetCompletelyWordRepository: i())),
   Bind((i) =>  GetCompletelyWordImpl(i())),
   Bind((i) =>  DoGetCompletelyWordExternal(i())),

  ];

  @override
  List<ModularRoute> get routes => [

    ChildRoute(Routes.defaultRoute,
        transition: TransitionType.rightToLeftWithFade,
        child:(_,__) => const SplashPage())

  ];
}