import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky/pages/add_task_page.dart';
import 'package:tasky/pages/home_page.dart';
import 'package:tasky/service_locator.dart';
import 'package:tasky/setup_config.dart';

void main() async {
  await setupConfig();
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            primary: const Color(0xff7f4123),
            secondary: const Color(0x887f4123),
            surfaceTint: Colors.transparent),
        useMaterial3: true,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        AddTaskPage.routeName: (context) => const AddTaskPage(),
      },
    );
  }
}
