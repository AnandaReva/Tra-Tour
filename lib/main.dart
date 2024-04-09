//import 'dart:convert';
// ignore_for_file: prefer_const_constructors

import 'dart:io';

//import 'package:tratour/components/drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tratour/globalVar.dart';
import 'package:tratour/onboarding/onboarding_screen.dart';

import 'package:tratour/pages/orderProcess.dart';
import 'package:tratour/pages/homePage.dart';
import 'package:tratour/pages/login_register_page.dart';
import 'package:tratour/pages/orderPage.dart';
import 'package:tratour/pages/socialPage.dart';
import 'package:tratour/pages/sortTrashPage.dart';

import 'package:tratour/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tratour/components/appBar.dart';
import 'package:tratour/Pages/ProfilePage.dart';

int initScreen = 0;

/* Future<void> resetInitScreen() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('initScreen');
} */

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

//reset initScreen
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  //  await prefs.remove('initScreen');

  initScreen = prefs.getInt("initScreen") ?? 0;
  await prefs.setInt("initScreen", 1); // set to 1 if not exist, otherwise 0
  ///////////////////

  print('initScreen Main: $initScreen');

  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userEmail = user.email ?? "Terjadi Kesalahan saat mengambil data";
    print("User email firebase: $userEmail");

    // Load user data
    await LoginPageState().findUserDataFromDB(userEmail);
    print('cek user: ${globalVar.userLoginData}');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalVar.instance),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalVar globalVar = Provider.of<GlobalVar>(context);
    return MaterialApp(
      title: 'Tra-tour',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: GlobalVar.mainColor),
      ),
      initialRoute: globalVar.isOrdering
          ? 'inOrder'
          : (initScreen == 0 ? 'onboard' : 'widgetTree'),
      routes: {
        'widgetTree': (context) => WidgetTree(globalVar: globalVar),
        'onboard': (context) => OnBoardingScreen(globalVar: globalVar),
        'inOrder': (context) => OrderProcess(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainState();
}

class _MainState extends State<MainPage> with TickerProviderStateMixin {
  late final GlobalVar globalVar;
  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;
  final List<Destination> allDestinations = [
    Destination(0, 'Beranda', Icons.home, GlobalVar.mainColor),
    Destination(1, 'Pesanan', Icons.list, GlobalVar.mainColor),
    Destination(2, 'Pilah Sampah', Icons.add_circle, GlobalVar.mainColor),
    Destination(3, 'Sosial', Icons.groups, GlobalVar.mainColor),
    Destination(4, 'Profile', Icons.person, GlobalVar.mainColor),
    // Add more destinations as needed
  ];

  @override
  void initState() {
    super.initState();
    globalVar = Provider.of<GlobalVar>(context, listen: false);

    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      allDestinations.length,
      (int index) => GlobalKey(),
    ).toList();

    destinationFaders = List<AnimationController>.generate(
      allDestinations.length,
      (int index) => buildFaderController(),
    ).toList();
    destinationFaders[globalVar.selectedIndex].value = 1.0;

    // Inisialisasi destinationViews dengan tampilan dari setiap destinasi
    destinationViews = [
      HomePage(userData: globalVar.userLoginData),
      OrderPage(),
      SortTrashPage(globalVar: globalVar),
      SocialPage(),
      ProfilePage(),
    ];
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
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.color);
  final int index;
  final String title;
  final IconData icon;
  final Color color;
}

class RootPage extends StatefulWidget {
  final Destination destination;
  final Map<String, dynamic>? userData; // Tambahkan parameter userData

  const RootPage({Key? key, required this.destination, this.userData})
      : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late final GlobalVar globalVar;
  late Map<String, dynamic>? userData; // Define userData parameter

  @override
  void initState() {
    super.initState();
    globalVar = Provider.of<GlobalVar>(context, listen: false);
    // Memanggil initState akan memastikan bahwa data pengguna diperbarui saat halaman diinisialisasi
    _updateUserData();
  }

  // Method untuk memperbarui data pengguna dan memicu pembaruan widget
  void _updateUserData() {
    setState(() {
      // Memperbarui data pengguna dengan data baru
      userData = globalVar.userLoginData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.destination.index != 4 ? MyAppBar() : null,
      //  backgroundColor: widget.destination.color[50],
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
        return SortTrashPage(globalVar: globalVar);
      case 3:
        return SocialPage();
      case 4:
        return ProfilePage();
      default:
        return const SizedBox();
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
    return Container(
      decoration: BoxDecoration(
        color: GlobalVar.baseColor, // Set the background color here
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors
            .transparent, // Make the BottomNavigationBar background transparent
        currentIndex: selectedIndex,
        onTap: onDestinationSelected,
        items: destinations.map<BottomNavigationBarItem>(
          (NavigationDestination destination) {
            return BottomNavigationBarItem(
              backgroundColor: GlobalVar
                  .baseColor, // Set the background color for the BottomNavigationBar item
              icon: destination.icon,
              label: destination.label,
            );
          },
        ).toList(),
      ),
    );
  }
}
