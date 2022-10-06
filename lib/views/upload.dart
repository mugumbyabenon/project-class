import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:car_loan_project/constants/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_service.dart';
import '../utilities/showErrorDialog.dart';
import 'login_view.dart';
import 'notes_view.dart';


class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
   late final TextEditingController _email;
  late final TextEditingController _password;
    late final TextEditingController _confirmpassword;
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _phonenumber;
  late final TextEditingController _companyname;
  late final TextEditingController _location;

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
    super.initState();}

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

  String? category;
  String? button;
  XFile?  images ;
  File? _image;
   XFile?  images1 ;
  File? _image1;
   XFile?  images2 ;
  File? _image2;
   XFile?  images3 ;
  File? _image3;
  String imageUrl = 'https://t4.ftcdn.net/jpg/01/67/65/73/360_F_167657302_FNkJP5s2AUCzQwiKwmO9PV2JkcC6l8Zr.jpg';
    
    void dropdownCallback(String? selectedValue){
      if (selectedValue is String){

        setState(() {
          category = selectedValue;
        });
      }
      if ( selectedValue == 'Cars'){
        setState(() {
          button = 'Request Loan';
        });
      }
       if ( selectedValue == 'Motorcycles'){
        setState(() {
          button = 'Request Loan';
        });
      }   if ( selectedValue == 'Rentals'){
        setState(() {
          button = 'Rent';
        });
      }
       if ( selectedValue == 'Spareparts'){
        setState(() {
          button = 'Buy';
        });
      }
    }

   Future upload( XFile? pic) async{
    final upload = await FirebaseStorage.instance.ref().child('Iimages').
     child(DateTime.now().toString()+'.jpg');
     try{
    final path = pic!.path;
     File file = File(path);
     await upload.putFile(file);
     final string = "${await upload.getDownloadURL()??''}";
     return string;} catch (e){
      return null;
     }
     }
     
  

  Future<File?> saveFile(String imagePath) async{
    final results = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${results.path}/$name');
    return File(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    //final Storage storage = Storage();
    return  Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height*1.1,
             decoration: BoxDecoration(
                        color: Color.fromARGB(255, 229, 226, 226),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x32000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                       child: ListView(
                        scrollDirection: Axis.horizontal,
                         children: [GestureDetector(
                          onTap: () async{
                          final image = await ImagePicker().pickImage(source: ImageSource.gallery) ;
                                  if(image == null) {
                                    //ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('No file has been selected')));
                                            log('failed to upload');
                                            return null;
                                  };
                                  final imageTemporary = File(image.path);
                                  setState(() {
                                    images = image;
                                  });
                                  setState(() {
                                    this._image = imageTemporary;
                                  });
                          },
                                  child:    Stack(
                                    children:[ _image != null ? Image.file(_image!,width: MediaQuery.of(context).size.width,height: 300
                                                              ,fit: BoxFit.cover,) : Image.network(
                                                  '$imageUrl',
                                                  width:  MediaQuery.of(context).size.width,height: 300,
                                                  fit: BoxFit.cover,
                                                ),Column(
                                                 // crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text('Upload Product Images'),
                                                    ),
                                                  ],
                                                )]
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async{
                          final image = await ImagePicker().pickImage(source: ImageSource.gallery) ;
                                  if(image == null) {
                                    //ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('No file has been selected')));
                                            log('failed to upload');
                                            return null;
                                  };
                                  final imageTemporary = File(image.path);
                                  setState(() {
                                    images1 = image;
                                  });
                                  setState(() {
                                    this._image1 = imageTemporary;
                                  });
                          },
                                  child:    _image1 != null ? Image.file(_image1!,width: 250,height: 20
                            ,fit: BoxFit.cover,) : Image.network(
                                                '$imageUrl',
                                                width:  MediaQuery.of(context).size.width,height: 300,
                                                 fit: BoxFit.cover
                                              ),
                                ),GestureDetector(
                                  onTap: () async{
                          final image = await ImagePicker().pickImage(source: ImageSource.gallery) ;
                                  if(image == null) {
                                    //ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('No file has been selected')));
                                            log('failed to upload');
                                            return null;
                                  };
                                  final imageTemporary = File(image.path);
                                  setState(() {
                                    images2 = image;
                                  });
                                  setState(() {
                                    this._image2 = imageTemporary;
                                  });
                          },
                                  child:    _image2 != null ? Image.file(_image2!,width: 250,height: 20
                            ,fit: BoxFit.cover,) : Image.network(
                                                '$imageUrl',
                                                width:  MediaQuery.of(context).size.width,height: 300,
                                                 fit: BoxFit.cover
                                              ),
                                ),GestureDetector(
                                  onTap: () async{
                          final image = await ImagePicker().pickImage(source: ImageSource.gallery) ;
                                  if(image == null) {
                                    //ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('No file has been selected')));
                                            log('failed to upload');
                                            return null;
                                  };
                                  final imageTemporary = File(image.path);
                                  setState(() {
                                    images3 = image;
                                  });
                                  setState(() {
                                    this._image3 = imageTemporary;
                                  });
                          },
                                  child:    _image3 != null ? Image.file(_image3!,width: 250,height: 20
                            ,fit: BoxFit.cover,) : Image.network(
                                                '$imageUrl',
                                                width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
                                                fit: BoxFit.cover 
                                              ),
                                ),
                                ]
                       ),
                     ),
                    SizedBox(height: 1.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                              hintText: 'Product Name',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
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
                              hintText: 'Product Model ',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
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
                              hintText: 'Used or BrandNew',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
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
                              hintText: 'Location',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
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
                            obscureText: false,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                              hintText: 'Description',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                           
                          
                          
                          ),
                        ), Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _phonenumber,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                              hintText: 'Price',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              
                            ),
                          ),
                        ),Row(children: [
                        const  Padding(
                            padding:  EdgeInsets.all(.0),
                            child: Text('Category',style: TextStyle(
               // color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
               // fontWeight: FontWeight.bold,
              ),),
                          ),SizedBox(width: 20,),DropdownButton(items: const[
                            DropdownMenuItem(child: Text('Cars'),value: 'Cars',),
                             DropdownMenuItem(child: Text('Motorcyles'),value: 'Motorcycles',),
                              DropdownMenuItem(child: Text('Rentals'),value: 'Rentals',),
                               DropdownMenuItem(child: Text('Spare Parts'),value: 'Spareparts',)
                          ],value: category, onChanged: dropdownCallback)
                        ],),SizedBox(height: 20,),
                       CupertinoButton(
                         color: CupertinoColors.activeOrange,
                        child: const Text('Upload Advert'),
                        onPressed: (() async {
                         CollectionReference users = FirebaseFirestore.instance.collection('Adverts');
                          Future<void> addUser(String first_name, int phone_number,String email, 
                          String companyname, String lastname,String description,final imagesUrl,
                          final imagesUrl1,final imagesUrl2,final imagesUrl3) {
                  
                              User? user = FirebaseAuth.instance.currentUser;
                            // Check if the user is signed in
                            if (user != null) {

                             FutureBuilder(
        future: AuthService.firebase().intialize(),
        builder:   (context, snapshot) {
          switch (snapshot.connectionState) {
            
            case ConnectionState.done:
            final user =  AuthService.firebase().currentUser;
          
            if (user != null){
               if (user.isEmailVerified == false){
                return const LoginView();
               }
             else {
               return const NotesView();
            }} else {
               return const NotesView();
            }
            
        default: 
        return Container(
         //   constraints: const BoxConstraints.expand(),
         height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('imagess/home.jpg'), 
            fit: BoxFit.cover)),
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Image(image: AssetImage('imagess/home.jpg'),fit: BoxFit.cover,)
              ],
            ),
          ),
        );
          }
          
        },
      );


                              String uid = user.uid; // <-- User ID
                              String? emails = user.email;
                              final pk = DateTime.now().toString() + uid;
                              log(uid); 
                             users.doc(pk)
                              // existing document in 'users' collection: "ABC123"
                              .set({
                                'Car Model': first_name,
                              'Location': companyname,
                               'Used or Brand New': lastname,
                              'Price':phone_number,
                              'imageUrl':  imagesUrl,
                               'imageUrl1':  imagesUrl1,
                                'imageUrl2':  imagesUrl2,
                                 'imageUrl3':  imagesUrl3,
                              'Car Name': email,
                              'user': uid,
                              'email':emails,
                              'description':description,
                              'Category':category,
                              'pk':pk,
                              'all':'all',
                              'button':button,
                                },
                                
                              )
                              .then(
                                (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoutes, (route) => false)
                          
                                 // ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('Your advert has been posted successfully')))
                              )
                              .catchError((error) => showErrorDialog(context, '$error'));
                              log('$button');
                              return Navigator.of(context).pushNamed(homeRoutes);

                          } else {
                            return PromptLogin(context);
                          }
                          
                          } try{
                           final imagesUrls =  await  upload(images)??'https://www.jaipuriaschoolpatna.in/wp-content/uploads/2016/11/blank-img.jpg';
                           final imagesUrl1 =  await  upload(images1);
                            final imagesUrl2 =  await  upload(images2);
                             final imagesUrl3 =  await  upload(images3);
                            
                //         addUser();
                         try{ 
                      
                       addUser(_firstname.text.trim(),  
                              int.parse(_phonenumber.text.trim()), _email.text.trim(),_companyname.text.trim(),_lastname.text.trim(),_password.text.trim(),
                             imagesUrls,imagesUrl1,imagesUrl2,imagesUrl3 );
                             log('$category');
                             } catch (e){
                                          log('$e');
                     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('Error Occurred')));
                              }
            } catch (e) {
                              showErrorDialog(context, '$e');
                              log('$e');
                             }
                        }),
                        ),
                    
                    ],
                  ),
            ),
          ),
        );}
      ),
    );
  }
}


class ImageDialog extends StatelessWidget {
  final String  myParam;
  ImageDialog(this.myParam);
  @override
  Widget build(BuildContext context) {
    return Dialog(
  // backgroundColor: Colors.transparent,
  // elevation: 0,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close_rounded),
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.5,
        child: Image.network(
          '$myParam',
          fit: BoxFit.cover,
        ),
      ),
    ],
  ),
); 
  }
}



