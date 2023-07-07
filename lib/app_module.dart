import 'shared/navigation/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/user_session/presenter/pages/splash_page.dart';


class AppModule extends Module {

  @override
  List<Bind<Object>> get binds => [


  ];

  @override
  List<ModularRoute> get routes => [

    ChildRoute(Routes.defaultRoute,
        transition: TransitionType.rightToLeftWithFade,
        child:(_,__) => const SplashPage())

  ];
}