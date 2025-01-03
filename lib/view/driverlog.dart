import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hereuraxi/service/auth.dart';
import 'package:provider/provider.dart';

import 'Driverlist.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          icon: Icon(Icons.exit_to_app),

        ),

      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(child:
        Form(
          key: _formKey,
          child:Flexible(
    child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("https://img.freepik.com/premium-vector/car-steering-logo-driver-vector-transport-vehicle-design-repair-maintenance-car-garage_638875-3824.jpg",height: 200,width: 200, ),
              SizedBox(height: 30,),
              Text('Log as user ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              SizedBox(height: 10,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email',border:
                OutlineInputBorder( borderRadius: BorderRadius.circular(
                  10,
                ))),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(
                  10,)),),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ButtonTheme(height:200,buttonColor: Colors.blue,

                child:
                ElevatedButton(

                  onPressed: ()   async {if (_formKey.currentState?.validate() ?? false) {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final auth = Provider.of<FireAuth>(context, listen: false);
                    try {
                      await auth.logIn(email, password);
                      bool verify = auth.auth.currentUser!.emailVerified;
                      if (verify==true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>DriverList()),);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("verify your email")),);
                        auth.auth.currentUser?.sendEmailVerification();
                        auth.logout();

                      }
                    }  catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("email or password wrong failed: ${e.toString()}")),
                      );
                    }
                  }

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 0, 255, 100),

                      fixedSize: Size(400, 40), // specify width, height
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ))),
                  child: Text('Log in',style: TextStyle(color: Colors.white),),
                ),),
              TextButton(
                onPressed: () {

                },

                child: Text('Forgot password?',style:TextStyle(color:Colors.black)),


              ),
              SizedBox(height: 70,),
              ElevatedButton(

                onPressed:() {

                },

                style: ElevatedButton.styleFrom(


                    fixedSize: Size(400, 40), // specify width, height
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ))),

                child: Text('Create new account',style: TextStyle(color: Colors.blue),),
              ),
            ],
          ),
        ),
        ),),
    ),);
  }

}