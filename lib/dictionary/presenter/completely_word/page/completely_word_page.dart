import 'package:flutter/material.dart';
import '../cubit/completely_word_state.dart';
import '../cubit/completely_word_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/resources/strings.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_progress_indicator.dart';

class CompletelyWordPage extends StatefulWidget {
  const CompletelyWordPage({super.key});

  @override
  State<CompletelyWordPage> createState() => _CompletelyWordPageState();
}

class _CompletelyWordPageState extends State<CompletelyWordPage> {
  late WordCompleted wordCompleted;

  @override
  void initState() {
    context.read<CompletelyWordCubit>().getCompletelyWord('flavor');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.close),
      )),
      body: _blocConsumer(),
    );
  }

  _blocConsumer() {
    return BlocConsumer<CompletelyWordCubit, CompletelyWordState>(
        listener: (context, state) {
          if(state is CompleteWordSuccessState){
            wordCompleted = state.prop;
          }

        },
        builder: (context, state) {
          if (state is CompleteWordLoadingState) {
            return Center(
              child: AppProgressIndicator(
                color: Colors.green,
                width: 50.w,
              ),
            );
          }
          if (state is CompleteWordSuccessState) {
            return Container(
              color: Colors.blue,
              child: _body(),
            );
          }
          if (state is CompleteWordLoadingState) {
            return Container(
              color: Colors.red,
            );
          }
          return Container(
            color: Colors.black,
          );
        });
  }

  _body() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child:  Column(
            children: [
              Text(wordCompleted.word ?? ''),
              Text(wordCompleted.pronunciation?.all ?? ''),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<CompletelyWordCubit>().speak(wordCompleted.word ?? '');
          },
          icon: const Icon(Icons.play_arrow_outlined),
          color: Colors.black,
          iconSize: 100.w,
        ),
       const Text(Strings.meanings),
        Text(wordCompleted.results?[0].definition ?? ''),
        Row(
          children: [
            GestureDetector(
              child: const  Text(Strings.back),
            ),
            GestureDetector(
              child: const  Text(Strings.next),
            ),
          ],
        )
      ],
    );
  }
}
