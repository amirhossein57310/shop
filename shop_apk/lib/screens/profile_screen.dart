import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_apk/bloc/authentication/auth_bloc.dart';
import 'package:shop_apk/constants/colors.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/screens/login_screen.dart';
import 'package:shop_apk/util/auth_manager.dart';

import '../bloc/authentication/auth_state.dart';
import '../main.dart';
import 'dashbord_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 44,
                right: 44,
                bottom: 32,
                top: 20,
              ),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset('images/icon_apple_blue.png'),
                    const Expanded(
                      child: Text(
                        'دسته بندی',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: CustomColor.blue,
                            fontFamily: 'SB',
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AuthManager.logout();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) {
                        var authBloc = AuthBloc(locator.get());
                        authBloc.stream.forEach((state) {
                          if (state is AuthResponseState) {
                            state.response.fold((l) {}, (r) {
                              return globalNavigatorKey.currentState
                                  ?.pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => DashbordScreen(),
                                ),
                              );
                            });
                          }
                        });
                        return authBloc;
                      },
                      child: LoginScreen(),
                    ),
                  ),
                );
              },
              child: Text(
                'خروج',
                style: TextStyle(
                  fontFamily: 'SB',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(
              'امیرحسین امینیان',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const Text(
              '09197442052',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 15,
                color: CustomColor.gery,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: const [],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 16,
                color: CustomColor.gery,
              ),
            ),
            const Text(
              'v-1.0.00',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 16,
                color: CustomColor.gery,
              ),
            ),
            const Text(
              'Instagram.com/Mojava-dev',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 16,
                color: CustomColor.gery,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
