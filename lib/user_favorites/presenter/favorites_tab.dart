import 'cubit/cubits.dart';
import '../../shared/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import '../../shared/widgets/widgets.dart';
import '../../shared/navigation/routes.dart';
import '../../home/presenter/pages/pages.dart';
import '../../shared/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  void initState() {
    context.read<FavoritesCubit>().getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FavoritesLoadingState) {
          return Center(
            child: AppProgressIndicator(
              color: AppColors.secondary_light,
              width: 100.w,
              height: 100.w,
            ),
          );
        }

        if (state is FavoritesEmptyState) {
          return Center(
            child: Text(
              Strings.noFavoritesYet,
              style: AppTextStyles.headH2,
            ),
          );
        }

        if (state is FavoritesSuccessState) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.list.length,
              itemBuilder: (BuildContext context, int index) {
                return WordItem(
                  word: state.list[index],
                  onClickItem: () {
                    Modular.to.pushNamed(Routes.wordCompletely,
                        arguments: state.list[index]).then((value) => setState(() {    context.read<FavoritesCubit>().getWords();
                    }));
                  },
                );
              });
        }

        if (state is FavoritesErrorState) {
          return AppErrorScreen(
              error: state.exception.toString(),
              onPressed: () {
                context.read<FavoritesCubit>().getWords();
              });
        }

        return AppErrorScreen(onPressed: () {
          context.read<FavoritesCubit>().getWords();
        });
      },
    );
  }
}
