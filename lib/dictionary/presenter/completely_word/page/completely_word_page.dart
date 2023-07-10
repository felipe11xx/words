import 'package:flutter/material.dart';
import '../cubit/completely_word_state.dart';
import '../cubit/completely_word_cubit.dart';
import 'package:words/shared/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/resources/strings.dart';
import 'package:words/shared/theme/typography.dart';
import 'package:words/shared/resources/svg_paths.dart';
import 'package:words/dictionary/data/model/models.dart';
import '../../../../shared/widgets/app_square_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/shared/widgets/app_error_screen.dart';
import '../../../../shared/widgets/app_progress_indicator.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:words/dictionary/presenter/completely_word/page/meaning_item.dart';

class CompletelyWordPage extends StatefulWidget {
  const CompletelyWordPage({super.key, required this.word});

  final String word;

  @override
  State<CompletelyWordPage> createState() => _CompletelyWordPageState();
}

class _CompletelyWordPageState extends State<CompletelyWordPage> {
  late CompletelyWord completelyWord;
  late List<String?> meanings;
  bool isFavorite = false;
  final PageController _controller = PageController();

  @override
  void initState() {
    context.read<CompletelyWordCubit>().getCompletelyWord(widget.word);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        color: AppColors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.close),
      )),
      body: Container(
        color: AppColors.primary_light[100],
        child: _blocConsumer(),
      ),
    );
  }

  _blocConsumer() {
    return BlocConsumer<CompletelyWordCubit, CompletelyWordState>(
        listener: (context, state) {
      if (state is CompleteWordSuccessState) {
        completelyWord = state.completelyWord;
        meanings = state.meanings;
      }
    }, builder: (context, state) {
      if (state is CompleteWordLoadingState) {
        return Center(
          child: AppProgressIndicator(
            color: AppColors.secondary_light,
            width: 100.w,
            height: 100.w,
          ),
        );
      } else if (state is CompleteWordSuccessState) {
        return _body();
      } else if (state is CompleteWordErrorState) {
        return AppErrorScreen(
            icon: state.prop.is404 ? SvgPaths.icon404 : SvgPaths.errorIcon,
            error: state.prop.message,
            buttonText: state.prop.is404 ? Strings.back : Strings.tryAgain,
            onPressed: () {
              state.prop.is404
                  ? Modular.to.pop()
                  : context
                      .read<CompletelyWordCubit>()
                      .getCompletelyWord(widget.word);
            });
      } else {
        return AppErrorScreen(
          onPressed: () {
            context.read<CompletelyWordCubit>().getCompletelyWord(widget.word);
          },
        );
      }
    });
  }

  _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelWord(),
        _playerButton(),
        _pageViewMeaningsLabel(),
        _pageViewMeanings(),
        _pageViewMeaningsButtons(),
      ],
    );
  }

  _panelWord() {
    return Container(
      margin: EdgeInsets.all(16.w),
      width: 350.w,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.neutral_70,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          color: AppColors.secondary_light[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [_favoriteButton()],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
            child: Text(
              completelyWord.word ?? '',
              style: AppTextStyles.headH2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.w, bottom: 32.w),
            child: Text(
              completelyWord.pronunciation?.all ?? '',
              style: TextStyle(fontSize: 54.sp),
            ),
          ),
        ],
      ),
    );
  }

  _favoriteButton() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 8.w),
      child: IconButton(
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 32.w,
        ),
        color: AppColors.white,
      ),
    );
  }

  _playerButton() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        children: [
          Expanded(
            child: AppSquareButton(
              onTap: () {
                context
                    .read<CompletelyWordCubit>()
                    .speak(completelyWord.word ?? '');
              },
              textButton: Strings.listen,
              icon: Icon(
                Icons.play_arrow_rounded,
                color: AppColors.white,
                size: 32.w,
              ),
              fit: BoxFit.fitWidth,
              color: AppColors.secondary_light[600],
              style:
                  AppTextStyles.bodyLargeBold.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  _pageViewMeaningsLabel() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Text(
        Strings.meanings,
        style: AppTextStyles.labelLarge,
      ),
    );
  }

  _pageViewMeanings() {
    return SizedBox(
      height: 100.h,
      child: PageView.builder(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: meanings.length,
          scrollDirection: Axis.horizontal,
          padEnds: true,
          onPageChanged: (value) {
            setState(() {});
          },
          itemBuilder: (_, index) {
            return MeaningItem(meaning: meanings[index]);
          }),
    );
  }

  _pageViewMeaningsButtons() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppSquareButton(
            onTap: () {
              _controller.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.linear);
            },
            textButton: Strings.back,
            fit: BoxFit.fitHeight,
            color: AppColors.secondary_light[600],
            style: AppTextStyles.bodyLargeBold.copyWith(color: AppColors.white),
          ),
          AppSquareButton(
            onTap: () {
              _controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.linear);
            },
            textButton: Strings.next,
            fit: BoxFit.fitHeight,
            color: AppColors.secondary_light[600],
            style: AppTextStyles.bodyLargeBold.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
