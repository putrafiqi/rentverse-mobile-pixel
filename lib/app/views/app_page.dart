import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Inter", "Outfit");

    final theme = AppTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      highContrastTheme: theme.lightHighContrast(),
      highContrastDarkTheme: theme.darkHighContrast(),
      themeMode: ThemeMode.system,
      home: const AppView(),
    );
  }

  TextTheme createTextTheme(
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

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Hello World!')));
  }
}
