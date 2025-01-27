import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'welcome_screen.dart';
import 'profile_screen.dart';
import 'change_password_screen.dart';
import 'dashboard_screen.dart';
import 'map_screen.dart';
import 'create_ticket_screen.dart';
import 'screens/view_tickets_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
        '/map': (context) => const MapScreen(),
        '/create-ticket': (context) => const CreateTicketScreen(),
        '/view-tickets': (context) => const ViewTicketsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Set a solid background color
        ),
        padding: EdgeInsets.all(screenSize.width * 0.05), // 5% padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Use MediaQuery to adjust text size based on screen width
              Text(
                'You have pushed the button this many times:',
                style: TextStyle(fontSize: screenSize.width * 0.05), // 5% of screen width
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height * 0.02), // 2% of screen height
              Text(
                '$_counter',
                style: TextStyle(
                  fontSize: screenSize.width * 0.1, // 10% of screen width
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05), // 5% of screen height
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text('Increment Counter'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.1, // 10% of screen width
                    vertical: screenSize.height * 0.02, // 2% of screen height
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.05), // 5% of screen height
              // Additional widgets can be added here
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
