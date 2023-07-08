import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/app_progress_indicator.dart';
import '../cubit/completely_word_cubit.dart';
import '../cubit/completely_word_state.dart';

class CompletelyWordPage extends StatefulWidget {
  const CompletelyWordPage({super.key});

  @override
  State<CompletelyWordPage> createState() => _CompletelyWordPageState();
}

class _CompletelyWordPageState extends State<CompletelyWordPage> {

 @override
  void initState() {
   context.read<CompletelyWordCubit>().getCompletelyWord('Hello');
   super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _blocConsumer(),
    );
  }

  _blocConsumer() {
    return BlocConsumer<CompletelyWordCubit, CompletelyWordState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CompleteWordLoadingState) {
            return Center(
              child: AppProgressIndicator(color: Colors.green,),
            );
          }
          if (state is CompleteWordSuccessState) {
            return Container(color: Colors.blue,);
          }
          if (state is CompleteWordLoadingState) {
            return Container(color: Colors.red,);
          }
          return Container(color: Colors.black,);
        });
  }
}
