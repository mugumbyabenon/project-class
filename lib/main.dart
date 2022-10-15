import 'dart:developer';

import 'package:car_loan_project/constants/routes.dart';
import 'package:car_loan_project/services/auth/auth_service.dart';
import 'package:car_loan_project/views/billing.dart';
import 'package:car_loan_project/views/login_view.dart';
import 'package:car_loan_project/views/mainpage.dart';
import 'package:car_loan_project/views/notes_view.dart';
import 'package:car_loan_project/views/null.dart';
import 'package:car_loan_project/views/register_view.dart';
import 'package:car_loan_project/views/search.dart';
import 'package:car_loan_project/views/upload.dart';
import 'package:car_loan_project/views/userprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.orange,
      ),
      home:  HomePage(),
      routes: {
        loginRoutes: (context) => const LoginView(),
        registerRoutes: (context) => const RegisterView(),
        notesRoutes: (context) => const NotesView(),
         verifyRoutes: (context) =>  Upload(),
         homeRoutes:(context) => const HomePage(),
       //   NavBarRoutes: (context) =>  NavBar(),
            search: (context) =>  SearchProduct(),
         
      
      } ,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
   
    return FutureBuilder(
        future: AuthService.firebase().intialize(),
        builder:   (context, snapshot) {
          switch (snapshot.connectionState) {
            
            case ConnectionState.done:
            final user =  AuthService.firebase().currentUser;
          
            if (user != null){
               if (user.isEmailVerified == false){
                return const LoginView();
               }
             else {
               return const NotesView();
            }} else {
               return const NotesView();
            }
            
        default: 
        return Container(
         //   constraints: const BoxConstraints.expand(),
         height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('imagess/home~2.jpg'), 
            fit: BoxFit.cover)),
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Image(image: AssetImage('imagess/home~2.jpg'),fit: BoxFit.cover,)
              ],
            ),
          ),
        );
          }
          
        },
      );
  }
  }

 
 class UserInformation extends StatefulWidget {
  @override
    UserInformationState createState() => UserInformationState();
}

class UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot<Object?>?> usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: usersStream,
      builder: (BuildContext? context, AsyncSnapshot<QuerySnapshot<Object?>?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String?, dynamic> data = document.data()! as Map<String?, dynamic>;
            return ListTile(
              title: Text(data['first_name']),
              subtitle: Text(data['first_name']),
            );
          }).toList(),
        );
      },
    );
  }
}


  Loans() async{
     QuerySnapshot snapshot=await FirebaseFirestore.instance
        .collection('Loans')
        .where("Query", isEqualTo: "interest").get();
         snapshot.docs.forEach((doc) async { 
          log('${doc.id}');
        var collection = FirebaseFirestore.instance.collection('Loans');
          var docSnapshot = await collection.doc('${doc.id}').get();
          if (docSnapshot.exists) {
            Map<String, dynamic>? data = docSnapshot.data();
             final n = int.parse(data?['NumberOfMonths']??1);
             final IntialCompanyInterest=data?['Company Interest']??1;
             final rate = int.parse(data?['rate']??1)/100;
              final DateTime now = DateTime. now();
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
            final  formatted = formatter. format(now);
            final values = data?['Date Taken']; 
            final sellerId=data?['selleremail'];
            log('${formatted}');
            if (formatted == values){
               final balance = int.parse(data?['Balance']??0); 
               if (balance > 0){
             if(n >0){
                         final interest = balance*rate;
                         final companyInterest= (interest*0.2)+IntialCompanyInterest;
          var userupdate = await FirebaseFirestore.instance.collection('users').doc('${sellerId}');
                            var car= await userupdate.get();
                               if (car.exists) {
            Map<String, dynamic>? comp = car.data();
            final k = comp?['Pending']??0;
            final pending=(interest*0.8) + k;
           
             await userupdate.update({'Pending':pending});
            }

    final updateBalance = interest + balance;
   final today = DateTime.now();
   final NextBillingDate = today.add(const Duration(days: 31));
   final FormattedNextBillingDate= formatter.format(NextBillingDate);
    final updateMonthlyFee = (balance/n)+(interest);
   final updateMonth = n - 1 ;
     final loan =  FirebaseFirestore.instance.collection('Loans').doc('${doc.id}');                 
       loan.update({'Balance': double.parse((updateBalance). toStringAsFixed(1)).ceil().toString()});
        loan.update({'MonthlyFee': double.parse((updateMonthlyFee). toStringAsFixed(1)).ceil().toString()});
        loan.update({'NumberOfMonths': double.parse((updateMonth). toStringAsFixed(1)).ceil().toString()});
        loan.update({'Date Taken': FormattedNextBillingDate});
        loan.update({'Company Interest': double.parse((companyInterest). toStringAsFixed(1)).ceil()});
         log('$balance');
            }}}
            // <-- The value you want to retrieve. 
  // Call setState if needed.
}                      
                            }); 
    
}