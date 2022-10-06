import 'dart:developer';
import 'dart:io';

import 'package:car_loan_project/constants/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../enums/menu_action.dart';
import '../services/auth/auth_service.dart';
import 'notes_view.dart';

class DealerDetails extends StatelessWidget {
   final String myParam;
    final String productstatus;
   DealerDetails(this.myParam,this.productstatus);
  // DealerDetails({super.key,this.myParam});

  @override
  Widget build(BuildContext context) {
     User? user = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: "$myParam")
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
           
                          
        return Column(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Column(
                    children: [
                      Row(
                      children: [Column(
                        children: [
                          Text('Company Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          Text('${data?['company name']??""}'),
                        ],
                      ),SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                      Column(
                        children: [
                          Text('Product Status',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                           Text('$productstatus'),
                        ],
                      )],
                      ), SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                         Row(
                      children: [Column(
                        children: [
                          Text('Phone Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),SizedBox(height: 10,),
                          Text('${data?['phone_number']??""}'),
                        ],
                      ),SizedBox(width: MediaQuery.of(context).size.width * 0.2,),Column(
                        children: [
                          Text('Advertiser name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                           Row(
                             children: [
                               Text('${data?['first_name']??""}'),
                               SizedBox(width: 10,) ,Text('${data?['last name']??""}'),
                             ],
                           ),
                        ],
                      )],
                      ), SizedBox(height: MediaQuery.of(context).size.height * 0.03,),Row(
            children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.black,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              Text(
                '${data?['email']??""}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                  letterSpacing: 1.0,
                ),
              )
            ],
          ),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                 // subtitle: Text(data?['Car Model']??''),
                );
              })
              .toList()
              .cast(),
        );
        
      },


    ); 
    
    
  

  }
}

class Comments extends StatefulWidget {
  final String comment;
  Comments(this.comment);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  
  @override
  Widget build(BuildContext context) {
     User? user = FirebaseAuth.instance.currentUser;
  
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Comments')
        .where("primarykey", isEqualTo: "${widget.comment}")
        .snapshots(includeMetadataChanges: true);
        
    return StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          
          User? user = FirebaseAuth.instance.currentUser; 
        return SizedBox(
          height: MediaQuery.of(context).size.height*0.2,
          child: ListView(
           // scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Row(
                      children: [ CircleAvatar(
                        radius: MediaQuery.of(context).size.height*0.05,
                        backgroundImage: NetworkImage('${data?['image']??""}'),
                      ),SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('${data?['username']??""}',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width*0.03),),
                              ],
                            ),
                            Text('${data?['comment']??"No Reviews or comments available"}',  style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context).size.width*0.05,
                                        letterSpacing: 1.0,
                                      ),)
                          ],
                        ),
                      )],
                    ),
                  );
                })
                .toList()
                .cast(),
          ),
        );
        
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        return Text('No comments available');
        
      },


    ); 
    
    
   


  }
}