import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class searching extends StatelessWidget {
  final String sellerid;
  searching(this.sellerid);
  // void whatsAppOpen() async {
    //await FlutterLaunch.launchWathsApp(phone: "5534992016545", message: "Hello");
//  }
  @override
  Widget build(BuildContext context) {
     final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Adverts').snapshots();
     return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
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
          child: SizedBox(
            height: 400,
            child: ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                                      List<String> searchTerms =  [
                      '${'${data?['Car Name']??""}'}',
                    ];
                  })
                  .toList()
                  .cast(),
            ),
          ),
        );} throw FirebaseAuthException(code: 'An Error Occurred');
      },


    ); 



  }

}

