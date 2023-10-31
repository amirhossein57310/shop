import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_apk/bloc/authentication/auth_bloc.dart';
import 'package:shop_apk/bloc/authentication/auth_event.dart';
import 'package:shop_apk/bloc/authentication/auth_state.dart';

import 'package:shop_apk/di/di.dart';

import 'package:shop_apk/screens/dashbord_screen.dart';
import 'package:shop_apk/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordConfirmTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(locator.get()),
      child: ViewContainer(
        usernameTextController: _usernameTextController,
        passwordTextController: _passwordTextController,
        passwordConfirmTextController: _passwordConfirmTextController,
      ),
    );
  }
}

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameTextController,
    required TextEditingController passwordTextController,
    required TextEditingController passwordConfirmTextController,
  })  : _usernameTextController = usernameTextController,
        _passwordTextController = passwordTextController,
        _passwordConfirmTextController = passwordConfirmTextController;

  final TextEditingController _usernameTextController;
  final TextEditingController _passwordTextController;
  final TextEditingController _passwordConfirmTextController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('images/register.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('نام کاربری :'),
                        Container(
                          color: Colors.grey[300],
                          child: TextField(
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: _usernameTextController,
                            style: TextStyle(fontSize: 18, fontFamily: 'sm'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, bottom: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('رمز عبور :'),
                        Container(
                          color: Colors.grey[300],
                          child: TextField(
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: _passwordTextController,
                            style: TextStyle(fontSize: 18, fontFamily: 'sm'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, bottom: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('تکرار رمز عبور  :'),
                        Container(
                          color: Colors.grey[300],
                          child: TextField(
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: _passwordConfirmTextController,
                            style: TextStyle(fontSize: 18, fontFamily: 'sm'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthResponseState) {
                        state.response.fold((l) {
                          var snackBar = SnackBar(
                            content: Text(l),
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _usernameTextController.text = '';
                          _passwordTextController.text = '';
                          _passwordConfirmTextController.text = '';
                        }, (r) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => DashbordScreen(),
                            ),
                          );
                        });
                      }
                    },
                    builder: ((context, state) {
                      if (state is AuthInitState) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle:
                                TextStyle(fontFamily: 'dana', fontSize: 20),
                            backgroundColor: Colors.blue[700],
                            minimumSize: Size(200, 48),
                          ),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthRegisterRequest(
                                _usernameTextController.text,
                                _passwordTextController.text,
                                _passwordConfirmTextController.text,
                              ),
                            );
                          },
                          child: Text(
                            'ثبت نام',
                            style: TextStyle(fontFamily: 'dana'),
                          ),
                        );
                      }

                      if (state is AuthLoadingState) {
                        return CircularProgressIndicator();
                      }
                      if (state is AuthResponseState) {
                        return state.response.fold((l) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle:
                                  TextStyle(fontFamily: 'dana', fontSize: 20),
                              backgroundColor: Colors.blue[700],
                              minimumSize: Size(200, 48),
                            ),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthRegisterRequest(
                                  _usernameTextController.text,
                                  _passwordTextController.text,
                                  _passwordConfirmTextController.text,
                                ),
                              );
                            },
                            child: Text(
                              'ثبت نام',
                              style: TextStyle(fontFamily: 'dana'),
                            ),
                          );
                        }, (r) {
                          return Text(
                            r,
                            style: TextStyle(fontFamily: 'dana', fontSize: 20),
                          );
                        });
                      }
                      return Text(
                        'خطای نامشخص',
                        style: TextStyle(fontFamily: 'dana', fontSize: 20),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'اگر حساب کاربری دارید وارد شوید',
                      style: TextStyle(fontFamily: 'dana', fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
