

import 'dart:developer';
import 'dart:io';

import 'package:car_loan_project/constants/routes.dart';
import 'package:car_loan_project/enums/menu_action.dart';
import 'package:car_loan_project/views/notes_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth/auth_service.dart';
import '../utilities/showErrorDialog.dart';
import 'login_view.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _NinjaCardState();
}

class _NinjaCardState extends State<UserProfile> {
  int ninjaLevel=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: Colors.white,
      body:UserInformation(),

    );
  }
}




 class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
 
     
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
    String? emails = user.email;
    String? uid = user.uid;
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: "$emails")
        .snapshots(includeMetadataChanges: true);
        
    return StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
          User? user = FirebaseAuth.instance.currentUser;
           if (user != null) {
                          String uid = user.uid; // <-- User ID
                          String? emails = user.email;
                          log(uid); 
        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton <MenuAction>(iconSize:  MediaQuery.of(context).size.width*0.08,icon: Icon(Icons.format_list_bulleted),
            onSelected: ((value) async {
              switch (value){
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout == true){
                  await AuthService.firebase().logOut();
                      Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => NotesView()), (r) => false);
             ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('You have successfully logged out')));
                  }
              }
            }),
            itemBuilder: (context) {
              return [ 
                const PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                  )
              ];
            },
           ),
                          ],
                        ),
                          CircleAvatar(radius: 80,
                            backgroundImage: NetworkImage('${data?['image']??""}'),
                            child: GestureDetector(onDoubleTap: ()  async {
                               File? _image;
                               String imageUrl = '';
                               final image = await ImagePicker().pickImage(source: ImageSource.gallery) ;
                               if(image == null) {
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('No file has been selected')));
                               log('failed to upload');
                             return null;
                   };            
                            final upload = await FirebaseStorage.instance.ref().child('mages').
                            child(DateTime.now().toString()+'.jpg');
                            final path = image.path;
                            File file = File(path);
                            await upload.putFile(file) ;
                              FirebaseFirestore.instance.collection('users').doc('$emails').update({'image': '${await upload.getDownloadURL()}'});
                               final FirebaseAuth _auth = FirebaseAuth.instance;
                               await _auth.currentUser!.updatePhotoURL('${await upload.getDownloadURL()}');
                               log('${user}');
                            },)
                          ),
            Divider(
              height: MediaQuery.of(context).size.height * 0.02,
              color: Colors.grey[850],
            ),
            Text(
              'Company Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '${data?['company name']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ), SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Text(
              'First Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '${data?['first_name']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
             Text(
              'Last Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '${data?['last name']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Text(
              'Phone Number',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '${data?['phone_number']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),  Text(
              'User ID',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '$uid',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  '${data?['email']??""}',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13.0,
                      letterSpacing: 1.0,
                  ),
                )
              ],
            ),
                        ],
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                 // subtitle: Text(data?['Car Model']??''),
                );
              })
              .toList()
              .cast(),
        );} throw FirebaseAuthException(code: 'An Error Occurred');
        
      },


    ); 
    
    
    } return AlertDialog(
        title:  const Text('Join our Family Today '),
          content: Text('Reach Out to thousands of customers or obtain unsecured loans'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
            }
            , child: const Text('Login/SignUp'))
          ],
    );


  }
}


Future<bool> showLogOutDialog(BuildContext context){
 return showDialog<bool>(
    context: context, 
    builder: (context){
       return AlertDialog(title: const Text('Sign Out'),
       content: const Text('Are you sure you want to log out'),
       actions: [TextButton(
        onPressed: (){
          Navigator.of(context).pop(true);
        },
        child:const Text('Logout'),),
        TextButton(onPressed: (){
           Navigator.of(context).pop(false);
        }, 
        child: const Text('Cancel'))
        ],
       );   
    },
    ).then((value) => value ?? false);
}