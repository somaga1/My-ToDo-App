import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:app_example/views/home_view/home_view.dart';
import 'package:app_example/user/login.dart';
import 'package:app_example/style/app_colors.dart';
import 'package:app_example/views/home_view/home_view_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 50.0,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text(
                          'Registar',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              // fontFamily: "Poppins-Regular",
                              color: AppColors.brown),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Create your new account',
                            style: TextStyle(
                                color: AppColors.description,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600))
                      ],
                    )),
                SizedBox(
                  height: 30.0,
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
                      hintText: 'Full Name',
                      // fillColor: AppColor.textbackg.withOpacity(0.1),
                      border: InputBorder.none,

                      // OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),),
                    ),
                  ),
                ),
                SizedBox(
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
                    controller: _email,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.mail,
                        color: AppColors.brown,
                        size: 20,
                      ),
                      // filled: true,
                      hintStyle: TextStyle(
                          color: AppColors.brown,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          fontFamily: "Poppins"),
                      hintText: 'johndoe@gmail.com',
                      // fillColor: AppColor.textbackg.withOpacity(0.1),
                      border: InputBorder.none,

                      // OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),),
                    ),
                  ),
                ),
                SizedBox(
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
                    controller: _pass,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
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
                          fontSize: 15,
                          fontFamily: "Poppins"),
                      hintText: 'Password',
                      // fillColor: AppColor.textbackg.withOpacity(0.1),
                      border: InputBorder.none,

                      // OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'By signing, you agree to our',
                        style: TextStyle(
                            color: AppColors.brown,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            fontFamily: "Poppins"),
                      ),
                      TextSpan(
                        text: ' Terms of use',
                        style: TextStyle(
                            color: AppColors.description,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            fontFamily: "Poppins"),
                      ),
                      TextSpan(
                        text: ' and',
                        style: TextStyle(
                            color: AppColors.brown,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            fontFamily: "Poppins"),
                      ),
                      TextSpan(
                        text: ' privacy notice',
                        style: TextStyle(
                            color: AppColors.description,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            fontFamily: "Poppins"),
                      ),
                    ])),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      handleRegister(_email.text, _pass.text);
                    }
                    // else {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const Profile()));
                    // }
                  },
                  child: Container(
                    // width: 65,
                    // height: 34,
                    padding: EdgeInsets.all(8.0),
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.brown,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: AppColors.description,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 3,
                              color: AppColors.brown,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          )),
                    ])
              ]),
            ),
          ),
        ));
  }

  Future<void> handleRegister(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  HomeView(HomeViewModel())));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        snackBar('The account already exists for that email.');
      }
    } catch (e) {
      snackBar(e.toString());
    }
  }

  snackBar(String title) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(title)));
  }
}
