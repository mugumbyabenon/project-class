import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class Buy extends StatefulWidget {
  final advertpk;
  Buy(this.advertpk);

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  late final TextEditingController _name;
    late final TextEditingController _occupation;
     late final TextEditingController _nin;
      late final TextEditingController _location;
       late final TextEditingController _payment;
        late final TextEditingController _phonenumber;
         late final TextEditingController _email;

         
  @override
  void initState() {
    _name = TextEditingController();
     _occupation = TextEditingController();
      _nin = TextEditingController();
       _location = TextEditingController();
        _payment = TextEditingController();
         _phonenumber = TextEditingController();
          _email = TextEditingController();
           super.initState();
    }
     @override
  void dispose() {
     _occupation.dispose();
      _name.dispose();
       _nin.dispose();
        _location.dispose();
         _payment.dispose();
          _phonenumber.dispose();
         _email.dispose();
       super.dispose();
  }
 String? delivery;
     String? message;
     bool gg = false;
  @override
  Widget build(BuildContext context) {
   
     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
       User? user = FirebaseAuth.instance.currentUser;
        if (user != null) { 
       String? emails = user.email;
    String? uid = user.uid;
     String? username = user.displayName;
     final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('Adverts')
        .where("pk", isEqualTo: "${widget.advertpk}")
        .snapshots(includeMetadataChanges: true); 
         void deliveryStatus(String? selectedValue){
     if (selectedValue is String){
        setState(() {
          delivery = selectedValue;
        }
        );
        }
    if (delivery ==  'Ship to location'){
        setState(() {
          message = '**Delivery may lead to addittional fees';
          gg=  true;
        }
        );
    } else{
       setState(() {
          message = '';
           gg=  false;
        }
        );
    }
  }  

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Purchase',style: TextStyle(color: Colors.white),)),
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
             
               TextFormField(
               controller: _phonenumber,
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(
                  ),
                  filled: true,
                  icon: const Icon(
                  Icons.phone_callback,
                  size: 40.0,
                  ),
                  hintText: '07xxxxxxxx',
                  labelText: 'Phone Number',
                ),
               
                keyboardType: TextInputType.number,
               
              ),SizedBox(height: 20,),  TextFormField(
               controller: _name,
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(
                  ),
                  filled: true,
                  icon: const Icon(
                  Icons.price_check_sharp,
                  size: 40.0,
                  ),
                  hintText: 'Price',
                  labelText: 'Price you want to offer',
                ),
               
                keyboardType: TextInputType.number,
               
              ),SizedBox(height: 20,),
            const   SizedBox(
                height: 20.0,
              ),
               Container(
                alignment: Alignment.center,
              
              ),Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Product Price', style: TextStyle(
                                               // color: Colors.amberAccent[200],
                                                letterSpacing: 2.2,
                                                fontSize: 20.0,
                                               // fontWeight: FontWeight.bold,
                                              ),),SizedBox(width: 30,),
                  Expanded(
                    child: Text('${myFormat.format(data?['Price']??"")}',
                    style: TextStyle(
                                               // color: Colors.amberAccent[200],
                                                letterSpacing: 2.2,
                                                fontSize: 20.0,
                                               // fontWeight: FontWeight.bold,
                                              ),),
                  ),
                ],
              ),SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Store Location       ${data?['Location']??""}',
                  style: TextStyle(
                                             // color: Colors.amberAccent[200],
                                              letterSpacing: 2.2,
                                              fontSize: 20.0,
                                             // fontWeight: FontWeight.bold,
                                            ),),
                ],
              ),SizedBox(height: 10,),
            Row(children: [
                          const  Padding(
                              padding:  EdgeInsets.all(.0),
                              child: Expanded(
                                child: Text('Delivery/Pickup',style: TextStyle(
                                             // color: Colors.amberAccent[200],
                                              letterSpacing: 2.2,
                                              fontSize: 20.0,
                                             // fontWeight: FontWeight.bold,
                                            ),),
                              ),
                            ),SizedBox(width: 40,),DropdownButton(items: const[
                              DropdownMenuItem(child: Text('Delivery',style: TextStyle(fontSize: 20,color: Colors.orange)),value: 'Ship to location',),
                               DropdownMenuItem(child: Text('Pick Up',style: TextStyle(fontSize: 20,color: Colors.orange)),value: 'Pick Up from Bond',),
                            ],value: delivery, onChanged: deliveryStatus)
                          ],),SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Visibility(
                visible: gg,
                child: TextFormField(
                 controller: _location,
                  decoration:  InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(
                    Icons.delivery_dining,
                    size: 40.0,
                    ),
                    hintText: 'Choose names of notable nearby places',
                    labelText: 'Delivery Location',
                  ),
                ),
              ),
               SizedBox(
                height: 30.0,
              ),              
                          ElevatedButton(onPressed: () async{
                            final pk=DateTime.now().toString()+widget.advertpk+uid;
                            CollectionReference collection = await FirebaseFirestore.instance.collection('Purchase Requests');
                            final lowestoffer = data?['Price']*0.78;
                             try{
                            final priceoffered=int.parse(_name.text);
                           if(priceoffered >=lowestoffer){
                            try{
                            collection.doc('$pk').set({
                              'phone number':int.parse(_phonenumber.text).toString(),
                              'price offered':int.parse(_name.text),
                              'Product price':data?['Price']??0,
                              'delivery options':delivery,
                              'pk':pk,
                              'sellerpk':data?['user']??'',
                              'delivery location':_location.text.trim()??null,
                              'buyer name':username,
                              'product name':'${data?['Car Name']??''  }',
                            });
                            await PurchaseRequest(context, 'Your purchase request has been submmitted.\n You will get feedback shortly');
                            } catch (e){
                              throw showErrorDialog(context, '$e');
                            }
                           }else{
                            await showErrorDialog(context, 'The price your offering is too low,\n please offer a price above ${
                              double. parse((lowestoffer). toStringAsFixed(1)).ceil()
                            }');
                           }} catch (e){
                            throw showErrorDialog(context, '$e');
                           }
                          }, child: Text('Send Purchase Request'))
               
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
      throw showErrorDialog(context, 'An error occured,Try again later');
    }
  }
}