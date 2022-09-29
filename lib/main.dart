import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/controllers/app_theme_controller/app_theme_cubit.dart';
import 'package:grocery_app/controllers/app_theme_controller/app_theme_states.dart';
import 'package:grocery_app/controllers/auth_controller/auth_cubit.dart';
import 'package:grocery_app/shared/consts/constants.dart';
import 'package:grocery_app/shared/consts/theme.dart';
import 'package:grocery_app/shared/network/local.dart';
import 'package:grocery_app/shared/route_manager/routes_manager.dart';

import 'features/auth/login/login_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/splash_screen/splash_screen.dart';
import 'layout/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  isDark = CacheHelper.getData(key: 'isDark') ?? false;
  bool isOnBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';
  if (isOnBoarding) {
    if (token != '') {
      startScreen = LayOut.layOutScreenId;
    } else {
      startScreen = LoginScreen.loginScreenId;
    }
  } else {
    startScreen = OnBoardingScreen.onBoardingScreenId;
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(
      token: token,
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.token});

  final String token;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppThemeCubit()),
          if (token != '')
            BlocProvider(
                create: (context) => AuthCubit()..getUserData(uId: token)),
        ],
        child: BlocConsumer<AppThemeCubit, AppThemeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (token != '') {
              context.read<AuthCubit>().getUserData(uId: token);
              //print('the value of user model is $userModel');
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Grocery App',
              theme: AppTheme.themeData(isDark, context),
              initialRoute: SplashScreen.splashScreenId,
              routes: RoutesManager.routs,
            );
          },
        ));
  }
}

//SHA1: 3F:52:C6:DD:90:95:90:40:36:28:DD:73:FB:23:A8:36:58:ED:2B:27
//SHA-256: 2E:B9:5E:12:39:1C:C0:69:C8:61:02:20:AA:B1:EC:25:16:7A:4F:D2:89:5C:0A:11:74:C7:9D:C6:95:76:4B:D4
