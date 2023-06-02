import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_apk/bloc/authentication/auth_bloc.dart';
import 'package:shop_apk/bloc/authentication/auth_event.dart';
import 'package:shop_apk/bloc/authentication/auth_state.dart';
import 'package:shop_apk/constants/colors.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key}) : super(key: key);
//   final _usernameTextController = TextEditingController(text: 'amiramini121');
//   final _passwordTextController = TextEditingController(text: '12345678');
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: CustomColor.blue,
//         body: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'images/icon_application.png',
//                       width: 100,
//                       height: 100,
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text(
//                       'اپل شاپ',
//                       style: TextStyle(
//                         fontFamily: 'sb',
//                         fontSize: 24,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.all(20),
//                   padding: const EdgeInsets.all(20),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextField(
//                         controller: _usernameTextController,
//                         decoration: const InputDecoration(
//                           label: Text(
//                             'نام کاربری',
//                           ),
//                           labelStyle: TextStyle(
//                             fontFamily: 'sm',
//                             fontSize: 20,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(20),
//                             ),
//                             borderSide: BorderSide(
//                               color: Colors.black,
//                               width: 3,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(20),
//                             ),
//                             borderSide: BorderSide(
//                               color: CustomColor.blue,
//                               width: 3,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextField(
//                         controller: _passwordTextController,
//                         decoration: const InputDecoration(
//                           label: Text(
//                             'رمز عبور',
//                           ),
//                           labelStyle: TextStyle(
//                             fontFamily: 'sm',
//                             fontSize: 20,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(20),
//                             ),
//                             borderSide: BorderSide(
//                               color: Colors.black,
//                               width: 3,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(20),
//                             ),
//                             borderSide: BorderSide(
//                               color: CustomColor.blue,
//                               width: 3,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       BlocBuilder<AuthBloc, AuthState>(
//                           builder: ((context, state) {
//                         if (state is AuthInitState) {
//                           return ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               textStyle: const TextStyle(
//                                   fontFamily: 'sb',
//                                   fontSize: 18,
//                                   color: Colors.white),
//                               minimumSize: const Size(200, 48),
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(20),
//                                 ),
//                               ),
//                             ),
//                             onPressed: () {
//                               BlocProvider.of<AuthBloc>(context).add(
//                                   AuthLoginRequest(_usernameTextController.text,
//                                       _passwordTextController.text));
//                             },
//                             child: const Text(
//                               'ورود به حساب کاربری',
//                             ),
//                           );
//                         }
//                         if (state is AuthLoadingState) {
//                           return CircularProgressIndicator();
//                         }
//                         if (state is AuthResponseState) {
//                           Text widget = Text('');

//                           state.response.fold((l) {
//                             widget = Text(l);
//                           }, (r) {
//                             widget = Text(r);
//                           });
//                           return widget;
//                         }
//                         return Text('خطای نامشخص');
//                       }))
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _usernameTextController = TextEditingController(text: 'amiramini121');
  final _passwordTextController = TextEditingController(text: '12345678');
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColor.blue,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/icon_application.png',
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'فروشگاه اپل',
                      style: TextStyle(fontFamily: 'sm', fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _usernameTextController,
                        style: TextStyle(fontSize: 18, fontFamily: 'sm'),
                        decoration: InputDecoration(
                          label: Text('نام کاربری'),
                          labelStyle: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(width: 3, color: Colors.greenAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(width: 3, color: Colors.pink),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _passwordTextController,
                        style: TextStyle(fontSize: 18, fontFamily: 'sm'),
                        decoration: InputDecoration(
                          label: Text('رمز عبور'),
                          labelStyle: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(width: 3, color: Colors.greenAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(width: 3, color: Colors.pink),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: ((context, state) {
                          if (state is AuthInitState) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(15),
                                ),
                                textStyle: TextStyle(
                                  fontFamily: 'sb',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthLoginRequest(
                                    _usernameTextController.text,
                                    _passwordTextController.text,
                                  ),
                                );
                              },
                              child: Text('ورود به حساب کاربری'),
                            );
                          }
                          if (state is AuthLoadingState) {
                            return CircularProgressIndicator();
                          }
                          if (state is AuthResponseState) {
                            return state.response.fold((l) {
                              return Text(
                                l,
                                style:
                                    TextStyle(fontFamily: 'sb', fontSize: 20),
                              );
                            }, (r) {
                              return Text(
                                r,
                                style:
                                    TextStyle(fontFamily: 'sb', fontSize: 20),
                              );
                            });
                          }
                          return Text(
                            'خطای نامشخص',
                            style: TextStyle(fontFamily: 'sb', fontSize: 20),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
