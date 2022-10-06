import 'dart:developer';

import 'package:car_loan_project/enums/menu_action.dart';
import 'package:car_loan_project/main.dart';
import 'package:car_loan_project/services/auth/auth_service.dart';
import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:car_loan_project/views/login_view.dart';
import 'package:car_loan_project/views/notes_view.dart';
import 'package:car_loan_project/views/userprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../constants/routes.dart';

class NullUser extends StatefulWidget {
  const NullUser({super.key});

  @override
  State<NullUser> createState() => _NotesViewState();
}

class _NotesViewState extends State<NullUser> {
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length:2,
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0.0,
           bottom: TabBar(
            indicatorColor: Colors.amberAccent,
            tabs: [
              Tab(icon: const Icon(Icons.car_rental_outlined,color: Colors.white,),),
              Tab(icon: Icon(Icons.person,color: Colors.white,)),
            ],
          ),
          ),
        ),
        body:  TabBarView(
      children: [
        UserInformation(),
        LoginView(),
      ],
    ),
      ),
    );
  }
}


class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Adverts').snapshots();

  @override
  Widget build(BuildContext context) {
     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return  StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        } 
         if (snapshot.connectionState == ConnectionState.none) {
          return Center(child: CircularProgressIndicator(),);
        } 
        
      try{
        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: PreferredSize(
                    preferredSize: Size.fromHeight(10.0),
                    
                    child: Container(
                       width: double.infinity,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                          Navigator.of(context).pushNamed(loginRoutes);
                            },
                            child: Image.network(
                                          data?['imageUrl']??"",
                                          width: 400,height: 300,
                                          
                                        ),
                          ),SizedBox(width: 5,),Padding(
                           padding: const EdgeInsets.symmetric(horizontal:0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                      Text(data?['Car Name']??"",style: GoogleFonts.bebasNeue(fontSize: 40),),Text(data?['Car Model']??"",style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                      ),),Text(data?['description']??"",style: GoogleFonts.poppins(fontSize: 11),softWrap: true),
                      Row(
                        children: [
                          Text('Shs.${myFormat.format(data?['Price']??"")}',style: GoogleFonts.bebasNeue(fontSize: 20),),
                        ],
                      ),Row(
                        children: [
                          Icon(Icons.sell_outlined,color:Colors.orange),Text(data?['Used or Brand New']??"",style: GoogleFonts.bebasNeue(fontSize: 10),),
                          SizedBox(width: 5,),
                          Icon(Icons.location_city,color:Colors.orange),Text(data?['Location']??"",style: GoogleFonts.bebasNeue(fontSize: 10),),
                          
                        ],
                      )
                                    ],
                                  ),

                                  
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
        );} catch (e){
          throw showErrorDialog(context, '$e');
        }
      },
    );

    
  }
}


class AdvertProfile extends StatelessWidget {
  final String  myParam;
  final String sellerid;
  AdvertProfile(this.myParam,this.sellerid);
  // void whatsAppOpen() async {
    //await FlutterLaunch.launchWathsApp(phone: "5534992016545", message: "Hello");
//  }
  @override
  Widget build(BuildContext context) {
      final advert =  FirebaseFirestore.instance
        .collection('users')
        .where("user", isEqualTo: "${sellerid}")
        .snapshots(includeMetadataChanges: true);
     return StreamBuilder<QuerySnapshot>(
      stream: advert,
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
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0,
          child: ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                       crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.close_rounded),
                              color: Colors.redAccent,
                            )
                          ,Text('Seller Details',style: TextStyle(fontSize: 20.0),),SizedBox(height: 20,),
                          CircleAvatar(radius: 100,
                            backgroundImage: NetworkImage('${data?['image']??""}'),        
                          ),
                       Text(
                    '${data?['company name']??""}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 50.0,
                      letterSpacing: 1.0,
                    ),
                  ), Text(
                    '${data?['email']??""}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    ),
                  ), Text(
                    '${data?['phone_number']??""}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    ),
                  ) , MaterialButton(onPressed: (){
                   //  FlutterOpenWhatsapp.sendSingleMessage("+256703807069", "Hello");
                  }, child: Text('Contact Dealer via Whatsapp')),          
                        ],
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                   // subtitle: Text(data?['Car Model']??''),
                  );
                })
                .toList()
                .cast(),
          ),
        );} throw FirebaseAuthException(code: 'An Error Occurred');
      },
    ); 
  }
}
