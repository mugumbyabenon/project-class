import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ApprovalLoan extends StatefulWidget {
  const ApprovalLoan({super.key});

  @override
  State<ApprovalLoan> createState() => _ApprovalLoanState();
}

class _ApprovalLoanState extends State<ApprovalLoan> {
  String? query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
       shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Center(
            child: const Text('Loan Management',style: TextStyle(
              color: Colors.white
            ),),
          ),
    ),
    body: Row(
      children: [GestureDetector(
        onTap: (){
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Used()),
            );    
        },
        child: Container(
          decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color.fromARGB(255, 206, 204, 204),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
          width: MediaQuery.of(context).size.width*0.5,
          height: 200,
          child: Center(child: Text('Approve Loans',style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold),)),
        ),
      ),Container(
        decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color.fromARGB(255, 206, 204, 204),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
         width: MediaQuery.of(context).size.width*0.5,
         height: 200,
         child: Center(child: Text('View Approved Loans',style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold),)),
      )],
    ),);
  }
}

class Used extends StatefulWidget {
  const Used({super.key});

  @override
  State<Used> createState() => _UsedState();
}

class _UsedState extends State<Used> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoanManagement(),
    appBar: AppBar( shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Center(
            child: const Text('Approve Loans',style: TextStyle(
              color: Colors.white
            ),),
          ),leading: BackButton(color: Colors.orange),
    ),);
  }
}
class LoanManagement extends StatefulWidget {
  const LoanManagement({super.key});

  @override
  State<LoanManagement> createState() => _LoanManagementState();
}

class _LoanManagementState extends State<LoanManagement> {
  @override
  Widget build(BuildContext context) {
       User? user = FirebaseAuth.instance.currentUser;
       NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Loans').where('Query',isEqualTo: true)
        .snapshots(includeMetadataChanges: true);
        
 return    StreamBuilder<QuerySnapshot>(
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
                              children: [Text('NIN No.',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                Expanded(
                                  child: Text('${data?['NIN no.']??""}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Location',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                Expanded(
                                  child: Text('${data?['Location']??""}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Monthly Fee',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                Expanded(
                                  child: Text('Shs.${myFormat.format(int.parse(data?['MonthlyFee']??""))}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Total Amount',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                Expanded(
                                  child: Text('Shs.${myFormat.format(int.parse(data?['TotalAmount']??""))}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01), Column(
                              children: [Text('**This fee is paid upon loan approval',style: TextStyle(fontSize: 12),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text('Intial Deposit',style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                    Expanded(
                                      child: Text('Shs.${myFormat.format(int.parse(data?['Intial Deposit']??""))}',style: TextStyle(
                                      fontSize: 20),),
                                    ),
                                  ],
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Acquistion',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                Expanded(
                                  child: Text('${data?['delivery']??""}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),  Row(
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
                               
                                  log('hey hey');
                                  await  FirebaseFirestore.instance.collection('Loans').doc('${data?['uid']??"Active"}').delete();
                                
                               }, child: Text('Reject Loan')),SizedBox(width: 40,),ElevatedButton(onPressed: ()async{
                               var collection = await FirebaseFirestore.instance.collection('Loans').doc('${data?['uid']??"Active"}');
                               final balance = int.parse(data?['TotalAmount'])- int.parse(data?['Intial Deposit']) ;
                            await   collection.update({'Balance': '${balance.toString()}'});
                            await    collection.update({'Query': false});
                           await     collection.update({'Status': 'Active'});
                          await     collection.update({'button': null});
                           await     collection.update({'Deposit_Button': null});
                            await     collection.update({'Intial Deposit': null});
                             await     collection.update({'Acquistion': null});
                              await     collection.update({'delivery': null});
                             await   collection.update({'Paid Money': '${data?['Intial Deposit']??0}'}); 
                               log('$balance');
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
        return Center(child: Text('Loan Application Doesnot exist',style: TextStyle(fontSize: 20),));
        
      },


    ); 
    
  }
}
