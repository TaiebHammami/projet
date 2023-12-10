import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../firebase/firebase.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  double radius = 12;
  String email = "";
  String password = "";
  String name = "";
  String date = "";
  var key = GlobalKey<FormState>();

  void save() {
    var valid = key.currentState!.validate();
    if (!valid) {
      return;
    }
    key.currentState!.save();
    FirebaseBackend()
        .signUpWithEmailAndPassword(email, password, name, date, context);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1921),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  bool _obsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: key,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Enter a valid name";
                    }
                  },
                  onSaved: (value) {
                    name = value.toString();
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(radius)),
                          borderSide: BorderSide(color: Colors.blueAccent)),
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
                          borderSide: BorderSide(color: Colors.blueAccent))),
                ),
                SizedBox(
                  height: 26,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please select your birth date";
                    }
                  },
                  onSaved: (value) {
                    date = value.toString();
                  },
                  controller: _dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                        borderSide: BorderSide(color: Colors.blue)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    labelText: 'Selected Date',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                SizedBox(
                  height: 26,
                ),
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
                          borderSide: BorderSide(color: Colors.blueAccent)),
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
                          borderSide: BorderSide(color: Colors.blueAccent))),
                ),
                SizedBox(
                  height: 26,
                ),
                TextFormField(
                  obscureText: _obsecure,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.length < 8) {
                      return "Enter at least 8 caracters";
                    }
                  },
                  onSaved: (value) {
                    password = value.toString();
                  },
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
                          borderSide: BorderSide(color: Colors.blueAccent)),
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
                          borderSide: BorderSide(color: Colors.blueAccent))),
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
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ))
              ],
            )),
      ),
    );
  }
}
