import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:car_loan_project/views/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyAdverts extends StatefulWidget {
  const MyAdverts({super.key});

  @override
  State<MyAdverts> createState() => _MyAdvertsState();
}

class _MyAdvertsState extends State<MyAdverts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Adverts ',style: TextStyle(color: Colors.white),),
        leading: BackButton(color: Colors.orange),
        backgroundColor: Colors.black,
      ),
      body: MyAdv(),);
  }
}
class MyAdv extends StatefulWidget {
  const MyAdv({super.key});

  @override
  State<MyAdv> createState() => _MyAdvState();
}

class _MyAdvState extends State<MyAdv> {
  @override
  Widget build(BuildContext context) {
      NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    User? user = FirebaseAuth.instance.currentUser;
    if (user!=null){
      String? uid = user.uid;
    return StreamBuilder<QuerySnapshot>(
      stream:  FirebaseFirestore.instance
        .collection('Adverts')
        .where("user", isEqualTo: "$uid")
        .snapshots(includeMetadataChanges: true),
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
                  children: [ Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [Image.network('${data?['imageUrl']??""}',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,),
                    Image.network('${data?['imageUrl1']??"${data?['imageUrl']??""}"}',
                     width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,),Image.network('${data?['imageUrl2']??"${data?['imageUrl']??""}"}',
                       width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,),
                    Image.network('${data?['imageUrl3']??"${data?['imageUrl']??""}"}',
                     width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,)
                    ]),
                    
                  ),SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                 Padding(
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
                            Icon(Icons.sell_outlined,color:Colors.orange,size: MediaQuery.of(context).size.width*0.08,),Expanded(child: Text(data?['Used or Brand New']??"",style: GoogleFonts.bebasNeue(fontSize: 15),)),
                            SizedBox(width: MediaQuery.of(context).size.height * 0.2,),
                            Icon(Icons.location_city,color:Colors.orange,size: MediaQuery.of(context).size.width*0.08,),Expanded(child: Text(data?['Location']??"",style: GoogleFonts.bebasNeue(fontSize: 15),)),
                            
                          ],
                        )
                                      ],
                                    ),
                    
                                    
                            ),ElevatedButton(onPressed: () async{
                       final collection = FirebaseFirestore.instance.collection('Adverts').doc('${data?['pk']??""}');
                    await   collection.delete();       
                            }, child: Text('Delete'))
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
            Text('You have no Adverts \n Create your first Advert today',style: TextStyle(fontSize: 15),),
            ElevatedButton(onPressed: (){
               Navigator.push(context,
                MaterialPageRoute(builder: (context) => Upload()),);
            }, child: Text('Post Advert'))
          ],
        ));
        
      },


    );
    
     } else {throw showErrorDialog(context, 'An error occured');}
    }
  }
