import 'package:MotivationApps/pages/add_scheduler_detail_page.dart';
import 'package:MotivationApps/pages/login_page.dart';
import 'package:MotivationApps/pages/registration_page.dart';
import 'package:auto_route/auto_route.dart';

import '../pages/category_page.dart';
import '../pages/master_page.dart';
import '../pages/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: CategoryPage),
    AutoRoute(page: MasterPage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegistrationPage),
    AutoRoute(page: AddSchedulerDetailPage),
  ],
)
class $AppRouter {}
