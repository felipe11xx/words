import 'package:flutter/material.dart';
import 'package:words/dictionary/presenter/words/pages/favorites_tab.dart';
import 'package:words/dictionary/presenter/words/pages/historic_tab.dart';
import 'package:words/dictionary/presenter/words/pages/words_tab.dart';
import 'package:words/shared/theme/typography.dart';
import '../../../../shared/resources/strings.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(Strings.dictionary,style: AppTextStyles.headH6,),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                Strings.wordsApp,
                style: AppTextStyles.subtitle,
              ),
            ),
            Tab(
              child: Text(
                Strings.historic,
                style: AppTextStyles.subtitle,
              ),
            ),
            Tab(
              child: Text(
                Strings.favorites,
                style: AppTextStyles.subtitle,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
