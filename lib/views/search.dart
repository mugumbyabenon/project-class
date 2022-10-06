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

class AdvertDetails extends StatefulWidget {
    final String  myParam;
    final   price;
      final   carname;
      final   image;
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
     
   // String? username = user.displayName;
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
                      User? user = FirebaseAuth.instance.currentUser;
                           if (user != null) {
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  RequestLoan(widget.price??0,widget.carname,widget.image)),
            );} else {
             ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('Please login inorder to apply for loan')));    
            }
                    
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
                          Text(data?['Car Name']??"",style: GoogleFonts.bebasNeue(fontSize: 40),),SizedBox(width: 10,),
                          Text(data?['Car Model']??"",style: GoogleFonts.bebasNeue(
                        fontSize: 40,
                                          ),),
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
              MaterialPageRoute(builder: (context) =>  AdvertDetails(widget.myParam,widget.price,widget.carname,widget.image)),
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




