import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../sign_in/sign_in.dart';
import '../../sign_up/sign_up.dart';
import '../themes/themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = _createTextTheme(context, "Inter", "Outfit");

    final theme = AppTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      highContrastTheme: theme.lightHighContrast(),
      highContrastDarkTheme: theme.darkHighContrast(),
      themeMode: ThemeMode.system,
      home: const _AppView(),
    );
  }

  TextTheme _createTextTheme(
    BuildContext context,
    String bodyFontString,
    String displayFontString,
  ) {
    TextTheme baseTextTheme = Theme.of(context).textTheme;
    TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
      bodyFontString,
      baseTextTheme,
    );
    TextTheme displayTextTheme = GoogleFonts.getTextTheme(
      displayFontString,
      baseTextTheme,
    );
    TextTheme textTheme = displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
    return textTheme;
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    );

    final pageDecoration =
        PageDecoration(
          imagePadding: EdgeInsets.zero,
          titlePadding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
          imageFlex: 2,
        ).copyWith(
          titleTextStyle: textTheme.headlineMedium,
          bodyTextStyle: textTheme.bodyLarge,
        );

    return Scaffold(
      body: IntroductionScreen(
        showDoneButton: false,
        showNextButton: false,
        infiniteAutoScroll: true,
        autoScrollDuration: 5000,
        globalFooter: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(shape: buttonShape),
                onPressed: () {
                  Navigator.push(context, SignInPage.route());
                },
                child: const Text('Sign In'),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(shape: buttonShape),
                onPressed: () {
                  Navigator.push(context, SignUpPage.route());
                },
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
        dotsDecorator: DotsDecorator(
          activeSize: const Size(60, 8),
          spacing: const EdgeInsets.all(4),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          activeColor: colorScheme.primary,
        ),

        pages: [
          PageViewModel(
            decoration: pageDecoration,
            title: "Find Your Dream Home",
            body:
                "Browse houses, apartments, and rooms that match your location and budget.",
            image: SvgPicture.asset('assets/images/3.svg'),
          ),
          PageViewModel(
            decoration: pageDecoration,
            title: "Verified Listings Only",
            body:
                "Check real photos. We ensure the property matches what you see.",
            image: SvgPicture.asset('assets/images/2.svg'),
          ),
          PageViewModel(
            decoration: pageDecoration,
            title: "Rent with Confidence",
            body:
                "Sign contracts and pay securely within the app. Moving made simple.",
            image: SvgPicture.asset('assets/images/1.svg'),
          ),
        ],
      ),
    );
  }
}
