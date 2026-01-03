import "package:flutter/material.dart";

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2a14b4),
      surfaceTint: Color(0xff5148d7),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4338ca),
      onPrimaryContainer: Color(0xffc1beff),
      secondary: Color(0xff5a5893),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc0bdff),
      onSecondaryContainer: Color(0xff4c4a84),
      tertiary: Color(0xff6a0071),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8a1c90),
      onTertiaryContainer: Color(0xffffa6fb),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff1b1b23),
      onSurfaceVariant: Color(0xff464554),
      outline: Color(0xff777586),
      outlineVariant: Color(0xffc7c4d7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff302f39),
      inversePrimary: Color(0xffc3c0ff),
      primaryFixed: Color(0xffe3dfff),
      onPrimaryFixed: Color(0xff100069),
      primaryFixedDim: Color(0xffc3c0ff),
      onPrimaryFixedVariant: Color(0xff372abf),
      secondaryFixed: Color(0xffe3dfff),
      onSecondaryFixed: Color(0xff16124c),
      secondaryFixedDim: Color(0xffc3c0ff),
      onSecondaryFixedVariant: Color(0xff42407a),
      tertiaryFixed: Color(0xffffd6f8),
      onTertiaryFixed: Color(0xff37003b),
      tertiaryFixedDim: Color(0xffffa9fa),
      onTertiaryFixedVariant: Color(0xff7d0884),
      surfaceDim: Color(0xffdcd8e4),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f2fe),
      surfaceContainer: Color(0xfff0ecf8),
      surfaceContainerHigh: Color(0xffeae6f3),
      surfaceContainerHighest: Color(0xffe4e1ed),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2508b0),
      surfaceTint: Color(0xff5148d7),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4338ca),
      onPrimaryContainer: Color(0xfff4f0ff),
      secondary: Color(0xff312f68),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6967a3),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff630069),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8a1c90),
      onTertiaryContainer: Color(0xffffedf9),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff111018),
      onSurfaceVariant: Color(0xff363543),
      outline: Color(0xff525160),
      outlineVariant: Color(0xff6d6b7c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff302f39),
      inversePrimary: Color(0xffc3c0ff),
      primaryFixed: Color(0xff6058e7),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff473ccd),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6967a3),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff504e89),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffab3eaf),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff8e2194),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc8c5d1),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f2fe),
      surfaceContainer: Color(0xffeae6f3),
      surfaceContainerHigh: Color(0xffdfdbe7),
      surfaceContainerHighest: Color(0xffd3d0dc),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1c0098),
      surfaceTint: Color(0xff5148d7),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3a2dc2),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff27255d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff45437c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff530058),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff800e87),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2b2b39),
      outlineVariant: Color(0xff494857),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff302f39),
      inversePrimary: Color(0xffc3c0ff),
      primaryFixed: Color(0xff3a2dc2),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2100ab),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff45437c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2e2b64),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff800e87),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5d0063),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbab7c3),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3effb),
      surfaceContainer: Color(0xffe4e1ed),
      surfaceContainerHigh: Color(0xffd6d3df),
      surfaceContainerHighest: Color(0xffc8c5d1),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc3c0ff),
      surfaceTint: Color(0xffc3c0ff),
      onPrimary: Color(0xff1f00a4),
      primaryContainer: Color(0xff4338ca),
      onPrimaryContainer: Color(0xffc1beff),
      secondary: Color(0xffc3c0ff),
      onSecondary: Color(0xff2c2961),
      secondaryContainer: Color(0xff42407a),
      onSecondaryContainer: Color(0xffb1aff0),
      tertiary: Color(0xffffa9fa),
      onTertiary: Color(0xff5a005f),
      tertiaryContainer: Color(0xff8a1c90),
      onTertiaryContainer: Color(0xffffa6fb),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff13121b),
      onSurface: Color(0xffe4e1ed),
      onSurfaceVariant: Color(0xffc7c4d7),
      outline: Color(0xff918fa0),
      outlineVariant: Color(0xff464554),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1ed),
      inversePrimary: Color(0xff5148d7),
      primaryFixed: Color(0xffe3dfff),
      onPrimaryFixed: Color(0xff100069),
      primaryFixedDim: Color(0xffc3c0ff),
      onPrimaryFixedVariant: Color(0xff372abf),
      secondaryFixed: Color(0xffe3dfff),
      onSecondaryFixed: Color(0xff16124c),
      secondaryFixedDim: Color(0xffc3c0ff),
      onSecondaryFixedVariant: Color(0xff42407a),
      tertiaryFixed: Color(0xffffd6f8),
      onTertiaryFixed: Color(0xff37003b),
      tertiaryFixedDim: Color(0xffffa9fa),
      onTertiaryFixedVariant: Color(0xff7d0884),
      surfaceDim: Color(0xff13121b),
      surfaceBright: Color(0xff393842),
      surfaceContainerLowest: Color(0xff0e0d15),
      surfaceContainerLow: Color(0xff1b1b23),
      surfaceContainer: Color(0xff1f1f27),
      surfaceContainerHigh: Color(0xff2a2932),
      surfaceContainerHighest: Color(0xff35343d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdcd8ff),
      surfaceTint: Color(0xffc3c0ff),
      onPrimary: Color(0xff170086),
      primaryContainer: Color(0xff8681ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffdcd8ff),
      onSecondary: Color(0xff201e56),
      secondaryContainer: Color(0xff8d8ac9),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffcdf8),
      onTertiary: Color(0xff48004c),
      tertiaryContainer: Color(0xffd564d6),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff13121b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdddaed),
      outline: Color(0xffb3b0c2),
      outlineVariant: Color(0xff918ea0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1ed),
      inversePrimary: Color(0xff392bc1),
      primaryFixed: Color(0xffe3dfff),
      onPrimaryFixed: Color(0xff09004b),
      primaryFixedDim: Color(0xffc3c0ff),
      onPrimaryFixedVariant: Color(0xff2508b0),
      secondaryFixed: Color(0xffe3dfff),
      onSecondaryFixed: Color(0xff0b0542),
      secondaryFixedDim: Color(0xffc3c0ff),
      onSecondaryFixedVariant: Color(0xff312f68),
      tertiaryFixed: Color(0xffffd6f8),
      onTertiaryFixed: Color(0xff260029),
      tertiaryFixedDim: Color(0xffffa9fa),
      onTertiaryFixedVariant: Color(0xff630069),
      surfaceDim: Color(0xff13121b),
      surfaceBright: Color(0xff45434d),
      surfaceContainerLowest: Color(0xff07070e),
      surfaceContainerLow: Color(0xff1d1d25),
      surfaceContainer: Color(0xff282730),
      surfaceContainerHigh: Color(0xff32323b),
      surfaceContainerHighest: Color(0xff3e3d46),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff2eeff),
      surfaceTint: Color(0xffc3c0ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffbfbcff),
      onPrimaryContainer: Color(0xff05003a),
      secondary: Color(0xfff2eeff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbfbcff),
      onSecondaryContainer: Color(0xff05003a),
      tertiary: Color(0xffffeaf9),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffa2fb),
      onTertiaryContainer: Color(0xff1c001e),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff13121b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff2eeff),
      outlineVariant: Color(0xffc3c0d3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1ed),
      inversePrimary: Color(0xff392bc1),
      primaryFixed: Color(0xffe3dfff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc3c0ff),
      onPrimaryFixedVariant: Color(0xff09004b),
      secondaryFixed: Color(0xffe3dfff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc3c0ff),
      onSecondaryFixedVariant: Color(0xff0b0542),
      tertiaryFixed: Color(0xffffd6f8),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffa9fa),
      onTertiaryFixedVariant: Color(0xff260029),
      surfaceDim: Color(0xff13121b),
      surfaceBright: Color(0xff504f59),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1f1f27),
      surfaceContainer: Color(0xff302f39),
      surfaceContainerHigh: Color(0xff3b3a44),
      surfaceContainerHighest: Color(0xff47464f),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
