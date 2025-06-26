import 'package:blank_slate/themes/main_theme.dart';
import 'package:blank_slate/utils/appNavigation/router_config.dart';
import 'package:blank_slate/utils/service_locator.dart';
import 'package:blank_slate/utils/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(); // Loads env file
  await setUpLocator(); // Dependency Injector
  await locator<NotificationService>().initNotifications(); // Start listening for notifications
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final GoRouter _router = locator<AppRouter>().mainRouter;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //TODO: LIST YOUR PROVIDERS HERE
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'blank_slate',
          theme: MainTheme.defaultTheme,
          routerConfig: _router,
        ),
    );
  }
}

