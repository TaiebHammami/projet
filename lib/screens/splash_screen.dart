import 'package:flutter/material.dart';
import 'package:untitled25/screens/login.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 8)).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage("assets/students.png"),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Text("Welcome",style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 45
            )),
            SizedBox(
              height: 26,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}