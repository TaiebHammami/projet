import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:untitled25/firebase/firebase.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var key = GlobalKey<FormState>();
  String matricule = "";

  String name = "";
  String lastName = "";
  String age = "";
  String level = "";
  double radius = 12;
  String email = "";

  TextEditingController matriculeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController nameConctroller = TextEditingController();
  TextEditingController lastNameConctroller = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController levelController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      initialDatePickerMode: DatePickerMode.year,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1921),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        DateTime currentDate = DateTime.now();
        num age = currentDate.year - picked.year;
        ageController.text = age.toString();
      });
    }
  }

  void save() {
    var valid = key.currentState!.validate();
    if (!valid) {
      return;
    }
    key.currentState!.save();
    print(age);
    FirebaseBackend()
        .saveStudent(context, matricule, name, lastName, email, age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseBackend().signOut(context);
              },
              icon: Icon(Icons.logout))
        ],
        leading: Text(""),
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(26),
        child: SingleChildScrollView(
          child: Form(
              key: key,
              child: Column(
                children: [
                  SizedBox(
                    height: 26,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 5) {
                        return "ID is too short";
                      }
                    },
                    onSaved: (value) {
                      matricule = value.toString();
                    },
                    keyboardType: TextInputType.number,
                    controller: matriculeController,
                    decoration: InputDecoration(
                        labelText: 'Student ID',
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
                      if (value!.length < 3) {
                        return "Enter a valid name";
                      }
                    },
                    onSaved: (value) {
                      name = value.toString();
                    },
                    controller: nameConctroller,
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
                      if (value!.length < 3) {
                        return "Enter a valid last name";
                      }
                    },
                    onSaved: (value) {
                      lastName = value.toString();
                    },
                    controller: lastNameConctroller,
                    decoration: InputDecoration(
                        hintText: 'Last Name',
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
                      if (!EmailValidator.validate(value!)) {
                        return "Enter a valid email";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please select your birth date";
                      }
                    },
                    onSaved: (value) {
                      age = value.toString();
                    },
                    controller: ageController,
                    decoration: InputDecoration(
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
                        "Save Student",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
