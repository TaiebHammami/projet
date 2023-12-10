import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:untitled25/firebase/firebase.dart';
import 'package:untitled25/screens/register.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  double radius = 12;
  String email = "";
  String password = "";
  var key = GlobalKey<FormState>();

  void save() {
    var valid = key.currentState!.validate();
    if (!valid) {
      return;
    }
    key.currentState!.save();
    print(email);
    FirebaseBackend().signInWithEmailAndPassword(email, password, context);
  }

  bool _obsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Text(""),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Sign In",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 40),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "Enter your credentials to continue",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 22),
              ),
              SizedBox(
                height: 26,
              ),
              Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return "Enter a valid email";
                          }
                        },
                        onSaved: (value) {
                          email = value.toString();
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(radius)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(radius)),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(radius)),
                                borderSide: BorderSide(color: Colors.blue)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(radius)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.length < 8) {
                            return "Enter at least 8 caracters";
                          }
                        },
                        onSaved: (value) {
                          password = value.toString();
                        },
                        obscureText: _obsecure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecure = !_obsecure;
                                });
                              },
                              icon: Icon(_obsecure
                                  ? Icons.visibility_off
                                  : Icons.remove_red_eye),
                            ),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(radius)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(radius)),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(radius)),
                                borderSide: BorderSide(color: Colors.blue)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(radius)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radius),
                              ),
                              minimumSize: Size(double.infinity, 60),
                              side: BorderSide()),
                          onPressed: () {
                            save();
                          },
                          child: Text(
                            "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white),
                          )),
                      SizedBox(
                        height: 26,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radius),
                              ),
                              minimumSize: Size(double.infinity, 60),
                              side: BorderSide()),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
