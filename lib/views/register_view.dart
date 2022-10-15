import 'dart:developer';

import 'package:car_loan_project/constants/routes.dart';
import 'package:car_loan_project/services/auth/auth_exceptions.dart';
import 'package:car_loan_project/services/auth/auth_service.dart';
import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as devtools show log;

import '../firebase_options.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
    late final TextEditingController _confirmpassword;
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _phonenumber;
  late final TextEditingController _companyname;
  late final TextEditingController _location;

   final databaseRef = FirebaseDatabase.instance.reference();
   Future addData(String data) async {
    return await databaseRef.push().set({'name': data, 'comment': 'A good season'});
  }

  

  

  @override
  void initState() {
    _email = TextEditingController();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _phonenumber = TextEditingController();
    _companyname = TextEditingController();
    _location = TextEditingController();
    _password = TextEditingController();
    _confirmpassword = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
     _companyname.dispose();
    _confirmpassword.dispose();
    _firstname.dispose(); 
    _lastname.dispose();
    _location.dispose();
    _phonenumber.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
   
    return Container(
       constraints: const BoxConstraints.expand(),
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage
  ('https://media.istockphoto.com/photos/visiting-car-dealership-afro-couple-showing-car-key-picture-id1167502071?b=1&k=20&m=1167502071&s=170667a&w=0&h=7khaGIzW3VxEayIR5EQELMtzHjxogHXkizJTE8e7fNk='), 
            fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        backgroundColor: Colors.black.withOpacity(0.5),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){return ListTile(
            title: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 70,),
                      Icon(
                      Icons.car_rental_rounded,
                      color: Colors.greenAccent,
                      size: 40,
                    ),SizedBox(height: 10.0),
                    Text(
                      'Car_Free',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 30,
                        color: Colors.greenAccent,
                      ),
                    ),SizedBox(height: 1.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                borderSide: BorderSide(color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _firstname,
                            obscureText: false,
                            autocorrect: true,
                            enableSuggestions: false,
                            decoration:  InputDecoration(
                              hintText: 'First Name',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _lastname,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                              hintText: 'Last Name',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _companyname,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                              hintText: 'Company Name or Username   ',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _password,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            obscureText: true,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                              hintText: 'Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                           
                          
                          
                          ),
                        ), Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _phonenumber,
                            keyboardType: TextInputType.phone,
                            autocorrect: false,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                              hintText: 'Phone number',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              
                            ),
                          ),
                        ),
                      TextButton(
                        child: const Text('Register'),
                        onPressed: (() async {
                         final email = _email.text;
                         final password = _password.text;
                          CollectionReference users = FirebaseFirestore.instance.collection('users');
                          Future addUserDetail(String first_name, int phone_number,String email, String companyname, String lastname) 
                          async {
                            return users
                              // existing document in 'users' collection: "ABC123"
                              .doc('$email')
                              .set({
                               'first_name': first_name,
                                  'company name': companyname,
                                  'last name': lastname,
                                  'phone_number': phone_number.toString(),
                                  'email': email,
                                  'My Money': 0,
                                  'image': 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                                
                                },
                                SetOptions(merge: true),
                              )
                              .then(
                                (value) => log("SuccessFul Registration")
                              )
                              .catchError((error) => log("Failed to register: $error"));
                          
                          };
                         
                       try {
                         await addData(email);
                          addUserDetail(_firstname.text.trim(),
                           int.parse(_phonenumber.text.trim()), _email.text.trim(),_companyname.text.trim(),_lastname.text.trim(),);
                        await AuthService.firebase().createUser(
                          email: email, 
                          passsword: password);
                    
                          final users = AuthService.firebase().currentUser;
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          if (users != null){
                         //   UserCredential result = await _auth.currentUser;
                          await _auth.currentUser!.updateDisplayName('${_firstname.text.trim()}');
                          
                          } else{log('Error Updating username');
                            throw Error();}
                          AuthService.firebase().sendEmailVerification();
                          Navigator.of(context).pushNamed(loginRoutes);
                           ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('An email verification has been sent to your email to confirm your account')));
                       } on WeakPasswordAuthException{
                         await showErrorDialog(context, 'Weak Password'); 
                       } on EmailAlreadyinUseAuthException{
                        await showErrorDialog(context, 'Email already in use');
                       } on InvalidEmailAuthException{
                          await showErrorDialog(context, 'This is an invalid email address');
                       } catch (e){
                         await showErrorDialog(context, 
                        e.toString());
                       }
                      
                        }),
                        ),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(loginRoutes, (route) => false);
                       }, 
                       child: Text('Already Registered? Login'))
                    ],
                  ),
            ),
          );}
        ),
      ),
    );
     }}