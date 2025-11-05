import 'package:get/route_manager.dart';
import 'package:github_restapi/routes/routes_names.dart';
import 'package:github_restapi/views/auth/login_view.dart';
import 'package:github_restapi/views/details_view/repo_details_view.dart';
import 'package:github_restapi/views/home_view/home_view.dart';
import 'package:github_restapi/views/splash_screen.dart';

class AppRoutes {
  static final initial = RoutesNames.splashScreen;
  static final routes = <GetPage>[
    GetPage(
      name: RoutesNames.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RoutesNames.loginView,
      page: () => LoginView(),
    ),
    GetPage(
      name: RoutesNames.homeView,
      page: () => HomeView(),
    ),
    GetPage(
      name: RoutesNames.detailsView,
      page: () => RepoDetailsView(),
    ),
  ];
}
