import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_reading/api.dart';
import 'package:smart_reading/translations.dart';

class Register extends API {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends APIState {
  final TextEditingController _pass = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  String url;
  @override
  String urlSuffix = "register";
  @override
  String appBarTitle = "registerappbar";

  var messages = {
    "success": {
      "dialogHead": "Registration completed",
      "dialogMessage": "You can now log in"
    },
    "failure": {"dialogHead": "Registration error"},
  };

  @override
  onSuccess() async {
    // When registration success, display message
    // then navigate to login page

    setState(() {
      dialogHead = messages["success"]["dialogHead"];
      dialogMessage = messages["success"]["dialogMessage"];
      success = true;
    });
    showAlertDialog();
    //Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void onDialogPressed() {
    if (success) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Map<String, String> getBody() {
    return {"username": username, "password": password, "email": email};
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
              height: 80.0,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: Translations.of(context).text('email')),
                validator: (value) {
                  return value.isNotEmpty
                      ? null
                      : Translations.of(context).text('emptyemail');
                },
                onSaved: (val) => email = val,
              ),
            ),
            new SizedBox(
              height: 80.0,
              child: TextFormField(
                controller: _pass,
                decoration: InputDecoration(
                  labelText: Translations.of(context).text("password"),
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
                      : Translations.of(context).text("emptypassword");
                },
                obscureText: _obscurePassword,
              ),
            ),
            new SizedBox(
              height: 80.0,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: Translations.of(context).text("confirmpassword"),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _obscureConfirm ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty)
                    return Translations.of(context).text("emptypassword");
                  if (value != _pass.text)
                    return Translations.of(context).text("passwordnotmatch");
                  return null;
                },
                onSaved: (val) => password = val,
                obscureText: _obscureConfirm,
              ),
            ),
            new RaisedButton(
              onPressed: submit,
              child: Text(Translations.of(context).text("registerbutton")),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(Translations.of(context).text("alreadyregistered")),
                  SizedBox(
                    width: 10.0,
                  ),
                  new InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    child: new Text(
                      Translations.of(context).text("loginnow"),
                      style: new TextStyle(color: Colors.blueAccent),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
