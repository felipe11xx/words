import 'package:flutter/material.dart';
import '../../../shared/navigation/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      Modular.to.navigate(Routes.words);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
      color: Colors.amber,
      child: const Center(
        child: Text('olá Mundo'),
      ),
    ));
  }
}
