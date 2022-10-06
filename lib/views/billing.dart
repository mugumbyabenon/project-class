import 'dart:developer';

import 'package:car_loan_project/constants/routes.dart';
import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:car_loan_project/views/mypendingbills.dart';
import 'package:car_loan_project/views/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Billing extends StatefulWidget {
  const Billing({super.key});

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  int currentIndex = 0;
  List<Widget> screens = [
     Billing(),PendingTransactions(),Upload()
  ];

   void _onItemTapped(int index){
    setState(() {
      currentIndex = index;
    });
   }

   late final TextEditingController _bill;
   late final TextEditingController _userid;
   late final TextEditingController _car;
   late final TextEditingController _billing;

     @override
  void initState() {
    _bill = TextEditingController();
    _userid = TextEditingController();
    _car = TextEditingController();
    _billing = TextEditingController();
    super.initState();
    }

     @override
  void dispose() {
    _bill.dispose();
    _userid.dispose();
    _car.dispose();
    _billing.dispose();
    super.dispose();
    }
    
    Future CheckifUserExists(String docId, int bill,String car,int phone_number) async {
        var doc = await FirebaseFirestore.instance.collection('users').doc(docId).get();
        if(doc.exists){
          log('exists');
          FirebaseFirestore.instance.collection('bills').add({'amount':bill.toString(),'user':docId,'car':car,'phone_number':phone_number.toString()}).then((value) => 
          Navigator.of(context).pushNamedAndRemoveUntil(
                    homeRoutes, (route) => false));
         //   ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('Added Bill successfully')))).catchError((error) => showErrorDialog(context, '$error'));
          return doc;
        } if (!doc.exists){
          showErrorDialog(context, 'User Does not Exist');
          return null;
        }
     
    
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [   Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(controller: _car,
            autocorrect: false,
          //  decoration: InputDecoration(hintText: 'Enter the car name',fillColor: Colors.grey),
              decoration:  InputDecoration(
                              hintText: 'Enter the car',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
            ),
        ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(controller: _bill,
            autocorrect: false,
              decoration:  InputDecoration(
                                hintText: 'Total Amount Bill',
                                fillColor: Colors.grey[200],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
          //  decoration: InputDecoration(hintText: 'Total Amount to bill',fillColor: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(controller: _userid, autocorrect: false,
             decoration:  InputDecoration(
                                hintText: 'Enter the  Customer UserID',
                                fillColor: Colors.grey[200],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
         //   decoration: InputDecoration(hintText: 'Enter the  Customer UserID',fillColor: Colors.grey),
            ),
          ),
          ElevatedButton(onPressed: ()async{
          //  await CheckifUserExists(_userid.text.trim());
          try{
           await CheckifUserExists(_userid.text.trim(),int.parse(_bill.text.trim()),_car.text.trim(),int.parse(_billing.text.trim()));
            ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('Added Bill successfully')));
           } catch (e){return showErrorDialog(context, '$e');}
          }, child: Text('Register'))
        ],
      ),
    );
  }
}


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
 int currentIndex = 0;
  List<Widget> screens = [
     Billing(),PendingTransactions(),Upload()
  ];

   void _onItemTapped(int index){
    setState(() {
      currentIndex = index;
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.payment),label: 'Start Billing',),
        BottomNavigationBarItem(icon: Icon(Icons.sell),label: 'Pending Payments',),
         BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Upload Advert',)
      ],type: BottomNavigationBarType.fixed,
     onTap: _onItemTapped,
      ),
      body: screens.elementAt(currentIndex),
    );
  }
}