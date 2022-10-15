import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:car_loan_project/views/admin.dart';
import 'package:car_loan_project/views/buy.dart';
//import 'package:car_loan_project/views/categories.dart';
import 'package:car_loan_project/views/loan.dart';
import 'package:car_loan_project/views/login_view.dart';
import 'package:car_loan_project/views/payments.dart';
import 'package:car_loan_project/views/wallet.dart';
import 'package:intl/intl.dart';
import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:car_loan_project/views/billing.dart';
//import 'package:car_loan_project/views/postadvert.dart';
import 'package:car_loan_project/views/upload.dart';
import 'package:car_loan_project/views/userprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_launch/flutter_launch.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../constants/routes.dart';
import '../enums/menu_action.dart';
import '../services/auth/auth_service.dart';
import 'dealerDetails.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
       
  int currentIndex = 0;
   
  List<Widget> screens = [
     HomeInterface(),Upload(),Wallet(), UserProfile()
  ];
   List<Widget> admin = [
     HomeInterface(),ApprovalLoan(),UserProfile()
  ];



   void _onItemTapped(int index){
    setState(() {
      currentIndex = index;
    });
   }
  @override
  Widget build(BuildContext context) {
      User? user = FirebaseAuth.instance.currentUser;
           if (user != null) {
                          String? username = user.displayName; // <-- User ID
                          String? emails = user.email;
                          log('$user'); 
            if (username == 'Benon') {            
    
    return Scaffold(  
       bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height*0.1,
         child: Container(
                        decoration: BoxDecoration(                                                   
                    borderRadius: BorderRadius.only(                                           
                      topRight: Radius.circular(30), topLeft: Radius.circular(30)),            
                    boxShadow: [                                                               
                      BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 10),       
                    ],                                                                         
                  ),       
           child: ClipRRect(
                      borderRadius: BorderRadius.only(                                           
                topLeft: Radius.circular(30.0),                                            
                topRight: Radius.circular(30.0),                                           
                ),       
             child: BottomNavigationBar(
                 currentIndex: currentIndex,
                 items: const [
                 BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home',),
                 BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings),label: 'Admin',),
             BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile',)
               ],type: BottomNavigationBarType.fixed,
                onTap: _onItemTapped,
               ),
           ),
         ),
       ),
      resizeToAvoidBottomInset:false,
       body: admin.elementAt(currentIndex),
    );
    } else{
          return Scaffold(  
       bottomNavigationBar: Container(
                      decoration: BoxDecoration(                                                   
                  borderRadius: BorderRadius.only(                                           
                    topRight: Radius.circular(30), topLeft: Radius.circular(30)),            
                  boxShadow: [                                                               
                    BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 10),       
                  ],                                                                         
                ),       
         child: ClipRRect(
                    borderRadius: BorderRadius.only(                                           
              topLeft: Radius.circular(30.0),                                            
              topRight: Radius.circular(30.0),                                           
              ),       
           child: BottomNavigationBar(
               currentIndex: currentIndex,
               items: const [
               BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
               BottomNavigationBarItem(icon: Icon(Icons.add_card),label: 'Sell',),
               BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet),label: 'Wallet',),
           BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile',)
             ],type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
             ),
         ),
       ),
      resizeToAvoidBottomInset:false,
       body: screens.elementAt(currentIndex),
    );
    }
    } else {
      return Scaffold(  
       bottomNavigationBar: Container(
                      decoration: BoxDecoration(                                                   
                  borderRadius: BorderRadius.only(                                           
                    topRight: Radius.circular(30), topLeft: Radius.circular(30)),            
                  boxShadow: [                                                               
                    BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 10),       
                  ],                                                                         
                ),       
         child: ClipRRect(
                    borderRadius: BorderRadius.only(                                           
              topLeft: Radius.circular(30.0),                                            
              topRight: Radius.circular(30.0),                                           
              ),       
           child: BottomNavigationBar(
               currentIndex: currentIndex,
               items: const [
               BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
               BottomNavigationBarItem(icon: Icon(Icons.add_card),label: 'Sell',),
               BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet),label: 'Wallet',),
           BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile',)
             ],type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
             ),
         ),
       ),
      resizeToAvoidBottomInset:false,
       body: screens.elementAt(currentIndex),
    );
    }
  }
}

class HomeInterface extends StatefulWidget {
  const HomeInterface({super.key});

  @override
  State<HomeInterface> createState() => _HomeInterfaceState();
}

class _HomeInterfaceState extends State<HomeInterface> {
  
  @override
  Widget build(BuildContext context)  {
     User? user = FirebaseAuth.instance.currentUser;
           if (user != null) {
                          String? username = user.displayName??''; // <-- User ID
                        
                           
    return Scaffold(
      
      appBar: AppBar(
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Expanded(
              child: Center(
                child: Text('Hello $username',style: TextStyle(
                  color: Colors.white
                ),
                ),
              ),
            ), SizedBox(width: MediaQuery.of(context).size.width*0.3,),IconButton(color: Colors.orange, onPressed: (){
               Navigator.of(context).pushNamed(search);
            }, icon: Icon(Icons.search))
            ],
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [ Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              PopupMenuButton <MenuAction>(iconSize:  MediaQuery.of(context).size.width*0.08,icon: Icon(Icons.format_list_bulleted),
                onSelected: ((value) async {
                  switch (value){
                    case MenuAction.cars:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Cars', 'Category')),
            );break;
                   case MenuAction.motorcycle:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Motorcycles', 'Category')),
            );break;
             case MenuAction.rental:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Rentals', 'Category')),
            );break;
             case MenuAction.spareparts:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Spareparts', 'Category')),
            );break;
              case MenuAction.loans:
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Request Loan/Buy', 'button')),
            );
            break;    
                  }
                }),
                itemBuilder: (context) {
                  return [ 
                    const PopupMenuItem(
                      value: MenuAction.loans,
                      child: Text('Loan Products'),
                      ),
                    const PopupMenuItem(
                      value: MenuAction.cars,
                      child: Text('Cars'),
                      ),  const PopupMenuItem(
                      value: MenuAction.motorcycle,
                      child: Text('Motorcycle'),
                      ),const PopupMenuItem(
                      value: MenuAction.rental,
                      child: Text('Rental'),
                      ),const PopupMenuItem(
                      value: MenuAction.spareparts,
                      child: Text('SpareParts'),
                      ),
                  ];
                },
               ),
            ],
          ),
            UserInformations('all','all'),
          ],
        ),
      ),
    );
    } else{
      return Scaffold(
      
      appBar: AppBar(
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Expanded(
              child: Center(
                child: Text('Welcome',style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ), SizedBox(width: MediaQuery.of(context).size.width*0.3,),IconButton(color: Colors.orange, onPressed: (){
               Navigator.of(context).pushNamed(search);
            }, icon: Icon(Icons.search))
            ],
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [ Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              PopupMenuButton <MenuAction>(iconSize:  MediaQuery.of(context).size.width*0.08,icon: Icon(Icons.format_list_bulleted),
                onSelected: ((value) async {
                  switch (value){
                    case MenuAction.cars:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Cars', 'Category')),
            );break;
                   case MenuAction.motorcycle:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Motorcycles', 'Category')),
            );break;
             case MenuAction.rental:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Rentals', 'Category')),
            );break;
             case MenuAction.spareparts:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Spareparts', 'Category')),
            );break;
            case MenuAction.loans:
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category('Request Loan/Buy', 'button')),
            );
            break;
                 
                  }
                }),
                itemBuilder: (context) {
                  return [ 
                    const PopupMenuItem(
                      value: MenuAction.loans,
                      child: Text('Loan Product'),
                      ),
                    const PopupMenuItem(   
                      value: MenuAction.cars,
                      child: Text('Cars'),
                      ),  const PopupMenuItem(
                      value: MenuAction.motorcycle,
                      child: Text('Motorcycle'),
                      ),const PopupMenuItem(
                      value: MenuAction.rental,
                      child: Text('Rental'),
                      ),const PopupMenuItem(
                      value: MenuAction.spareparts,
                      child: Text('SpareParts'),
                      ),
                  ];
                },
               ),
            ],
          ),
            UserInformations('all','all'),
          ],
        ),
      ),
    );
    }

  }}
class Category extends StatefulWidget {
  final param;
  final query;
  Category(this.param,this.query);
  //const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.orange),
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0.0,
        title: Center(child: Text('${widget.param}',style: TextStyle(color: Colors.white),)),),
      body: UserInformations(widget.param, widget.query),
    );
  }
}


 
 class UserInformations extends StatefulWidget {
  final param;
  final query;
  UserInformations(this.param,this.query);
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformations> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Adverts').snapshots();
      late final TextEditingController _search;
  
  @override
  Widget build(BuildContext context) {
     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
     Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('Adverts')
        .where("${widget.query}", isEqualTo: "${widget.param}")
        .snapshots(includeMetadataChanges: true);
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        } 
         if (snapshot.connectionState == ConnectionState.none) {
          return Center(child: CircularProgressIndicator(),);
        } 
        
      try{
        return SizedBox(
          height: MediaQuery.of(context).size.height*1.5,
          child: ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return SizedBox(
                    child: ListTile(
                      title: Container(
                         width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 223, 220, 220),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color.fromARGB(255, 136, 134, 134),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                      NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
                      final sellerid  = data?['Price'];
                       String imageUrl = data?['pk']??"";
                        String image = data?['imageUrl']??"";
                        String id = data?['user']??"";
                       String carname = '${data?['Car Name']??""} ${data?['Car Model']??""}';
                        User? user = FirebaseAuth.instance.currentUser;
             
                     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AdvertDetails(imageUrl,sellerid,carname,image,
                '${data?['button']??""}',id,data?['email']??"",data?['rate']??"0",data?['pk']??"0")),
              );
                            //    showDialog (
                              //        context: context,
                                //      builder: (_) => AdvertProfile(imageUrl,sellerid));
                               //  showErrorDialog(context, '${data?['Car Name']??""}');
                                     //  ImageDialog(imageUrl);
                                // AdvertProfile(imageUrl);
                              },
                              child:SizedBox(
                                    height: 250,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [Image.network(
                                                    data?['imageUrl']??"",
                                                    width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.4,
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
                            ),SizedBox(width: 0,),Padding(
                              padding: const EdgeInsets.symmetric(horizontal:3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                        Text(data?['Car Name']??"",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),Text(data?['Car Model']??"",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),Text(data?['description']??"",style: GoogleFonts.poppins(fontSize: 20),softWrap: true),
                        Row(
                          children: [
                           Text('Shs.${myFormat.format(data?['Price']??0)}',style: GoogleFonts.bebasNeue(fontSize: 40),),
                          ],
                        ),Row(
                          children: [
                            Icon(Icons.sell_outlined,color:Colors.orange,size: MediaQuery.of(context).size.width*0.08,),Text(data?['Used or Brand New']??"",style: GoogleFonts.bebasNeue(fontSize: 15),),
                            SizedBox(width: MediaQuery.of(context).size.height * 0.2,),
                            Icon(Icons.location_city,color:Colors.orange,size: MediaQuery.of(context).size.width*0.08,),Text(data?['Location']??"",style: GoogleFonts.bebasNeue(fontSize: 15),),
                            
                          ],
                        )
                                      ],
                                    ),
                    
                                    
                            ),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                     // subtitle: Text(data?['Car Model']??''),
                    ),
                  );
                })
                .toList()
                .cast(),
          ),
        );} catch (e){
          throw showErrorDialog(context, '$e');
        }
      },
    );


  }
}


class AdvertDetails extends StatefulWidget {
    final String  myParam;
    final   price;
      final   carname;
      final   image;
       final   category;
        final   sellerid;
         final   email;
         final rate;
         final advertpk;
     //   final   categor;
  AdvertDetails(this.myParam,this.price,this.carname,this.image,this.category,this.sellerid,this.email,this.rate,this.advertpk);

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
     
   // String? username = user.displayName;
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Adverts')
        .where("pk", isEqualTo: "${widget.myParam}")
        .snapshots(includeMetadataChanges: true);
    return StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: const Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
          User? user = FirebaseAuth.instance.currentUser;
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
                  ),ElevatedButton(onPressed: () async{
                      User? user = FirebaseAuth.instance.currentUser;
                           if (user != null) {
                            if (widget.category == 'Request Loan/Buy') {
                     
                    await    BuyLoan(context, widget.price, widget.carname, widget.image, widget.sellerid, widget.email,widget.rate,widget.advertpk);
            } else {
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Buy(widget.advertpk)),
            );
           //    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('This feature is currently not availble. Please wait for final product')));
            }
            } else {
             ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('Please login inorder to apply for loan')));    
            }
                    
                  }, child: Text('${widget.category??'Buy'}'))
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
                          Expanded(child: Text('${data?['Car Name']??""}  ${data?['Car Model']??""}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),SizedBox(width: 10,),
                        
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
                                      User? user = FirebaseAuth.instance.currentUser;
                           if (user != null) {
                               String? username = user.displayName;
                                    CollectionReference comments = FirebaseFirestore.instance.collection('Comments');
                                  await  comments.add({
                                      'comment':_comment.text.trim(),
                                      'username':username,
                                      'image':user.photoURL,
                                      'primarykey':data?['pk']??"",
                                    });
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AdvertDetails(widget.myParam,widget.price,
              widget.carname,widget.image,widget.category,widget.sellerid,widget.email,widget.rate,widget.advertpk)),
            );                     
                                    } else{
                                      log('no');
     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('Please login inorder to write your comment')));                                 
                        
                                    }
                                  }, 
                                  child: Text('Comment'))
                                ],
                              ),
                                    ],
                                  ),Comments('${data?['pk']??""}')??Text('No ratings')
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
        );
        
      },


    ); 
    
    
   

  }
}


