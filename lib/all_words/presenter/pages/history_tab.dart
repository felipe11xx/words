import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/all_words/presenter/pages/pages.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../shared/theme/theme.dart';
import '../cubit/cubits.dart';

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

        if(state is HistorySuccessState){
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.list.length,
              itemBuilder: (BuildContext context, int index) {
                return WordItem(word: state.list[index],);
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
