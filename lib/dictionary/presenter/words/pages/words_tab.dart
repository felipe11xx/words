import 'package:flutter/cupertino.dart';
import 'package:words/dictionary/presenter/words/pages/word_item.dart';

class WordsTab extends StatelessWidget {
   WordsTab( {required this.words,super.key});

  List<String> words;

  @override
  Widget build(BuildContext context) {
    return     GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return  WordItem(word: words[index],);
        }
    );
  }
}
