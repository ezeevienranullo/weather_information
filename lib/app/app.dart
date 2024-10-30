import 'package:weather_info/ui/views/home/home_view.dart';
import 'package:weather_info/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/weather_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: WeatherService),

    // @stacked-service
  ],
)
class App {}
