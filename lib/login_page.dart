import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_tracker/auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
            minWidth: 100,
            maxHeight: 800,
            // minHeight: 500,
          ),
          child: Column(
            children: [
              Spacer(),
              Image(
                image: AssetImage("assets/graphics/dna.png"),
              ),
              RichText(
                text: TextSpan(
                    text: "Galaxy",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.redAccent[200],
                        fontSize: 48),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Tracker",
                          style: TextStyle(color: Color(0xff45748C))),
                    ]),
              ),
              Spacer(flex: 2),
              LoginForm(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Usuário"),
              validator: (val) => val.isEmpty ? "Campo obrigatório" : null,
              onSaved: (val) => username = val,
            ),
            SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  // obscureText: true,
                  border: OutlineInputBorder(),
                  labelText: "Senha"),
              validator: (val) => val.isEmpty ? "Campo obrigatório" : null,
              onSaved: (val) => password = val,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  var response = await authenticate(username, password);
                  if (response.statusCode != 200) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Usuário ou senha incorretos!'),
                      duration: Duration(seconds: 1),
                    ));
                  } else {
                    String apiKey = jsonDecode(response.body)['api_key'];

                    GetStorage().write('token', apiKey);
                    Navigator.pushNamed(context, '/histories');
                  }

                  print(response.statusCode);
                  print(response.body);
                }
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                  elevation: 8,
                  primary: Colors.redAccent[400],
                  minimumSize: Size(300, 50)),
            )
          ],
        ),
      ),
    );
  }
}
