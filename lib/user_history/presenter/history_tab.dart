import '../../all_words/presenter/cubit/cubits.dart';
import 'package:flutter/cupertino.dart';
import '../../shared/theme/theme.dart';
import '../../shared/widgets/widgets.dart';
import '../../shared/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/resources/resources.dart';
import 'package:flutter_modular/flutter_modular.dart'    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/all_words/presenter/pages/pages.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {

  @override
  void initState() {
    context.read<HistoryCubit>().getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HistoryLoadingState) {
          return Center(
            child: AppProgressIndicator(
              color: AppColors.secondary_light,
              width: 100.w,
              height: 100.w,
            ),
          );
        }

        if(state is HistoryEmptyState){
          return   Center(
            child: Text(Strings.noHistoricYet, style: AppTextStyles.headH2,),
          );

        }

        if(state is HistorySuccessState){
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.list.length,
              itemBuilder: (BuildContext context, int index) {
                return WordItem(word: state.list[index],onClickItem: (){ Modular.to.pushNamed(Routes.wordCompletely,arguments: state.list[index]);},);
              }
          );
        }

        if (state is HistoryErrorState) {
          return AppErrorScreen(
              error: state.exception.toString(),
              onPressed: () {
                context.read<AllWordsCubit>().getWords();
              });
        }

        return AppErrorScreen(onPressed: () {
          context.read<AllWordsCubit>().getWords();
        }


        );

      },
    );
  }
}
