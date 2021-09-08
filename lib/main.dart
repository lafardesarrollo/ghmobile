import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghmobile/src/route_generator.dart';
import 'package:global_configuration/global_configuration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('configurations');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GHMobile',
      initialRoute: '/Splash',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DINPro',
        primaryColor: Color(0xFF009de0),
        secondaryHeaderColor: Colors.white,
        backgroundColor: Color(0xFFcceaf8),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        // brightness: brightness,
        accentColor: Color(0xFFa2c037), // config.Colors().mainColor(1),
        dividerColor: Color(0xFFa2c037).withOpacity(0.5),
        focusColor: Color(0xFFa2c037).withOpacity(1),
        hintColor: Color(0xFF294a96), // config.Colors().secondColor(1),

        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.black.withOpacity(0.8)),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white.withOpacity(1),
        ),
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        // scaffoldBackgroundColor: Colors.transparent.withOpacity(1),
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 20.0, color: Color(0xFF294a96)),
          bodyText2: TextStyle(fontSize: 20.0, color: Color(0xFF294a96)),
          button: TextStyle(fontSize: 14.0, color: Color(0xFF009de0)),
          subtitle1: TextStyle(fontSize: 16.0, color: Color(0xFF009de0)),
          subtitle2: TextStyle(fontSize: 16.0, color: Color(0xFF009de0)),
          caption: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              color: Color(0xFF009de0)),
          overline: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.white),
        ),
      ),
    );
  }
}
