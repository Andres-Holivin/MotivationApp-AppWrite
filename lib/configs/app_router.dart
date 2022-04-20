import 'package:appwrite/pages/home_page.dart';
import 'package:appwrite/pages/login_page.dart';
import 'package:appwrite/pages/splash_page.dart';
import 'package:auto_route/auto_route.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: HomePage),
  ],
)
class $AppRouter {}
