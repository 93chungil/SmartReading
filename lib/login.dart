import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_reading/api.dart';
import 'package:smart_reading/models/user.dart';
import 'package:smart_reading/translations.dart';

class Login extends API {
  String appBar;
  @override
  LoginState createState() => LoginState();
}

class LoginState extends APIState {
  bool _obscurePassword = true;

  String url;
  String urlSuffix = "login";
  String appBarTitle = "loginappbar";

  var messages = {
    "success": {"dialogHead": "", "dialogMessage": ""},
    "failure": {"dialogHead": "Login error"}
  };

  @override
  void onDialogPressed() {
    if (success == false) Navigator.pop(context);
  }

  @override
  onSuccess() async {
    // When login success, save the data ,
    // navigate to ProfilePage
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLogged", true);

    sharedPreferences.setString(
        "username", responseData["data"]["user"]["username"]);
    sharedPreferences.setString(
        "fullname", responseData["data"]["user"]["fullname"]);
    sharedPreferences.setString("email", responseData["data"]["user"]["email"]);

    currentUser = User(0, responseData["data"]["user"]["username"],"assets/images/profileimage.png");

    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Map<String, String> getBody() {
    return {"username": username, "password": password};
  }

  @override
  Widget getForm() {
    return new Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: new Column(
            children: <Widget>[
              new SizedBox(
                height: 80.0,
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: Translations.of(context).text('username')),
                  validator: (value) {
                    return value.isNotEmpty
                        ? null
                        : Translations.of(context).text('emptyusername');
                  },
                  onSaved: (val) => username = val,
                ),
              ),
              new SizedBox(
                height: 90.0,
                child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: Translations.of(context).text('password'),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    validator: (value) {
                      return value.isNotEmpty
                          ? null
                          : Translations.of(context).text('emptypassword');
                    },
                    onSaved: (val) => password = val),
              ),
              new RaisedButton(
                onPressed: super.submit,
                child: Text(Translations.of(context).text('loginbutton')),
              ),
              new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(Translations.of(context).text('notauser')),
                      SizedBox(
                        width: 10.0,
                      ),
                      new InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/register");
                        },
                        child: new Text(
                          Translations.of(context).text('registernow'),
                          style: new TextStyle(color: Colors.blueAccent),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
