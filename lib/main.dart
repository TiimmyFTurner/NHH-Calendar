import 'package:flutter/material.dart';
import 'package:nhh_calendar/Pages/Home/home.dart';
import 'package:nhh_calendar/providers/providers.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Events()),
          ChangeNotifierProvider(create: (_) => Settings())
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Provider.of<Settings>(context, listen: false).readSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NHH Calendar',
      theme: Provider.of<Settings>(context).themeData,
      darkTheme: Provider.of<Settings>(context).darkTheme,
      home: HomePage(Provider.of<Events>(context).events),
    );
  }
}
