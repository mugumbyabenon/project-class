import 'dart:developer';
import 'dart:io';

import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:car_loan_project/views/dealerDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../constants/routes.dart';
import '../enums/menu_action.dart';
import '../services/auth/auth_service.dart';
import 'loan.dart';
import 'login_view.dart';
import 'notes_view.dart';
import 'payments.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0.0,
        title: Center(child: Text('Loan Repayment',style: TextStyle(color: Colors.white),)),
      ),
      body: LoanView(),
    );
  }
}

class LoanView extends StatefulWidget {
  const LoanView({super.key});

  @override
  State<LoanView> createState() => _LoanViewState();
}

class _LoanViewState extends State<LoanView> {
  
 @override
  Widget build(BuildContext context) {
    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
       NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
      String? buttonValue;
    String? emails = user.email;
    String? uid = user.uid;
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Loans')
        .where("uid", isEqualTo: "${uid}")
        .snapshots(includeMetadataChanges: true);
        
    return StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          
          User? user = FirebaseAuth.instance.currentUser;
           if (user != null) {
                          String uid = user.uid; // <-- User ID
                          String? emails = user.email;
                          log('$user'); 
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
                              children: [Text('Monthly Fee',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                Expanded(
                                  child: Text('Shs.${myFormat.format(int.parse(data?['MonthlyFee']??""))}',style: TextStyle(
                                  fontSize: 20),),
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('Payment Period',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                Expanded(
                                  child: Text('${data?['PaymentPeriod']??""}',style: TextStyle(
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text('${data?['Deposit_Button']??"Pending Balance"}',style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 16),),SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                    Expanded(
                                      child: Text('Shs.${myFormat.format(int.parse(data?['Intial Deposit']??"${data?['Balance']??0}"))}',style: TextStyle(
                                      fontSize: 20),),
                                    ),
                                  ],
                                ),
                              ],
                            ),SizedBox(height: MediaQuery.of(context).size.height*0.01),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text('${data?['Acquistion']??"Amount Paid"}',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),),SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                Expanded(
                                  child: Text('${data?['delivery']??"${myFormat.format(int.parse(data?['Paid Money']??""))}"}',style: TextStyle(
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
                           ElevatedButton(onPressed: ()async{
                            if (data?['button'] == null){
                               log('null');
                               final balance = int.parse(data?['Balance']??0);
                               final paid = int.parse(data?['Paid Money']??0);
                        if (balance <= 0){
                           await  FirebaseFirestore.instance.collection('Loans').doc(uid).delete();
                        }   else {    
                    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MakePayment(title: Strings.appName,balance: balance ,pk: data?['uid']??'0',
                paid: paid,)),
              );       }        
                            } else{
                              log('hey hey');
                              await  FirebaseFirestore.instance.collection('Loans').doc(uid).delete();
                            }
                           }, child: Text('${data?['button']??"Make Payment"}'))
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
        } AlertDialog(
        title:  const Text('Join our Family Today '),
          content: Text('Reach Out to thousands of customers or obtain unsecured loans'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
            }
            , child: const Text('Login/SignUp'))
          ],
    );
        
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        
       return Column(
         children: [Icon(Icons.car_rental,size: MediaQuery.of(context).size.height*0.4,),Text('You currently have no pending.\nApply for a loan today from our products below\n',
         style: TextStyle(fontSize: 15),),
           Expanded(
             child: StreamBuilder<QuerySnapshot>(
                 stream:  FirebaseFirestore.instance
        .collection('Adverts')
        .where("button", isEqualTo: "Request Loan")
        .snapshots(includeMetadataChanges: true),
                 builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                
                User? user = FirebaseAuth.instance.currentUser;
                 if (user != null) {
                                String uid = user.uid; // <-- User ID
                                String? emails = user.email;
                                log(uid); 
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                 // scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ListTile(
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [ CircleAvatar(
                                  radius: MediaQuery.of(context).size.height*0.05,
                                  backgroundImage: NetworkImage('${data?['imageUrl']??""}'),
                                ),SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                Expanded(
                                  child: Text('${data?['Car Name']??""} ${data?['Car Model']??""}',  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context).size.width*0.05,
                                              letterSpacing: 1.0,
                                            ),),
                                ),ElevatedButton(onPressed: (){
                                   final sellerid  = data?['Price'];
                         String imageUrl = data?['pk']??"";
                           String image = data?['imageUrl']??"";
                         String carname = '${data?['Car Name']??""} ${data?['Car Model']??""}';
                       Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AdvertDetails(imageUrl,sellerid,carname,image)),
                  );
                                }, child: Text('Loan'))
                                ],
                              ),
                            ],
                          ),
                        );
                      })
                      .toList()
                      .cast(),
                ),
              );} throw FirebaseAuthException(code: 'An Error Occurred');
              
              }
           
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              return Text('Lets go oti bwoti');
                 }),

           ),
         ],
       );
        
      },


    ); 
    
    
    }  else{
       return AlertDialog(
          title:  const Text('Join our Family Today '),
          content: Text('Pay Loans seamlessly with our user friendly interface at the lowest rates'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
            }
            , child: const Text('Login/SignUp'))
          ],
        );
    }


 }}

class ApplyForLoan extends StatefulWidget {
  final String myParam;
  ApplyForLoan(this.myParam);
 // const ApplyForLoan({super.key});

  @override
  State<ApplyForLoan> createState() => _ApplyForLoanState();
}

class _ApplyForLoanState extends State<ApplyForLoan> {
 String? image;
  String? product='cars';

  @override
  Widget build(BuildContext context) {
  
  return Text('$product');
  
  }
  
}


class AdvertDetails extends StatefulWidget {
    final String  myParam;
    final   price;
    final   carname;
    final image;
  AdvertDetails(this.myParam,this.price,this.carname,this.image);

  @override
  State<AdvertDetails> createState() => _AdvertDetailsState();
}

class _AdvertDetailsState extends State<AdvertDetails> {
   late final TextEditingController _comment;
     @override
  void initState() {
    _comment = TextEditingController();
    super.initState();}
     @override
  void dispose() {
    _comment.dispose();
    super.dispose();}
 // AdvertDetails(this.myParam);
  @override
  Widget build(BuildContext context) {
     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
      User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
    String? username = user.displayName;
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Adverts')
        .where("pk", isEqualTo: "${widget.myParam}")
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
        return Scaffold(
          appBar: AppBar(
             leading: BackButton(color: Colors.orange),
             backgroundColor: Colors.white,
          ),
            bottomNavigationBar: Container(
                      
         child: ClipRRect(
                    borderRadius: BorderRadius.only(                                           
              topLeft: Radius.circular(30.0),                                            
              topRight: Radius.circular(30.0),                                           
              ),       
           child: Container(
            
            height: MediaQuery.of(context).size.height*0.13,
              decoration: BoxDecoration(                                                   
                  borderRadius: BorderRadius.only(                                           
                    topRight: Radius.circular(30), topLeft: Radius.circular(30)),            
                  boxShadow: [                                                               
                    BoxShadow(color: Color.fromRGBO(255, 250, 250, 1), spreadRadius: 0, blurRadius: 0),       
                  ],                                                                         
                ),     
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text('Shs.${myFormat.format(widget.price)}',style: GoogleFonts.bebasNeue(fontSize: 35))),SizedBox(
                    width: MediaQuery.of(context).size.width*0.12,
                  ),ElevatedButton(onPressed: (){
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  RequestLoan(widget.price??0,widget.carname,widget.image)),
            );
                    
                  }, child: Text('Request Loan'))
                ],
              ),
            ),
           ),
         ),
       ),
      resizeToAvoidBottomInset:false,
          body: ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Container(
                        width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 229, 226, 226),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.white,
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                           GestureDetector(
                              child: SizedBox(
                                height: 300,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [Image.network(
                                                data?['imageUrl']??"",
                                                width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.7,
                                                fit: BoxFit.cover
                                              ),Image.network(
                                                data?['imageUrl1']??'${data?['imageUrl']}',
                                                width:  MediaQuery.of(context).size.width,height: 300,
                                                fit: BoxFit.cover
                                              ),Image.network(
                                                data?['imageUrl2']??'${data?['imageUrl']}',
                                                width:  MediaQuery.of(context).size.width,height: 300,
                                                fit: BoxFit.cover
                                              ),Image.network(
                                                data?['imageUrl3']??'${data?['imageUrl']}',
                                                width:  MediaQuery.of(context).size.width,height: 300,
                                                fit: BoxFit.cover
                                              ),
                                              ]
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                             Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_city,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '${data?['Location']??""}',
                                        style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        letterSpacing: 1.0,
                                        ),
                                      )
                                    ],
                                  ),
                        ],
                                          ),
                                          Row(
                        children: [
                       Expanded(child: Text('${data?['Car Name']??""}  ${data?['Car Model']??""}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
                        ],
                                          ),
                                          
                                          Text(data?['description']??"",style: GoogleFonts.poppins(fontSize: 20),softWrap: true),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                                     
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                                         Text('Dealer Details',style: GoogleFonts.poppins(fontSize: 20,color: Colors.orange)),
                                         DealerDetails('${data?['email']??""}','${data?['Used or Brand New']??""}'),
                                         SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Text('Product Ratings & Reviews',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                               SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Row(
                                children: [
                                  SizedBox(width:MediaQuery.of(context).size.width * 0.7,
                                  child: TextField(
                             controller: _comment,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            obscureText: false,
                            enableSuggestions: true,
                            decoration:  InputDecoration(
                              hintText: 'Write your comment here',
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                                  )),SizedBox(width: 5,),
                                  ElevatedButton(onPressed: () async{
                                    CollectionReference comments = FirebaseFirestore.instance.collection('Comments');
                                  await  comments.add({
                                      'comment':_comment.text.trim(),
                                      'username':username,
                                      'image':user.photoURL,
                                      'primarykey':data?['imageUrl']??"",
                                    });
                                  }, 
                                  child: Text('Comment'))
                                ],
                              ),
                                    ],
                                  ),Comments('${data?['imageUrl']??""}')??Text('No ratings')
                          ],
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                   // subtitle: Text(data?['Car Model']??''),
                  );
                })
                .toList()
                .cast(),
          ),
        );} throw FirebaseAuthException(code: 'An Error Occurred');
        
      },


    ); 
    
    
    } return AlertDialog(
        title:  const Text('Join our Family Today '),
          content: Text('Reach Out to thousands of customers or obtain unsecured loans'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
            }
            , child: const Text('Login/SignUp'))
          ],
    );

  }
}


