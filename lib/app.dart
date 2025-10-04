import 'package:eduwrite/services/loader_service.dart';
import 'package:eduwrite/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/user/home_screen.dart';
import 'screens/user/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Edu Write',
      theme: theme,
      home: RootPage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: LoaderService.navigatorKey,
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (!snapshot.hasData) {
          return HomeScreen();
        }

        return DashboardScreen();
      },
    );
  }
}
