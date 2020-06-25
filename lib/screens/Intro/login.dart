import 'package:flutter/material.dart';
import 'package:oole_app/api/LoginService.dart';
import 'package:oole_app/models/Credential.dart';
import 'package:oole_app/screens/tabs.dart';
import 'package:oole_app/utils/app-routes.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Credential credencial = Credential(email: "marciacosta@gmail.com");
  final LoginService loginService = LoginService();
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF008140),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 4,
                      child: Image.asset(
                        "images/oole-logo.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width / 100) * 85,
                          height:
                              (MediaQuery.of(context).size.height / 100) * 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.green[400],
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              bottom:
                                  (MediaQuery.of(context).size.height / 100) *
                                      2),
                          child: TextFormField(
                            cursorColor: Color(0xFF008140),
                            onChanged: (value) {
                              setState(() {
                                credencial.email = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Login",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width / 100) * 85,
                          height:
                              (MediaQuery.of(context).size.height / 100) * 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.green[400],
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            cursorColor: Color(0xFF008140),
                            onChanged: (value) {
                              setState(() {
                                credencial.senha = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.lock),
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Senha",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width / 100) * 70,
                          height:
                              (MediaQuery.of(context).size.height / 100) * 8,
                          margin: EdgeInsets.only(
                              bottom:
                                  (MediaQuery.of(context).size.height / 100) *
                                      4),
                          child: RaisedButton(
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                  fontSize: 20.0, color: Color(0xFF01E271)),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isloading = true;
                              });
                              int code = await loginService.logIn(credencial);
                              setState(() {
                                _isloading = false;
                              });
                              if (code == 200) {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.TABS);
                              } else if (code >= 400 && code < 500) {
                                await showDialog<Null>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Ocorreu um erro durante!"),
                                    content: Text(
                                        "Por favor, verifique se o email ou a senha estão escritos corretamente"),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Text(
                          'Ainda não tem um Oolé?\n'
                          'Inscreva-se, é de graça.',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width / 100) * 70,
                          height:
                              (MediaQuery.of(context).size.height / 100) * 8,
                          margin: EdgeInsets.only(
                              bottom:
                                  (MediaQuery.of(context).size.height / 100) *
                                      7,
                              top: (MediaQuery.of(context).size.height / 100) *
                                  2),
                          child: RaisedButton(
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                  fontSize: 20.0, color: Color(0xFF01E271)),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.REGISTER);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
