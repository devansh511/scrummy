import 'package:flutter/material.dart';
import 'package:scrummy/providers/cart.dart';
import 'package:scrummy/screens/panel_screen.dart';
import './auth/auth_screen.dart';
import 'auth/auth.dart';
import 'package:provider/provider.dart';
import './screens/location_screen.dart';
import './screens/home_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/splash_screen.dart';
import './providers/food.dart';
import 'auth/verify.dart';
import './providers/search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Food(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Search(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
        ),
      ),
    );
  }
}
