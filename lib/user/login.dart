import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_example/user/register.dart';
import 'package:app_example/views/home_view/home_view.dart';
import 'package:app_example/style/app_colors.dart';
import 'package:app_example/views/home_view/home_view_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool isOpen = true, _startLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width,
            color: AppColors.brown,
          ),
          Positioned(
              top: 200,
              left: -20,
              right: -20,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        topRight: Radius.circular(100))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 40.0, right: 40.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20.0, right: 20.0),
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Text(
                                      'Welcome back',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 30,
                                          // fontFamily: "Poppins-Regular",
                                          color: AppColors.brown),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Login to your account',
                                        style: TextStyle(
                                            color: AppColors.negative,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w600))
                                  ],
                                )),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  (10.0),
                                ),
                                color: AppColors.negative,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 4.0,
                              ),
                              child: TextFormField(
                                controller: _email,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.person,
                                    color: AppColors.brown,
                                    size: 20,
                                  ),
                                  // filled: true,
                                  hintStyle: TextStyle(
                                      color: AppColors.brown,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      fontFamily: "Poppins"),
                                  hintText: 'Email',
                                  // fillColor: AppColor.textbackg.withOpacity(0.1),
                                  border: InputBorder.none,

                                  // OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(10),),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    (10.0),
                                  ),
                                  color: AppColors.negative),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 4.0,
                              ),
                              child: TextField(
                                obscureText: true,
                                controller: _pass,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.lock,
                                    color: AppColors.brown,
                                    size: 20,
                                  ),
                                  // filled: true,
                                  hintStyle: TextStyle(
                                      color: AppColors.brown,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19,
                                      fontFamily: "Poppins"),
                                  hintText: '.........',
                                  // fillColor: AppColor.textbackg.withOpacity(0.1),
                                  border: InputBorder.none,

                                  // OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(10),),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(
                                        Icons.check_circle,
                                        color: AppColors.brown,
                                        size: 17,
                                      )),
                                      TextSpan(
                                        text: 'Remember me',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            fontFamily: "Poppins"),
                                      ),
                                    ])),
                                const SizedBox(
                                  width: 110,
                                ),
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: AppColors.description,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            _startLoading
                                ? Center(
                                    child: const CircularProgressIndicator())
                                : GestureDetector(
                                    onTap: () {
                                      // print('this gggg');
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => const Login()));
                                      if (_formKey.currentState!.validate()) {
                                        handleRegister(_email.text, _pass.text);
                                      }
                                      //  else {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) => const Login()));
                                      // }
                                    },
                                    child: Container(
                                      // width: 65,
                                      // height: 34,
                                      padding: const EdgeInsets.all(8.0),
                                      width: 400,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: AppColors.brown,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Profile()));
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 3,
                                          color: AppColors.brown,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                        ),
                                      )),
                                ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _pass = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  Future<void> handleRegister(String email, String password) async {
    startLoading();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      )
          .then((value) {
        stopLoading();
        snackBar('Login sucessfull');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeView(HomeViewModel())));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        snackBar('Wrong password provided for that user.');
      }
      //catch holds the error
    } catch (e) {
      snackBar(e.toString());
    }
    stopLoading();
  }

  void startLoading() {
    setState(() => _startLoading = true);
  }

  void stopLoading() {
    setState(() => _startLoading = false);
  }

  snackBar(String title) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(title)));
  }
}
