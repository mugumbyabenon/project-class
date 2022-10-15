import 'dart:developer';

import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:car_loan_project/views/notes_view.dart';
import 'package:car_loan_project/views/payments.dart';
import 'package:car_loan_project/views/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants/routes.dart';

class ApproveBySeller extends StatefulWidget {
  const ApproveBySeller({super.key});

  @override
  State<ApproveBySeller> createState() => _ApproveBySellerState();
}

class _ApproveBySellerState extends State<ApproveBySeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Approve Loans',style: TextStyle(color: Colors.white,fontSize: 20),),
      backgroundColor: Colors.black,
      leading: BackButton(color: Colors.orange),
    ),
    body: SellerApproval(),);
  }
}

class SellerApproval extends StatefulWidget {
  
 // SellerApproval(this.comment);

  @override
  State<SellerApproval> createState() => _CommentsState();
}

class _CommentsState extends State<SellerApproval> {
  
  @override
  Widget build(BuildContext context) {
     User? user = FirebaseAuth.instance.currentUser;
       NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    if (user !=null){
      String uid = user.uid;
    
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Loans')
        .where("sellerID", isEqualTo: "${uid}")
        .snapshots(includeMetadataChanges: true);
        
    return StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          
          User? user = FirebaseAuth.instance.currentUser; 
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
           // scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                   title: Row(
                      children: [ 
                      SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network('${data?['image']??""}', width:  MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.3,
                                                fit: BoxFit.cover),
                          ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Car Name',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                Expanded(
                                  child: Text('${data?['Car name']??""}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Buyer Name',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                Expanded(
                                  child: Text('${data?['names']??""}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Rate',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                Expanded(
                                  child: Text('${data?['rate']??""}% per month',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),
                            
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Loan Status',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                Expanded(
                                  child: Text('${data?['Status']??"Active"}',style: TextStyle(color: Colors.redAccent,
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                           Row(
                             children: [
                               ElevatedButton(onPressed: ()async{
                                var collection = await FirebaseFirestore.instance.collection('Loans').doc('${data?['uid']??"Active"}');
                      //   var collection = await FirebaseFirestore.instance.collection('Loans').doc('${data?['uid']??"Active"}');
                                collection.update({'Status':'Seller is no longer accepting loan payments'});
                                 collection.update({'Query':null});
                                    collection.update({'seller':'${uid}'});
                                  collection.update({'sellerID':'{uid}'});
                                                Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => NotesView()), (r) => false);
                    
                   ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('You loan Application Approval has been submitted.We shall process payment')));
                           //      await     collection.update({'Status': 'Active'});
                               }, child: Text('Reject')),SizedBox(width: 40,), ElevatedButton(onPressed: ()async{
                                var collection = await FirebaseFirestore.instance.collection('Loans').doc('${data?['uid']??"Active"}');
                                  collection.update({'Query':'phone'});
                                 collection.update({'seller':'${uid}'});
                                  collection.update({'sellerID':'{uid}'});
                                   collection.update({'Status':'Finalizing paperwork with seller, we will contact you soon'});
                    
                  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('You loan Application Approval has been submitted.We shall process payment')));
                      
                          //       await     collection.update({'Status': 'Active'});
                               }, child: Text('Approve')),
                             ],
                           )
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
        return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have no Loans to approve  Post more adverts to find more customers online',style: TextStyle(fontSize: 19),),
            ElevatedButton(onPressed: (){
               Navigator.push(context,
                MaterialPageRoute(builder: (context) => Upload()),);
            }, child: Text('Post Advert'))
          ],
        ));
        
      },


    ); 
    
    
  } else throw  showErrorDialog(context, 'An error occured');


  }
}

class PurchaseReq extends StatefulWidget {
  const PurchaseReq({super.key});

  @override
  State<PurchaseReq> createState() => _PurchaseReqState();
}

class _PurchaseReqState extends State<PurchaseReq> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
     if (user != null) {
    String? emails = user.email;
    String? uid = user.uid;
     final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Purchase Requests')
        .where("sellerpk", isEqualTo: "$uid")
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Purchase Requests',style: TextStyle(
            fontSize: 20,color: Colors.white
          ),),
        ),
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.orange),
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      return    ListView(
       // scrollDirection: Axis.horizontal,
        children: snapshot.data!.docs
            .map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Column(
                  children: [ 
                    Row(children: [
                      Text('Buyer Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(width: 30,),Expanded(child: Text('${data?['buyer name']??''}',
                      style: TextStyle(fontSize: 20,),))
                    ],),SizedBox(height: 10,), Row(children: [
                      Text('Phone number',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(width: 30,),Expanded(child: Text('${data?['phone number']??''}',
                      style: TextStyle(fontSize: 20,),))
                    ],),SizedBox(height: 10,),
                      Row(children: [
                      Text('Product Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(width: 20,),Expanded(child: Text('${data?['product name']??''}',
                      style: TextStyle(fontSize: 20,),))
                    ],),SizedBox(height: 10,), 
                     Row(children: [
                      Text('Product Price',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(width: 30,),Expanded(child: Text('Shs.${myFormat.format(data?['Product price']??'')}',
                      style: TextStyle(fontSize: 20,),))
                    ],),SizedBox(height: 10,),
                      Row(children: [
                      Expanded(child: Text('Price offerred by buyer',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      SizedBox(width: 20,),Expanded(child: Text('Shs.${myFormat.format(data?['price offered']??'')}',
                      style: TextStyle(fontSize: 20,color: Colors.red),))
                    ],),SizedBox(height: 10,),
                    Row(children: [
                      Expanded(child: Text('Delivery Location',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      SizedBox(width: 30,),Expanded(child: Text('${data?['delivery location']??''}',
                      style: TextStyle(fontSize: 20,),))
                    ],),SizedBox(height: 10,),ElevatedButton(onPressed: ()async{
                      await FirebaseFirestore.instance.collection('Purchase Requests').doc('${data?['pk']??''}').delete();
                    }, child: Text('Remove'))
                  ],
                ),
              );
            })
            .toList()
            .cast(),
      );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have no Purchase Requests  Post more adverts to find more customers online',style: TextStyle(fontSize: 19),),
            ElevatedButton(onPressed: (){
               Navigator.push(context,
                MaterialPageRoute(builder: (context) => Upload()),);
            }, child: Text('Post Advert'))
          ],
        ));
        
      },


    ),
    );} else{
      throw showErrorDialog(context, 'Something Went Wrong');
    }
  }
}