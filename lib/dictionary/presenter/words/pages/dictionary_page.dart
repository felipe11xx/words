import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/dictionary/presenter/words/cubit/all_words_cubit.dart';
import 'package:words/dictionary/presenter/words/cubit/all_words_state.dart';
import 'package:words/dictionary/presenter/words/pages/favorites_tab.dart';
import 'package:words/dictionary/presenter/words/pages/historic_tab.dart';
import 'package:words/dictionary/presenter/words/pages/words_tab.dart';
import 'package:words/shared/theme/colors.dart';
import 'package:words/shared/theme/typography.dart';
import 'package:words/shared/widgets/app_error_screen.dart';
import '../../../../shared/resources/strings.dart';
import '../../../../shared/widgets/app_progress_indicator.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  void initState() {
    context.read<AllWordsCubit>().getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.dictionary,
            style: AppTextStyles.headH6.copyWith(color: AppColors.white),
          ),
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
        body: BlocConsumer<AllWordsCubit, AllWordsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AllWordsStateLoadingState) {
                return Center(
                  child: AppProgressIndicator(
                    color: AppColors.secondary_light,
                    width: 100.w,
                    height: 100.w,
                  ),
                );
              }
              if (state is AllWordsSuccessState) {
                return TabBarView(
                  children: [
                    WordsTab(
                      words: state.list,
                    ),
                    HistoricTab(),
                    FavoritesTab(),
                  ],
                );
              }
              if (state is AllWordsErrorState) {
                return AppErrorScreen(
                    error: state.exception.toString(),
                    onPressed: () {
                  context.read<AllWordsCubit>().getWords();
                });
              }

              return AppErrorScreen(onPressed: () {
                context.read<AllWordsCubit>().getWords();
              });
            }),
      ),
    );
  }
}
