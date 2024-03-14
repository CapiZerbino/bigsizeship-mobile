import 'package:bigsizeship_mobile/core/common/app/providers/user_provider.dart';
import 'package:bigsizeship_mobile/core/resources/colours.dart';
import 'package:bigsizeship_mobile/core/services/injection_container.dart';
import 'package:bigsizeship_mobile/core/services/router.dart';
import 'package:bigsizeship_mobile/src/home/presentation/providers/home_controller.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: BackGestureWidthTheme(
        backGestureWidth: BackGestureWidth.fraction(1 / 2),
        child: MaterialApp(
          title: 'Bigsize Ship',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colours.primaryColour),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(color: Colors.transparent),
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS:
                    CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              },
            ),
          ),
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}
