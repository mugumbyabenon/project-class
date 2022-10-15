import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
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
   late final TextEditingController _rate;





   @override
  void initState() {
    _email = TextEditingController();
      _rate = TextEditingController();
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
     _rate.dispose();
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
  String? AcceptLoans;
  bool isVisible=false;
  bool Visible=false;
  String? button = 'Buy';
  String? loan;
  String? rate='0';
  XFile?  images ;
  File? _image;
   XFile?  images1 ;
  File? _image1;
   XFile?  images2 ;
  File? _image2;
   XFile?  images3 ;
  File? _image3;
  String imageUrl = 'https://t4.ftcdn.net/jpg/01/67/65/73/360_F_167657302_FNkJP5s2AUCzQwiKwmO9PV2JkcC6l8Zr.jpg';
   
      void dropLoan(String? selectedValue){
      if (selectedValue is String){
        setState(() {
          AcceptLoans = selectedValue;
        });
      
        if ( selectedValue == 'Yes'){
        setState(() {
         isVisible= true;
        });
      } else{
         setState(() {
         isVisible= false;
        });
      } 
      }
      
    }

    void dropdownCallback(String? selectedValue){
      if (selectedValue is String){

        setState(() {
          category = selectedValue;
        });
      }
        if ( selectedValue == 'Rentals'){
        setState(() {
          button = 'Rent';
           Visible = false;
            isVisible= false;
        });
      }if ( selectedValue == 'Motorcycles'){
        setState(() {
          Visible = true;
        });
      }if ( selectedValue == 'Cars'){
        setState(() {
           Visible = true;
        });
      }
      if ( selectedValue == 'Spareparts'){
        setState(() {
           Visible = false;
            isVisible= false;
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
    
        body: MyWidget()
      
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




class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   late final TextEditingController _email;
  late final TextEditingController _password;
    late final TextEditingController _confirmpassword;
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _phonenumber;
  late final TextEditingController _companyname;
  late final TextEditingController _location;
   late final TextEditingController _rate;





   @override
  void initState() {
    _email = TextEditingController();
      _rate = TextEditingController();
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
     _rate.dispose();
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
  String? AcceptLoans;
  bool isVisible=false;
  bool Visible=false;
  String? button = 'Buy';
  String? loan;
  String? rate='0';
  XFile?  images ;
  File? _image;
   XFile?  images1 ;
  File? _image1;
   XFile?  images2 ;
  File? _image2;
   XFile?  images3 ;
  File? _image3;
  String imageUrl = 'https://t4.ftcdn.net/jpg/01/67/65/73/360_F_167657302_FNkJP5s2AUCzQwiKwmO9PV2JkcC6l8Zr.jpg';
   
      void dropLoan(String? selectedValue){
      if (selectedValue is String){
        setState(() {
          AcceptLoans = selectedValue;
        });
      
        if ( selectedValue == 'Yes'){
        setState(() {
         isVisible= true;
        });
      } else{
         setState(() {
         isVisible= false;
        });
      } 
      }
      
    }

    void dropdownCallback(String? selectedValue){
      if (selectedValue is String){

        setState(() {
          category = selectedValue;
        });
      }
        if ( selectedValue == 'Rentals'){
        setState(() {
          button = 'Rent';
           Visible = false;
            isVisible= false;
        });
      }if ( selectedValue == 'Motorcycles'){
        setState(() {
          Visible = true;
        });
      }if ( selectedValue == 'Cars'){
        setState(() {
           Visible = true;
        });
      }
      if ( selectedValue == 'Spareparts'){
        setState(() {
           Visible = false;
            isVisible= false;
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
    return SingleChildScrollView(
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
                           icon: Icon(Icons.pending_actions,),
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
                            icon: Icon(Icons.model_training,),
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
                           icon: Icon(Icons.unsubscribe_outlined,),
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
                           icon: Icon(Icons.location_city),
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
                          icon: Icon(Icons.description),
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
                           icon: Icon(Icons.price_change),
                          hintText: 'Price',
                          fillColor: Colors.grey[200],
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          
                        ),
                      ),
                    ),SizedBox(height: 10,),
                      Row(children: [
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
                    ],),SizedBox(height: 10,), 
                   Visibility(
                    visible: Visible,
                     child: Row(children: [
                      const  Padding(
                          padding:  EdgeInsets.all(.0),
                          child: Expanded(
                            child: Text('Accept Loans',style: TextStyle(
                                         // color: Colors.amberAccent[200],
                                          letterSpacing: 2.2,
                                          fontSize: 20.0,
                                         // fontWeight: FontWeight.bold,
                                        ),),
                          ),
                        ),SizedBox(width: 35,),DropdownButton(items: const[
                          DropdownMenuItem(child: Text('Yes'),value: 'Yes',),
                           DropdownMenuItem(child: Text('No'),value: 'No',),
                           
                        ],value: AcceptLoans, onChanged: dropLoan)
                      ],),
                   ),SizedBox(height: 10,),
                     Visibility(
            visible: isVisible,
            child: TextFormField(
             controller: _rate,
              keyboardType: TextInputType.number,
                        autocorrect: false,  
              decoration:  InputDecoration(
                 enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                border: const UnderlineInputBorder(),
                filled: true,
                icon: const Icon(
                Icons.rate_review,
                size: 20.0,
                ),
                hintText: 'Consider a mangeable rate',
                labelText: 'Monthly Loan Rate',
              ),
            ),
          ), 
                   ElevatedButton(
                   //  color: CupertinoColors.activeOrange,
                    child: const Text('Upload Advert'),
                    onPressed: (() async {
                     CollectionReference users = FirebaseFirestore.instance.collection('Adverts');
                      Future<void> addUser(String first_name, int phone_number,String email, 
                      String companyname, String lastname,String description,final imagesUrl,
                      final imagesUrl1,final imagesUrl2,final imagesUrl3,final rates) {
              
                          User? user = FirebaseAuth.instance.currentUser;
                        // Check if the user is signed in
                        if (user != null) {
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
                             'loan':loan,
                          'Car Name': email,
                          'user': uid,
                          'email':emails,
                          'description':description,
                          'Category':category,
                          'pk':pk,
                          'all':'all',
                          'button':button,
                          'rate':rates,
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
                if ( isVisible == true){
                     if (_rate.text.isNotEmpty) {                      
                             final car = int.parse(_rate.text.trim());
                              if (car <= 20){
                              setState(() {
                                loan = 'Yes';
                                button = 'Request Loan/Buy';
                                rate = _rate.text.trim();
                              });
                   addUser(_firstname.text.trim(),  
                          int.parse(_phonenumber.text.trim()), _email.text.trim(),_companyname.text.trim(),_lastname.text.trim(),_password.text.trim(),
                         imagesUrls,imagesUrl1,imagesUrl2,imagesUrl3,rate );
                         log('$category');
                        
                               }  else{
                                 await showErrorDialog(context, '${_rate.text.trim()}% is very a high rate. Try a manageable rate that is below 20%');
                              }
                             } else {
                                addUser(_firstname.text.trim(),  
                          int.parse(_phonenumber.text.trim()), _email.text.trim(),_companyname.text.trim(),_lastname.text.trim(),_password.text.trim(),
                         imagesUrls,imagesUrl1,imagesUrl2,imagesUrl3,'0' );
                         log('$category');
                                log('message');  
                                } } else{
           addUser(_firstname.text.trim(),  
                          int.parse(_phonenumber.text.trim()), _email.text.trim(),_companyname.text.trim(),_lastname.text.trim(),_password.text.trim(),
                         imagesUrls,imagesUrl1,imagesUrl2,imagesUrl3,'0' );
                                       
                                }            
                          
          } 
           catch (e) {
                          showErrorDialog(context, '$e');
                          log('$e');
                         }
                    }),
                    ),
                
                ],
              ),
        );
  }
}