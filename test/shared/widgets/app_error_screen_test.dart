import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/resources/strings.dart';
import 'package:words/shared/widgets/app_error_screen.dart';

void main() {
  group('AppErrorScreen', () {
    const error = 'Error message';
    const buttonText = 'Retry';

    testWidgets('renders icon, error message, and button with default values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home:ScreenUtilInit(
            designSize: const Size(480, 800),
            minTextAdapt: true,
            builder: (context, child) => Scaffold(
              body: AppErrorScreen(
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);

      expect(find.text(Strings.genericError), findsOneWidget);

    });

  });
}
