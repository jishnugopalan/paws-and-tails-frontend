
import 'dart:convert';

import 'package:dio/dio.dart';
//import 'package:echosentry/services/registration_services.dart';
import 'package:flutter/material.dart';
import 'package:paws_and_tails/services/registration_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String email="",password="";
  RegistrationService service=RegistrationService();
  final storage = FlutterSecureStorage();

  showError(String content,String title){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if(title=="Registration Successful"){
                    Navigator.pushNamed(context, '/login');
                  }
                  else
                    Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  Future<void> checkAuthentication() async {
    try{
      Map<String, String> allValues = await storage.readAll();
      if(allValues["token"]!.isEmpty){
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/intro', (Route<dynamic> route) => false);
      }
      else{
        print("token is here");
        Map<String, String> allValues = await storage.readAll();
        String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
        String userid= json.decode(utf8.decode(base64Url.decode(normalizedSource)))["_id"];
        this.getUser(userid);
      }

    }catch(e){

    }
  }
  Future<void> getUser(String userid) async {
    try{

      final Response? response=await service.getUser(userid);
      print(response);
      if(response?.data["usertype"]=="customer"){
        print("c");
        //Navigator.pushNamedAndRemoveUntil(context, '/customer', (route) => false);
        Navigator.pushNamedAndRemoveUntil(context, '/customer', (route) => false);

      }
      else if(response?.data["usertype"]=="shop"){
        print("S");
        //Navigator.pushNamedAndRemoveUntil(context, '/shop', (route) => false);
        Navigator.pushNamedAndRemoveUntil(context, '/shopdashboard', (route) => false);


      }
      else if(response?.data["usertype"]=="admin"){
        Navigator.pushNamedAndRemoveUntil(context, '/admindashboard', (route) => false);

      }
      else if(response?.data["usertype"]=="adviser"){
        Navigator.pushNamedAndRemoveUntil(context, '/adviserdashboard', (route) => false);

      }

    }on DioError catch(e){
      if (e.response != null) {
        print(e.response!.data);

        showError("Login failed", "Please login again");


      } else {
        // Something happened in setting up or sending the request that triggered an Error
        showError("Error occured,please try againlater","Oops");
      }

    }


  }

  login() async {
    if(_formkey.currentState!.validate()){
      print(email+""+password);
      var user=jsonEncode({
        "email":email,
        "password":password,
      });
      try{
        final Response? response=await service.loginUser(user);
        print(response!.data);
        Map<String, String> allValues = await storage.readAll();
        String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
        String userid= json.decode(utf8.decode(base64Url.decode(normalizedSource)))["_id"];
        print(userid);
        await storage.write(key: "userid", value: userid);
        // Map<String, dynamic> s=jsonDecode(response.data);
        if(response.data["user"]["usertype"]=="customer"){
          print("c");
          //Navigator.pushNamedAndRemoveUntil(context, '/customer', (route) => false);
          Navigator.pushNamed(context,'/customer');

        }
        else if(response.data["user"]["usertype"]=="shop"){
          print("S");
          //Navigator.pushNamedAndRemoveUntil(context, '/shop', (route) => false);
          Navigator.pushNamed(context, '/shopdashboard');


        }
        else if(response.data["user"]["usertype"]=="admin"){
          Navigator.pushNamedAndRemoveUntil(context, '/admindashboard', (route) => false);

        }
        else if(response.data["user"]["usertype"]=="adviser"){
          Navigator.pushNamedAndRemoveUntil(context, '/adviserdashboard', (route) => false);

        }


      }on DioError catch(e){
        if (e.response != null) {
          print(e.response!.data);

          showError(e.response!.data["error"], "Login Failed");


        } else {
          // Something happened in setting up or sending the request that triggered an Error
          showError("Error occured,please try againlater","Oops");
        }

      }

    }
  }
  @override
  void initState(){
    super.initState();
    this.checkAuthentication();


  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/mlogin.png'),
            const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
                key: _formkey, child: Column(children: [
              TextFormField(

                obscureText: false,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Colors.black.withOpacity(.3),
                  ),
                  hintText: 'Enter Email',
                ),
                cursorColor: Colors.black.withOpacity(.5),
                validator: (value){
                  if(value!.isEmpty){
                    return "Email is required";
                  }
                  setState(() {
                    email=value;
                  });
                  return null;
                },
              ),
              TextFormField(

                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black.withOpacity(.3),
                  ),
                  hintText: 'Enter Password',
                ),
                cursorColor: Colors.black.withOpacity(.5),
                validator: (value){
                  if(value!.isEmpty){
                    return "Password is required";
                  }
                  setState(() {
                    password=value;
                  });
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap:login,
                child:Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 53, 87, 33),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )),
                ) ,
              ),
            ],)),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: 'Forgot Password?',
                    style: TextStyle(color: Color.fromARGB(255, 62, 59, 59)),
                  ),
                  TextSpan(
                    text: '  Reset Here',
                    style: TextStyle(color: Color.fromARGB(255, 53, 87, 33)),
                  )
                ],
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 62, 59, 59)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                child: Text('Don\'t have any account?Register Now'),
              ),),



          ],
        ),
      ),
    );
  }
}