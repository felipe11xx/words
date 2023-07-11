import '../cubit/cubits.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/all_words/presenter/pages/pages.dart';

class AllWordsTab extends StatefulWidget {
   const AllWordsTab( {super.key});

  @override
  State<AllWordsTab> createState() => _AllWordsTabState();
}

class _AllWordsTabState extends State<AllWordsTab> {

  @override
  void initState() {
    context.read<AllWordsCubit>().getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AllWordsCubit, AllWordsState>(
        listener: (context, state) {},
     builder: (context,state) {

       if (state is AllWordsStateLoadingState) {
         return Center(
           child: AppProgressIndicator(
             color: AppColors.secondary_light,
             width: 100.w,
             height: 100.w,
           ),
         );
       }

       if(state is AllWordsSuccessState){
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

       if (state is AllWordsErrorState) {
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

     }
    );
  }
}
