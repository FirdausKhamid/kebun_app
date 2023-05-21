import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kebun_app/authentication/login.dart';
import 'package:kebun_app/screens/activity/activity_screen.dart';
import 'package:kebun_app/screens/assets/assets_screen.dart';
import 'package:kebun_app/screens/employee/employee_screen.dart';
import 'package:kebun_app/screens/market/market_screen.dart';
import 'package:kebun_app/screens/yield/yield_screen.dart';
import 'package:kebun_app/authentication/register_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kebun App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen, // Set the primary color
        // primaryColor: Color.fromRGBO(119, 185, 94, 1), // Set the primary color
        scaffoldBackgroundColor: Colors.white,
        //textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const MyWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final primaryColor = const Color(0xFF1E1E1E);
  final secondaryColor = const Color.fromRGBO(99, 201, 142, 1);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  int currentIndex = 2;

  final screen = [
    Employee(),
    Activity(),
    Yield(),
    // Assets(),
    Market(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 110,
        child: BottomNavigationBar(
          //Item Selection
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryColor,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          //Item List
          items: [
            BottomNavigationBarItem(
              label: "Employee",
              icon: Icon(Icons.people),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Activtiy",
              icon: Icon(Icons.list_alt_rounded),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Yield",
              icon: Icon(Icons.bar_chart_rounded),
              backgroundColor: primaryColor,
            ),
            // BottomNavigationBarItem(
            //   label: "Assets",
            //   icon: Icon(Icons.house_rounded),
            //   backgroundColor: primaryColor,
            // ),
            BottomNavigationBarItem(
              label: "Market",
              icon: Icon(Icons.shopping_cart_rounded),
              backgroundColor: primaryColor,
            ),
          ],
        ),
      ),
      body: Center(
        child: screen[currentIndex],
      ),
    );
  }
}
