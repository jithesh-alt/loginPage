import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginpage/password_text_field.dart';
import 'package:loginpage/text_form_builder.dart';
import 'package:loginpage/validation.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  bool loading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  String email, password;
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(),
      inAsyncCall: loading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff261a36),
            image: DecorationImage(
              image: AssetImage('images/travel.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.only(right: 15, left: 15, bottom: 20, top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(
                    child: ShaderMask(
                      child: Text(
                        'It\'s nice to meet you \nAgain',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 31,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.yellow,
                          Colors.yellow,
                        ],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Text(
                      '\"Time flies. It\'s up to you to be the navigator.\"',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormBuilder(
                          enabled: !loading,
                          prefix: FontAwesomeIcons.envelope,
                          hintText: "Email",
                          validateFunction: Validations.validateEmail,
                          onSaved: (String val) {},
                          focusNode: emailFN,
                          nextFocusNode: passFN,
                        ),
                        SizedBox(height: 25),
                        PasswordFormBuilder(
                          enabled: !loading,
                          prefix: FontAwesomeIcons.lock,
                          suffix: FontAwesomeIcons.eye,
                          hintText: "Password",
                          textInputAction: TextInputAction.done,
                          validateFunction: Validations.validatePassword,
                          submitAction: () {},
                          obscureText: true,
                          onSaved: (String val) {},
                          focusNode: passFN,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap: () => {},
                              child: Container(
                                width: 150,
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Forgot Password  ? ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MaterialButton(
                            elevation: 3,
                            padding: EdgeInsets.all(0),
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.red[900],
                                    Colors.red[500],
                                    Colors.yellow,
                                  ],
                                ),
                              ),
                              child: Text(
                                'LOG IN',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    textStyle:
                                        Theme.of(context).textTheme.button),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?  ',
                    style: TextStyle(
                      color: Colors.indigoAccent[400],
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigoAccent[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
