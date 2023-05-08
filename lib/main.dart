import 'package:flutter/material.dart';
import 'package:market_place/views/viewsUtil/custom_colors.dart';

import 'views/dashboard/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: const TextTheme(
            titleMedium: TextStyle(
                color: CustomColors.lightColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            bodyLarge: TextStyle(color: CustomColors.ash),
            bodySmall: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: CustomColors.ash),
          )),
      home: const Dashboard(),
    );
  }
}
