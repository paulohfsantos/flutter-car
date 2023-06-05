import 'package:cars/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'cars/views/list_view.dart';
import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  // case CarDetailsView.routeName:
                  //   return const CarDetailsView();
                  // case CarsListView.routeName:
                  //   return const CarsListView();
                  // case EditCarView.routeName:
                  //   return const EditCarView();
                  default:
                    return CarsListView();
                }
              },
            );
          },
        );
      },
    );
  }
}
