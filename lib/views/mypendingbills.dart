import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uganda_mobile_money/models/pay.request.dart';
import 'package:uganda_mobile_money/models/pay.response.dart';

class PendingTransactions extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<PendingTransactions> {
   late final TextEditingController _amount;

     @override
  void initState() {
    _amount = TextEditingController();
     super.initState();
    }

      @override
  void dispose() {
    _amount.dispose();
     super.dispose();
    }
 
     
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
    String? emails = user.email;
    String? uid = user.uid;
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('bills')
        .where("user", isEqualTo: "$emails")
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [            
            Divider(
              height: 10.0,
              color: Colors.grey[850],
            ),
            Text(
              'Car Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              '${data?['car']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ), Text(
              'Outstanding Balance',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),

            SizedBox(height: 10.0,),
            Text(
              '${data?['amount']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ), TextFormField(controller: _amount,
          autocorrect: false,
          decoration: InputDecoration(hintText: 'Mobile Money number to make payment',fillColor: Colors.grey),
           validator: (value) =>
                      value!.isNotEmpty? null : "Please fill in Your Email",
          ),
            ElevatedButton(onPressed: (){
                  

            }, child: Text('Make Payment'))
                      ],
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
    
    
    } throw FirebaseAuthException(code: 'An Error Occurred');
  }
}

