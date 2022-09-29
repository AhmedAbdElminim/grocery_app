import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/controllers/app_theme_controller/app_theme_states.dart';
import 'package:grocery_app/shared/network/local.dart';

import '../../shared/consts/constants.dart';

class AppThemeCubit extends Cubit<AppThemeStates> {
  AppThemeCubit() : super(AppThemeInitialState());
  static AppThemeCubit get(context) => BlocProvider.of(context);
  void changeAppTheme() {
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark);
    emit(ChangeAppThemeState());
  }
}
