import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/dicionary/presenter/words/pages/word_item.dart';

class WordsTab extends StatelessWidget {
  const WordsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return     GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 800,
        itemBuilder: (BuildContext context, int index) {
          return const WordItem(word: 'AMIDIGALITITESAURICA');
        }
    );
  }
}
