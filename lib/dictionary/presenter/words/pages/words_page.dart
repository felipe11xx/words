import 'package:flutter/material.dart';
import 'package:words/dictionary/presenter/words/pages/favorites_tab.dart';
import 'package:words/dictionary/presenter/words/pages/historic_tab.dart';
import 'package:words/dictionary/presenter/words/pages/words_tab.dart';
import 'package:words/shared/theme/colors.dart';
import 'package:words/shared/theme/typography.dart';
import '../../../../shared/resources/strings.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(Strings.dictionary,style: AppTextStyles.headH6.copyWith(color: AppColors.white),),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                Strings.wordsApp,
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
            ),
            Tab(
              child: Text(
                Strings.historic,
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
            ),
            Tab(
              child: Text(
                Strings.favorites,
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            WordsTab(),
            HistoricTab(),
            FavoritesTab(),
          ],
        ),
      ),
    );
  }
}
