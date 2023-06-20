import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:shop_apk/bloc/authentication/auth_bloc.dart';
import 'package:shop_apk/bloc/banner/banner_bloc.dart';
import 'package:shop_apk/bloc/basket/basket_bloc.dart';
import 'package:shop_apk/bloc/basket/basket_event.dart';
import 'package:shop_apk/bloc/category/category_bloc.dart';

import 'package:shop_apk/constants/colors.dart';

import 'package:shop_apk/data/model/basket_item.dart';

import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/screens/card_screen.dart';
import 'package:shop_apk/screens/category_screen.dart';
import 'package:shop_apk/screens/home_screen.dart';
import 'package:shop_apk/screens/login_screen.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 40,
              sigmaY: 40,
            ),
            child: BottomNavigationBar(
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 14,
                color: Colors.black,
              ),
              selectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 14,
                color: CustomColor.blue,
              ),
              onTap: (int index) {
                setState(() {
                  bottomNavodatorIndex = index;
                });
              },
              currentIndex: bottomNavodatorIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('images/icon_profile.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset('images/icon_profile_active.png'),
                    ),
                  ),
                  label: 'حساب کاربری',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('images/icon_basket.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset('images/icon_basket_active.png'),
                    ),
                  ),
                  label: 'سبد خرید',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('images/icon_category.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset('images/icon_category_active.png'),
                    ),
                  ),
                  label: 'دسته بندی',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('images/icon_home.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset('images/icon_home_active.png'),
                    ),
                  ),
                  label: 'خانه',
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: bottomNavodatorIndex,
          children: getScreens(),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      BlocProvider(
        create: ((context) => AuthBloc(locator.get())),
        child: LoginScreen(),
      ),
      BlocProvider(
        create: (context) {
          var bloc = locator.get<BasketBloc>();
          bloc.add(BasketFetchHiveEvent());
          return bloc;
        },
        child: CardScreen(),
      ),
      BlocProvider(
        create: ((context) => CategoryBloc(locator.get())),
        child: CategoryScreen(),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: ((context) =>
              BannerBloc(locator.get(), locator.get(), locator.get())),
          child: HomeScreen(),
        ),
      ),
    ];
  }
}
