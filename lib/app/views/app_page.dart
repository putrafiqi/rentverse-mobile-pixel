import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/data.dart';
import '../../onboarding/onboarding.dart';
import '../blocs/blocs.dart';
import '../../core/core.dart';

class App extends StatelessWidget {
  final AuthRepository Function() authRepositoryBuilder;
  const App({super.key, required this.authRepositoryBuilder});

  @override
  Widget build(BuildContext context) {
    final textTheme = _createTextTheme(context, "Inter", "Outfit");

    final theme = AppTheme(textTheme);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          lazy: false,
          create: (context) => authRepositoryBuilder(),
          dispose: (repository) => repository.close(),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            AuthBloc(context.read<AuthRepository>())
              ..add(const AuthRequested()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.light(),
          darkTheme: theme.dark(),
          highContrastTheme: theme.lightHighContrast(),
          highContrastDarkTheme: theme.darkHighContrast(),
          themeMode: ThemeMode.system,
          home: Builder(
            builder: (context) {
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state.isAuthenticated) {
                    return const _AppView();
                  }
                  if (state.isUnknown) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const OnboardingPage();
                },
              );
            },
          ),
        ),
      ),
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('App Page'),
            FilledButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthSignedOut());
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
