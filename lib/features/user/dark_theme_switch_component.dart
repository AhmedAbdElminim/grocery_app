import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/app_theme_controller/app_theme_cubit.dart';
import '../../controllers/app_theme_controller/app_theme_states.dart';
import '../../shared/consts/constants.dart';

class DarkThemeSwitchComponent extends StatelessWidget {
  const DarkThemeSwitchComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppThemeCubit, AppThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SwitchListTile(
            title: Text(isDark ? 'Dark mode' : 'Light mode'),
            secondary: Icon(isDark
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onChanged: (bool value) {
              AppThemeCubit.get(context).changeAppTheme();
            },
            value: isDark,
          );
        });
  }
}


