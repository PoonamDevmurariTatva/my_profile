import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_profile/utils/navigation/app_routes.dart';
import 'package:my_profile/utils/navigation/navigation_routes.dart';
import 'package:my_profile/utils/preference_constants.dart';
import 'package:my_profile/utils/preference_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      navigatorKey: navigationKey,
      onGenerateRoute: NavigationRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF000000, colorBlack),
      ),
      initialRoute: getInitialRoute(),
    );
  }

  static const Map<int, Color> colorBlack = {
    50: Color.fromRGBO(0, 0, 0, .1),
    100: Color.fromRGBO(0, 0, 0, .2),
    200: Color.fromRGBO(0, 0, 0, .3),
    300: Color.fromRGBO(0, 0, 0, .4),
    400: Color.fromRGBO(0, 0, 0, .5),
    500: Color.fromRGBO(0, 0, 0, .6),
    700: Color.fromRGBO(0, 0, 0, .8),
    600: Color.fromRGBO(0, 0, 0, .7),
    800: Color.fromRGBO(0, 0, 0, .9),
    900: Color.fromRGBO(0, 0, 0, 1),
  };

  getInitialRoute() {
    if (getBool(PreferenceConstant.isLoggedIn)) {
      return Screens.profile;
    } else {
      return Screens.login;
    }
  }
}