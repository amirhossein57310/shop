import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_apk/bloc/authentication/auth_bloc.dart';
import 'package:shop_apk/bloc/authentication/auth_event.dart';
import 'package:shop_apk/bloc/authentication/auth_state.dart';
import 'package:shop_apk/di/di.dart';
import 'package:shop_apk/screens/dashbord_screen.dart';
import 'package:shop_apk/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(locator.get()),
      child: ViewContainer(
          usernameTextController: _usernameTextController,
          passwordTextController: _passwordTextController),
    );
  }
}

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameTextController,
    required TextEditingController passwordTextController,
  })  : _usernameTextController = usernameTextController,
        _passwordTextController = passwordTextController;

  final TextEditingController _usernameTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('images/login_photo.jpg'),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نام کاربری :',
                        style: TextStyle(fontFamily: 'dana', fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: TextField(
                          controller: _usernameTextController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رمز عبور:',
                        style: TextStyle(fontFamily: 'dana', fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: TextField(
                          controller: _passwordTextController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthBloc, AuthState>(listener: ((context, state) {
                  //logic
                  //toast //snack //diaolg //navigate
                  if (state is AuthResponseState) {
                    state.response.fold((l) {
                      _usernameTextController.text = '';
                      _passwordTextController.text = '';
                      var snackbar = SnackBar(
                        content: Text(
                          l,
                          style: TextStyle(fontFamily: 'dana', fontSize: 14),
                        ),
                        backgroundColor: Colors.black,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }, (r) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => DashbordScreen()));
                    });
                  }
                }), builder: ((context, state) {
                  if (state is AuthInitState) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontFamily: 'dana', fontSize: 20),
                        backgroundColor: Colors.blue[700],
                        minimumSize: Size(200, 48),
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(AuthLoginRequest(
                            _usernameTextController.text,
                            _passwordTextController.text));
                      },
                      child: Text('ورود به حساب کاربری'),
                    );
                  }

                  if (state is AuthLoadingState) {
                    return CircularProgressIndicator();
                  }

                  if (state is AuthResponseState) {
                    Widget widget = Text('');
                    state.response.fold((l) {
                      widget = ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle:
                              TextStyle(fontFamily: 'dana', fontSize: 20),
                          backgroundColor: Colors.blue[700],
                          minimumSize: Size(200, 48),
                        ),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                              AuthLoginRequest(_usernameTextController.text,
                                  _passwordTextController.text));
                        },
                        child: Text('ورود به حساب کاربری'),
                      );
                    }, (r) {
                      widget = Text(r);
                    });
                    return widget;
                  }

                  return Text('خطای نا مشخص !');
                })),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return RegisterScreen();
                      }));
                    },
                    child: Text(
                      'اگر حساب کاربری ندارید ثبت نام کنید',
                      style: TextStyle(fontFamily: 'dana', fontSize: 16),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
