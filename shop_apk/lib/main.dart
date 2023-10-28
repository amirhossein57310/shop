import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_apk/data/model/basket_item.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/screens/dashbord_screen.dart';
import 'package:shop_apk/screens/login_screen.dart';
import 'package:shop_apk/util/auth_manager.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('basketItem');
  await getItInit();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int bottomNavodatorIndex = 3;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      home: (AuthManager.readAuth().isEmpty) ? LoginScreen() : DashbordScreen(),
    );
  }
}
