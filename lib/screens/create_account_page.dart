import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountPageState();
  }
}

class CreateAccountPageState extends State<CreateAccountPage> {
  String email, password;
  bool loadState = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isSuccess;
  String displayName;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account Page'),
      ),
      body: loadState
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(16),
              child: Form(
                  key: formKey,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value.contains('@')
                              ? null
                              : 'Gecerli email adresi yazın',
                          decoration: InputDecoration(
                            hintText: "Lütfen Email Adresi Girin",
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (value) => value.length >= 6
                              ? null
                              : 'Sifreniz en az 6 karakter olmalıdır',
                          decoration: InputDecoration(
                            hintText: "Lütfen Sifre Girin",
                            labelText: "Sifre",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: RaisedButton(
                                color: Colors.deepPurpleAccent,
                                textColor: Colors.white,
                                child: Text('Kayıt Ol'),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    addRecord();
                                  }
                                })),
                      ],
                    ),
                  )),
            ),
    );
  }

  addRecord() async {
    final User user = (await auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      isSuccess = false;
    }
  }
}
