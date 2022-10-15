import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class PhoneConfirmation extends StatefulWidget {
  const PhoneConfirmation({super.key});

  @override
  State<PhoneConfirmation> createState() => _PhoneConfirmationState();
}

class _PhoneConfirmationState extends State<PhoneConfirmation> {
   NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
     final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Loans').where('Query',isEqualTo: null)
        .snapshots(includeMetadataChanges: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.black,
      title: Center(child: Text('Call Confirmation',style: TextStyle(color: Colors.white),),),
      leading: BackButton(color: Colors.orange),
    ),
    body:  Phone(),
    );
  }
}

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  String? advertpk;
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
     final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Loans').where('Query',isEqualTo: 'phone')
        .snapshots(includeMetadataChanges: false);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:_bmStreams,
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
                          children: [
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
                            ),
                            Row(
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
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Expanded(
                                child: Text('Intial Deposit',style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                              ),SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                                Expanded(
                                  child: Text('Shs.${myFormat.format(int.parse(data?['Intial Deposit']??""))}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01), 
                            Column(
                              children: [Text('**This fee is paid upon loan approval',style: TextStyle(fontSize: 12),),
                              
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01), Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Expanded(
                                    child: Text('Phone number',style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 20),),
                                  ),SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                    Expanded(
                                      child: Text('${data?['Phone Number']??""}',style: TextStyle(
                                      fontSize: 20),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                               var collection = await FirebaseFirestore.instance.collection('Loans').doc('${data?['uid']??"Active"}');
                           
                   setState(() {
                     advertpk = data?['Advert Pk']??"";
                   });
                   log('$advertpk');
                   await     collection.update({'Advert Pk': 'null'});
                    await     collection.update({'advert Pk': '$advertpk'});
         // List<String> ids=[];
                            QuerySnapshot snapshot=await FirebaseFirestore.instance
        .collection('Loans')
        .where("Advert Pk", isEqualTo: "${advertpk}").get();
                            snapshot.docs.forEach((doc) async { 
                              log('${doc.id}');
                              var collections = await FirebaseFirestore.instance.collection('Loans').doc('${doc.id}');
                                collections.update({'Status':'Seller is no longer accepting loan payments'});
                                 collections.update({'Query':'out of stock'});
                                      
                            }); 
                    final delivery = data?['delivery']??"" ;        
                   if(delivery == 'Pick Up from Bond'){
                     collection.update({'Status':'Report to our office to finalize document application'});
                      collection.update({'Query': 'approve'}); 
                   }
                    if(delivery == 'Ship to location'){
                     collection.update({'Status':'Product will be delivered to you shortly to finalize document application'});
                      collection.update({'Query': 'approve'}); 
                   }
                   
                            
                               }, child: Text('Confirm')),
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
        return Center(child: Text('No Loans to confirm',style: TextStyle(fontSize: 20),));
        
      },


    );
  }
}