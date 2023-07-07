import 'package:flutter/material.dart';
import 'package:words/dicionary/presenter/words/pages/words_tab.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  WordsTab(),
    );
  }


}
