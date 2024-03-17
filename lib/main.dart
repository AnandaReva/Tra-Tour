//import 'dart:convert';
// ignore_for_file: prefer_const_constructors

import 'dart:io';

//import 'package:tratour/components/drawer.dart';
import 'package:tratour/database/auth.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/pages/homePage.dart';
import 'package:tratour/pages/login_register_page.dart';
import 'package:tratour/pages/orderPage.dart';
import 'package:tratour/pages/socialPage.dart';
import 'package:tratour/pages/sortTrash.dart';

import 'package:tratour/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tratour/components/appBar.dart';
import 'package:tratour/Pages/ProfilePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalVar globalVar = GlobalVar.instance;

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBxDijkEkT9meAuvaAPUIcM9NLW0S46O7w',
              appId: '1:525346093175:android:e0136e9c61854d9f0dee72',
              messagingSenderId: '525346093175',
              projectId: 'tra-tour',
              storageBucket: "tra-tour.appspot.com"))
      : await Firebase.initializeApp();

  // Load user data before building the app
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userEmail = user.email ?? "Terjadi Kesalahan saat mengambil data";
    print("User email firebase: $userEmail");

    // Load user data
    await LoginPageState().findUserDataFromDB(userEmail);
    print('debug m1: ${globalVar.userLoginData}');
  }

  // Build the app passing user data to RootPage
  runApp(MyApp(globalVar: globalVar, userData: globalVar.userLoginData));
}

class MyApp extends StatelessWidget {
  final GlobalVar globalVar;
  final Map<String, dynamic>? userData; // Define userData parameter

  const MyApp({Key? key, required this.globalVar, required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tra-tour',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WidgetTree(),
    );
  }
}

class MainPage extends StatefulWidget {
  final GlobalVar globalVar;
  MainPage({Key? key, required this.globalVar}) : super(key: key);

  final User? user = Auth().currentUser;

  @override
  State<MainPage> createState() => _MainState(globalVar: globalVar);
}

class _MainState extends State<MainPage> with TickerProviderStateMixin {
  final GlobalVar globalVar;
  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;

  final List<Destination> allDestinations = [
    Destination(0, 'Beranda', Icons.home, Colors.blue),
    Destination(1, 'Pesanan', Icons.reorder, Colors.green),
    Destination(2, 'Pilah Sampah', Icons.add_circle, Colors.red),
    Destination(3, 'Sosial', Icons.groups, Colors.purple),
    Destination(4, 'Profile', Icons.person, Colors.brown),
    // Add more destinations as needed
  ];
  _MainState({required this.globalVar});

  @override
  void initState() {
    super.initState();

    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      allDestinations.length,
      (int index) => GlobalKey(),
    ).toList();

    destinationFaders = List<AnimationController>.generate(
      allDestinations.length,
      (int index) => buildFaderController(),
    ).toList();
    destinationFaders[globalVar.selectedIndex].value = 1.0;

    final CurveTween tween = CurveTween(curve: Curves.fastOutSlowIn);
    destinationViews = allDestinations.map<Widget>(
      (Destination destination) {
        return FadeTransition(
          opacity: destinationFaders[destination.index].drive(tween),
          child: DestinationView(
            destination: destination,
            navigatorKey: navigatorKeys[destination.index],
          ),
        );
      },
    ).toList();
  }

  AnimationController buildFaderController() {
    final AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {}); // Rebuild unselected destinations offstage.
        }
      },
    );
    return controller;
  }

  @override
  void dispose() {
    for (final AnimationController controller in destinationFaders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        final NavigatorState navigator =
            navigatorKeys[globalVar.selectedIndex].currentState!;
        navigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: allDestinations.map(
              (Destination destination) {
                final int index = destination.index;
                final Widget view = destinationViews[index];
                if (index == globalVar.selectedIndex) {
                  destinationFaders[index].forward();
                  return Offstage(offstage: false, child: view);
                } else {
                  destinationFaders[index].reverse();
                  if (destinationFaders[index].isAnimating) {
                    return IgnorePointer(child: view);
                  }
                  return Offstage(child: view);
                }
              },
            ).toList(),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: globalVar.selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              globalVar.selectedIndex = index;
            });
          },
          destinations: allDestinations.map<NavigationDestination>(
            (Destination destination) {
              return NavigationDestination(
                icon: Icon(destination.icon, color: destination.color),
                label: destination.title,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.color);
  final int index;
  final String title;
  final IconData icon;
  final MaterialColor color;
}

class RootPage extends StatefulWidget {
  final Destination destination;
  final Map<String, dynamic>? userData; // Define userData parameter

  const RootPage({Key? key, required this.destination, required this.userData})
      : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  DateTime? currentBackPressTime;
  Map<String, dynamic>? userData; // Mendefinisikan userData

  @override
  void initState() {
    super.initState();
    // Memanggil initState akan memastikan bahwa data pengguna diperbarui saat halaman diinisialisasi
    _updateUserData();
  }

  // Method untuk memperbarui data pengguna dan memicu pembaruan widget
  void _updateUserData() {
    setState(() {
      // Memperbarui data pengguna dengan data baru
      userData = widget.userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.destination.index != 4 ? MyAppBar() : null,
      backgroundColor: widget.destination.color[50],
      body: _buildPage(context), // Build the appropriate page
    );
  }

  Widget _buildPage(BuildContext context) {
    // Return the appropriate widget based on the destination
    switch (widget.destination.index) {
      case 0:
        return HomePage(userData: userData);
      case 1:
        return OrderPage();
      case 2:
        return SortTrash();
      case 3:
        return SocialPage();
      case 4:
        return ProfilePage();
      default:
        return const SizedBox(); // Return an empty widget for unknown destinations
    }
  }
}

class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination,
    required this.navigatorKey,
  });

  final Destination destination;
  final Key navigatorKey;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return RootPage(
                  destination: widget.destination,
                  userData: {},
                );
              /* case '/list':
                return ListPage(destination: widget.destination);
              case '/text':
                return TextPage(destination: widget.destination); */
            }
            assert(false);
            return const SizedBox();
          },
        );
      },
    );
  }
}

class NavigationBar extends StatelessWidget {
  final int selectedIndex;
  final List<NavigationDestination> destinations;
  final ValueChanged<int> onDestinationSelected;

  const NavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
          icon: destination.icon,
          label: destination.label,
        );
      }).toList(),
    );
  }
}
