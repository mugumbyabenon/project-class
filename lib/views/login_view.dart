import 'package:car_loan_project/constants/routes.dart';
import 'package:car_loan_project/main.dart';
import 'package:car_loan_project/services/auth/auth_service.dart';
import 'package:car_loan_project/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui' as ui;
import 'dart:developer' as devtools show log;

import '../utilities/showErrorDialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
 late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
   
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
bool isLoading =false;
 @override
  Widget build(BuildContext context) {
   
    return Container(
       constraints: const BoxConstraints.expand(),
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage('https://media.istockphoto.com/photos/visiting-car-dealership-afro-couple-showing-car-key-picture-id1167502071?b=1&k=20&m=1167502071&s=170667a&w=0&h=7khaGIzW3VxEayIR5EQELMtzHjxogHXkizJTE8e7fNk='), 
            fit: BoxFit.cover)),
     
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SingleChildScrollView(
          child: Stack(
            children:[ Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(height: MediaQuery.of(context).size.height*0.1,),Icon(
                    Icons.car_rental_outlined,
                    size: 100,
                    color: Colors.greenAccent,
                  ),SizedBox(height: 5.0),
                  Text(
                    'Car_Free',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 52,
                      color: Colors.greenAccent,
                    ),
                  ),SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:25.0),
                        child: TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          enableSuggestions: true,
                          decoration:  InputDecoration(
                            hintText: 'Enter your email here',
                            fillColor: Colors.grey[200],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ), 
                      SizedBox(height: 10.0,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 25.0),
                         child: TextField(
                          controller: _password,
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration:  InputDecoration(
                            hintText: 'Enter your password',
                             fillColor: Colors.grey[200],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            
                          ),
                      ),
                       ),
                    TextButton(
                      child: const Text('Login'),
                      onPressed: (() async {
                       final email = _email.text;
                       final password = _password.text;
                     try{
                      setState(() {
                        isLoading = true;
                      });
                      await AuthService.firebase().login(
                        email: email, 
                      passsword: password);
                      setState(() {
                        isLoading=false;
                      });
                        final user = await AuthService.firebase().currentUser;
                        if (user?.isEmailVerified??false){
                                Navigator.of(context).pushNamedAndRemoveUntil(notesRoutes, (route) => false);
                        } else {
                                final shouldLogout = await dialoglogin(context);
                                 if (shouldLogout == true){
                   await AuthService.firebase().sendEmailVerification();
                   Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoutes, (route) => false);
                  }
                        }
                        
                     } on FirebaseAuthException catch (e){
                       setState(() {
                        isLoading=false;
                      });
                      if (e.code == 'user-not-found'){
                         setState(() {
                        isLoading=false;
                      });
                        await showErrorDialog(context, 'User not found',);
                      } else if (e.code =='wrong-password'){
                         setState(() {
                        isLoading=false;
                      });
                        await showErrorDialog(context, 'You have entered a wrong password');
                      } else 
                       setState(() {
                        isLoading=false;
                      });
                       showErrorDialog(context, 
                      'Error: ${e.code}');
                
                     } catch (e){
                       setState(() {
                        isLoading=false;
                      });
                       await showErrorDialog(context, 
                      e.toString());
                     }
                      }),
                      ),
                      TextButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => RegisterView()), (r) => false);
                      }, 
                      child: const Text("Not yet registered? Register Here")),
                  ],
                ), Visibility(
                  visible: isLoading,
                  child: Positioned.fill(
                    right: 5,
                    left: 5,
                    top: 5,
                    child: BackdropFilter(
                       filter: ui.ImageFilter.blur(
                  sigmaX: 1.0,
                  sigmaY: 1.0,
                              ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text('Login in, Please wait',style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                )
         ] ),
        ),
      ),
    ); 
  }
}

Future<bool> dialoglogin(BuildContext context){
 return showDialog<bool>(
    context: context, 
    builder: (context){
       return AlertDialog(title: const Text('Verify Email'),
       content: const Text('Resend email verification'),
       actions: [TextButton(
        onPressed: (){
          Navigator.of(context).pop(true);
        },
        child:const Text('Ok'),),
        TextButton(onPressed: (){
           Navigator.of(context).pop(false);
        }, 
        child: const Text('Cancel'))
        ],
       );   
    },
    ).then((value) => value ?? false);
}
 
