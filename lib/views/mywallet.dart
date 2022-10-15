import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
       User? user = FirebaseAuth.instance.currentUser;
        if (user != null) { 
       String? emails = user.email;
    String? uid = user.uid;
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: "$emails")
        .snapshots(includeMetadataChanges: true);    
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('My Wallet',style: TextStyle(color: Colors.white,fontSize: 20),)),
      backgroundColor: Colors.black,
      leading: BackButton(color: Colors.orange),),
      body: StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          
        
        return ListView(
         // scrollDirection: Axis.horizontal,
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Column(
                    children: [
                      Text('Account Balance',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                       SizedBox(height: 10,),
                      Text('${myFormat.format(data?['My Money']??0)}',
                      style: TextStyle(fontSize: 20,color: Colors.orange)),SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      SizedBox(height: 20,),
                       Text('Pending Loan Balance',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                      Text('${myFormat.format(data?['Pending']??0)}',style: TextStyle(fontSize: 20,color: Colors.orange)),
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      ElevatedButton(onPressed: (){}, child: Text('Withdraw Funds'))
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
    ),


    );} else{
   //   showErrorDialog(context, 'Login/Signup to continue');
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        body: Center(child: Text('Please login/Signup to access this feature',style: TextStyle(fontSize: 15),),),
      );
    }
  }
}