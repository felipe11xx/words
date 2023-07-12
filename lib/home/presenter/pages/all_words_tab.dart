import 'package:firebase_ui_database/firebase_ui_database.dart';

import '../cubit/cubits.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../shared/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words/home/presenter/pages/pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class AllWordsTab extends StatefulWidget {
  const AllWordsTab({super.key});

  @override
  State<AllWordsTab> createState() => _AllWordsTabState();
}

class _AllWordsTabState extends State<AllWordsTab> {
  @override
  void initState() {
    /// context.read<AllWordsCubit>().getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllWordsCubit, AllWordsState>(
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

          return FirebaseDatabaseQueryBuilder(
              query: context.read<AllWordsCubit>().getWordsQuery(),
              builder: (context, snapshot, _) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: snapshot.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.isFetching) {
                        return Center(
                          child: AppProgressIndicator(
                            color: AppColors.secondary_light,
                            width: 100.w,
                            height: 100.w,
                          ),
                        );
                      }
                      if (snapshot.hasMore &&
                          index + 1 == snapshot.docs.length) {
                        // Tell FirebaseDatabaseQueryBuilder to try to obtain more items.
                        // It is safe to call this function from within the build method.
                        snapshot.fetchMore();
                      }
                      return WordItem(
                        word: snapshot.docs[index].key,
                        onClickItem: () {
                          Modular.to.pushNamed(Routes.wordCompletely,
                              arguments: snapshot.docs[index].key);
                          context
                              .read<AllWordsCubit>()
                              .saveUserHistory(snapshot.docs[index].key);
                        },
                      );
                    });
              });

        });
  }
}
