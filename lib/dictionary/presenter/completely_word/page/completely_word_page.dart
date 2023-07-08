import 'package:flutter/material.dart';
import '../../../../shared/resources/strings.dart';
import '../cubit/completely_word_state.dart';
import '../cubit/completely_word_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_progress_indicator.dart';

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

  TextToSpeech tts = TextToSpeech();

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
        listener: (context, state) {},
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
          child: Column(
            children: [
              Text('Hello'),
              Text('hɛ\'loʊ'),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            tts.speak('Eu consigo Falar');
          },
          icon: const Icon(Icons.play_arrow_outlined),
          color: Colors.black,
          iconSize: 100.w,
        ),
        Text(Strings.meanings),
        Text('Verb - LOREM IPSUM'),
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
