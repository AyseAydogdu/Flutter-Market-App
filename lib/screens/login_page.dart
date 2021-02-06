import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketapp/screens/create_account_page.dart';
import 'package:marketapp/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String email, password;
  bool loadState = false;
  final TextEditingController _emailController = TextEditingController();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
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
                          child: Text('Giriş Yap'),
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              signInWithEmailAndPassword();
                            }
                          },
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: InkWell(
                            child: Text(
                              'Hesabınız yok mu?',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.indigo),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateAccountPage(),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }

  void signInWithEmailAndPassword() async {
    try {
      final User user = (await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return HomePage(
            //  user: user,
            );
      }));
    } catch (e) {
      Text("Failed to sign in with Email & Password");
    }
  }
}
