import 'package:flutter/material.dart';
import 'package:scrummy/screens/panel_screen.dart';
import 'auth/auth.dart';
import 'package:provider/provider.dart';
import './screens/location_screen.dart';
import './screens/home_screen.dart';
import 'auth/verify.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
  }
}
