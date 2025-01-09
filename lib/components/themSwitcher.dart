import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/theme/themes.dart';

Widget telegramSwitchButton() {
  return ThemeSwitcher(
    clipper: const ThemeSwitcherCircleClipper(),
    builder: (context) {
      return IconButton(
        icon: Icon(
          color: Theme.of(context).colorScheme.primary,
          ThemeModelInheritedNotifier.of(context).theme.brightness ==
                  Brightness.light
              ? Icons.dark_mode
              : Icons.light_mode,
        ),
        onPressed: () {
          var brightness =
              ThemeModelInheritedNotifier.of(context).theme.brightness;
          ThemeSwitcher.of(context).changeTheme(
            theme: brightness == Brightness.light
                ? Themes().darkMode
                : Themes().lightMode,
            isReversed: brightness == Brightness.light,
          );
        },
      );
    },
  );
}
