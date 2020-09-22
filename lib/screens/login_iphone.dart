import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sqflite/mixin/validation_mixin.dart';

class LoginIphone extends StatefulWidget {
  @override
  _LoginIphoneState createState() => _LoginIphoneState();
}

class _LoginIphoneState extends State<LoginIphone>with ValidationMixin {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String email = '';
  String password = '';
  bool obscure_text=true;
  final formKey = GlobalKey<FormState>();

  double radius = 5.0;

  void signInPressed() {
    print("Signed in is pressed");
    if (formKey.currentState.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Login Screen'),
      ),
      child: Material(
        child: Container(
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(50.0),
                ),
                TextFormField(
                  onSaved: (value) {
                    email = value;
                    print(email);
                  },
                  //This is Email Field
                  validator:ValidateEmail,

                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () => _email.clear(),
                        child: Icon(CupertinoIcons.clear_circled)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius)),
                    hintText: "you@example.com",
                    labelText: "Enter Email or Username",
                  ),
                  showCursor: true,
                  textInputAction: TextInputAction.next,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  //This is Password Field

                  onSaved: (String value) {
                    password = value;
                    print(password);
                  },
                  validator:ValidatePassword,
                  decoration: InputDecoration(
                    suffixIcon: Container(
                      width: 100,
//                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("Eye password");
                                setState(() => obscure_text = !obscure_text);
                              },
                              child: Icon(obscure_text?Icons.visibility:Icons.visibility_off),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _password.clear();
                                print("clear password");
                              },
                              child: Icon(CupertinoIcons.clear_circled),
                            ),
                          ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius)),
                    hintText: "***",
                    labelText: "Enter Password",
                  ),
                  showCursor: true,
                  textInputAction: TextInputAction.done,
                  controller: _password,
                  obscureText: obscure_text,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(
                  height: 100.0,
                ),
                CupertinoButton.filled(
                    child: Text("Sign in"),
                    onPressed: () {
                      print("Signed in is pressed");
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
