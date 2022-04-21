import 'package:auto_route/auto_route.dart';

import '../pages/home_page.dart';
import '../pages/splash_page.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: HomePage),
  ],
)
class $AppRouter {}
