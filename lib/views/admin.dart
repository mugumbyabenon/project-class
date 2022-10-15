import 'dart:developer';

import 'package:car_loan_project/main.dart';
import 'package:car_loan_project/views/phoneconfirmation.dart';
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
  String? collected;
  @override
  Widget build(BuildContext context) {
     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
      Interest(){
         final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance.collection('CompanyInterest').snapshots();
        return StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          
          User? user = FirebaseAuth.instance.currentUser; 
        return Column(
         // scrollDirection: Axis.horizontal,
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Row(
                    children: [ 
                     Text('Total Profit Collected',style: TextStyle(fontWeight: FontWeight.bold),),SizedBox(width: 10,),
                     Expanded(child: Text('${myFormat.format(data?['interest']??"")}'))
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
        return Text('No comments available');
        
      },


    ); 
      }
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
    body: ListView(
      children: [
        Row(
          children: [GestureDetector(
            onTap: (){
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  PhoneConfirmation()),
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
              child: Center(child: Text('Confirm Applications',style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
          ),GestureDetector(
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
          )],
        ),Interest(),SizedBox(height: MediaQuery.of(context).size.height*0.9,),SizedBox(width: 5,
          child: ElevatedButton(onPressed: ()async{
            await Loans();
          }, child: Text('Calculate Interest')))
      ],
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
  String? advert;
  @override
  Widget build(BuildContext context) {
       User? user = FirebaseAuth.instance.currentUser;
       NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Loans').where('Query',isEqualTo: 'approve')
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
                            ),Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Expanded(
                                child: Text('Product Price',style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                              ),SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                                Expanded(
                                  child: Text('Shs.${myFormat.format(data?['Price']??"")}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01), Column(
                              children: [Text('**This fee is paid before loan approval',style: TextStyle(fontSize: 12),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Expanded(
                                    child: Text('Intial Deposit by Buyer',style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 20),),
                                  ),SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                    Expanded(
                                      child: Text('Shs.${myFormat.format(int.parse(data?['Intial Deposit']??""))}',style: TextStyle(
                                      fontSize: 20),),
                                    ),
                                  ],
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01), 
                            SizedBox(height: MediaQuery.of(context).size.height*0.01),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Acquistion',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                Expanded(
                                  child: Text('${data?['delivery']??""}',style: TextStyle(
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
                                 final DateTime now = DateTime. now();
                               final DateFormat formatter = DateFormat('yyyy-MM-dd');
                               final loanEndDate=int.parse(data?['NumberOfMonths'])*31;
                               final NextBillingDate = now.add( Duration(days: loanEndDate));
                               final next = now.add(Duration(days: 31));
                              final  formatted = DateFormat.yMMMMd().format(now);
                              final nextMonth = formatter.format(next);
                              final RepaymentDate = DateFormat.yMMMMd().format(NextBillingDate);
                               var collection = await FirebaseFirestore.instance.collection('Loans').doc('${data?['uid']??"Active"}');
                               final balance = int.parse(data?['TotalAmount'])- int.parse(data?['Intial Deposit']) ;
                            await   collection.update({'Balance': '${balance.toString()}'});
                            var userupdate = await FirebaseFirestore.instance.collection('users').doc('${data?['selleremail']}');
                            var car= await userupdate.get();
                               if (car.exists) {
            Map<String, dynamic>? comp = car.data();
            final gets = comp?['My Money']??0;
            final k = comp?['Pending']??0;
            final pending=balance + k;
            final exits= gets+ int.parse(data?['Intial Deposit']) ;
            await userupdate.update({'My Money':exits});
             await userupdate.update({'Pending':pending});
            }
                              await     collection.update({'Paid Money': int.parse(data?['Intial Deposit'])});
                            await    collection.update({'Query': 'interest'});
                           await     collection.update({'Status': 'Active'});
                          await     collection.update({'button': null});
                           await     collection.update({'Deposit_Button': null});
                            await     collection.update({'Intial Deposit': null});
                             await     collection.update({'Application Date': null});
                               await     collection.update({'app date': null});
                              await     collection.update({'Acquistion': null});
                             await     collection.update({'delivery': null});
                               await     collection.update({'Pending': 'debt'});
                                await     collection.update({'Loan Start Date': formatted});
                                await     collection.update({'Date Taken': nextMonth});
                                 await     collection.update({'Loan End Date': RepaymentDate});
                                await     collection.update({'PaymentPeriodButton': null});
                                 await     collection.update({'PaymentPeriod': null});
                                   await     collection.update({'Company Interest': 0});
                                 await FirebaseFirestore.instance.collection('Adverts').doc('${data?['advert Pk']??"Active"}').delete();
                          //     log('$balance');
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


 
