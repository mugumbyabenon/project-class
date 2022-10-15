import 'dart:developer';

import 'package:car_loan_project/constants/routes.dart';
import 'package:car_loan_project/views/dealerDetails.dart';
import 'package:car_loan_project/views/loan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'login_view.dart';
import 'notes_view.dart';

class DataController extends GetxController{
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
    await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }
  Future queryData(String queryString) async {
    return FirebaseFirestore.instance.collection('Adverts').where(
      'Car Name',isGreaterThanOrEqualTo: queryString
    ).get();
  }
}

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _HomePageState();
}

class _HomePageState extends State<SearchProduct> {
    late final TextEditingController _search;
  late  QuerySnapshot snapshotData;
  late bool isExecuted =false;
   @override
  void initState() {
    _search = TextEditingController();}
     @override
  void dispose() {
    _search.dispose();}
  @override
  Widget build(BuildContext context) {
      Widget searchedData(){
        return ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context,int index){
            return GestureDetector(
                onTap: () async {
                            //ScaffoldMessenger.of(context).showSnackBar
                           //  ( const SnackBar(content:Text('An email verification has been sent to your email to confirm your account')));
                             String imageUrl =  snapshotData.docs[index]?['imageUrl']??"";
                             String sellerid =   snapshotData.docs[index]?['email']??"";
                              final carname =  '${snapshotData.docs[index]?['email']??""}  ${snapshotData.docs[index]?['email']??""}' ;
            User? user = FirebaseAuth.instance.currentUser;
                         
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Category('${snapshotData.docs[index]?['Car Name']??""}', 'Car Name')),
            );       
                          },
              child: ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(
                  snapshotData.docs[index]?['imageUrl']??""
                )
                 ),title: Text('${snapshotData.docs[index]?['Car Name']??""}',style: TextStyle(
                  color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 20,
                 ),),
              ),
            ) ;
          });
      };
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.clear),onPressed: (){
        setState(() {
          isExecuted = false;
        });
      },),
      appBar: PreferredSize(
         preferredSize: Size.fromHeight(78.0),
        child: AppBar(
          leading: BackButton(color: Colors.orange),
          actions: [GetBuilder<DataController>(
            init: DataController(),
            builder: (val){
              return IconButton(
                color: Colors.white,
                onPressed: (){
                val.queryData(_search.text.toUpperCase()).then((value){
                  log('value');
                     snapshotData = value;
                     setState(() {
                       isExecuted =true;
                     });
                });
              }, icon: Icon(Icons.search,));
            })],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: Colors.black,
          title: TextField(
                   controller: _search,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                             
                              hintText: 'Vehiles,Garages,Equipment,...',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
          )),
      ),
      body: isExecuted ? searchedData(): Container(
        child: Center(child: Text('Search for product')),
      ),
    );
  }
}

