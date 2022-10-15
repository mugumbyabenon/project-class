import 'dart:developer';

import 'package:car_loan_project/utilities/showErrorDialog.dart';
import 'package:car_loan_project/views/notes_view.dart';
import 'package:car_loan_project/views/payments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RequestLoan extends StatefulWidget {
  final price;
  final carname;
  final image;
   final pk;
   final email;
   final rate;
   final advertpk;
  RequestLoan(this.price,this.carname,this.image,this.pk,this.email,this.rate,this.advertpk);
 // const RequestLoan({super.key});

  @override
  State<RequestLoan> createState() => _RequestLoanState();
}

class _RequestLoanState extends State<RequestLoan> {
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

  String? period;
   String? Intial;
  String? payment;
  String? delivery;
  String? viewfee;
   String? TotalToPay;
    int? NumberOfMonths;
    String? message;
  String? monthlyfee;
  String? interest;
  String? IntialDeposit;
  @override
  Widget build(BuildContext context) {
     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  void deliveryStatus(String? selectedValue){
     if (selectedValue is String){
        setState(() {
          delivery = selectedValue;
        }
        );
        }
    if (delivery ==  'Delivery'){
        setState(() {
          message = '**Delivery may lead to addittional fees';
        }
        );
    } else{
       setState(() {
          message = '';
        }
        );
    }
  }  
 
  Future dropdownCallback(String? selectedValue) async{
      if (selectedValue is String){
        final intial =widget.price*0.35;
        setState(() {
          period = selectedValue;
          Intial =myFormat.format(double. parse((intial). toStringAsFixed(1)).ceil());
        });
        if (period == '3'){
          final IntialDeposits = widget.price*0.35;
            final TotalLoanFee = widget.price-IntialDeposits;
            final monthlyfees = TotalLoanFee /3;
             final profit = (double. parse((monthlyfees). toStringAsFixed(1)).ceil()*3)-widget.price;
              final deposit = double. parse((IntialDeposits). toStringAsFixed(1)).ceil();
            setState(() {
                monthlyfee =double.parse((monthlyfees).toStringAsFixed(1)).ceil().toString();
               interest =profit.toString();
                TotalToPay = widget.price.toString();
                viewfee =myFormat.format(double. parse((monthlyfees). toStringAsFixed(1)).ceil());
                payment = '3 months';
                IntialDeposit = deposit.toString();
                NumberOfMonths =3;
            });
          
            return monthlyfee;
        } if (period == '6'){
           final IntialDeposits = widget.price*0.35;
            final TotalLoanFee = widget.price-IntialDeposits;
            final monthlyfees = TotalLoanFee /6;
             final profit = (double. parse((monthlyfees). toStringAsFixed(1)).ceil()*6)-widget.price;
              final deposit = double. parse((IntialDeposits). toStringAsFixed(1)).ceil();
              
              monthlyfees.round();
            setState(() {
                 monthlyfee =double.parse((monthlyfees). toStringAsFixed(1)).ceil().toString();
               interest =profit.toString();
                TotalToPay = widget.price.toString();
                viewfee =myFormat.format(double. parse((monthlyfees). toStringAsFixed(1)).ceil());
                payment = '6 months';
                 IntialDeposit = deposit.toString();
                 NumberOfMonths =6;
            });
            log('$TotalToPay');
            return monthlyfee;
        } if (period == '12'){
            final IntialDeposits = widget.price*0.35;
            final TotalLoanFee = widget.price-IntialDeposits;
            final monthlyfees = TotalLoanFee /12;
               final profit = (double. parse((monthlyfees). toStringAsFixed(1)).ceil()*12)-widget.price;            
              final deposit = double. parse((IntialDeposits). toStringAsFixed(1)).ceil();
            setState(() {
                monthlyfee =double.parse((monthlyfees). toStringAsFixed(1)).ceil().toString();
               interest =profit.toString();
                TotalToPay = widget.price.toString();
                viewfee =myFormat.format(double. parse((monthlyfees). toStringAsFixed(1)).ceil());
                payment = '1 year';
                 IntialDeposit = deposit.toString();
                 NumberOfMonths =12;
            });
            return monthlyfee;
        } if (period == '24'){
           final IntialDeposits = widget.price*0.35;
            final TotalLoanFee = widget.price-IntialDeposits;
            final monthlyfees = TotalLoanFee /24;
             final profit = (double. parse((monthlyfees). toStringAsFixed(1)).ceil()*24)-widget.price;    
              final deposit = double. parse((IntialDeposits). toStringAsFixed(1)).ceil();
            setState(() {
              monthlyfee =double. parse((monthlyfees). toStringAsFixed(1)).ceil().toString();
               interest =profit.toString();
                TotalToPay = widget.price.toString();
                viewfee =myFormat.format(double. parse((monthlyfees). toStringAsFixed(1)).ceil());
                payment = '2 Years';
                 IntialDeposit = deposit.toString();
                 NumberOfMonths =24;
            });
      
            return monthlyfee;
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.orange),
        backgroundColor: Colors.black,
        title: Center(child: Text('Loan Application Form',style: TextStyle(color: Colors.white),)),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [const   SizedBox(
                height: 20.0,
              ),  TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  border:  UnderlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.person,
                    size: 40.0,
                  ),
                  hintText: 'The names on your National ID',
                  labelText: 'Full Names',
                ),
               
                keyboardType: TextInputType.text,
                
              ),
              const SizedBox(
                height: 20.0,
              ),
               TextFormField(
                 controller: _occupation,
                decoration: const InputDecoration(
                  border:  UnderlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.work,
                    size: 40.0,
                  ),
                  hintText: 'Job Title',
                  labelText: 'Occupation',
                ),
              
                keyboardType: TextInputType.text,
                validator: (String? value) =>
                    value!.isEmpty ? Strings.fieldReq : null,
              ),
              const SizedBox(
                height: 30.0,
              ),
               TextFormField(
                keyboardType: TextInputType.text,
               
                controller: _nin,
                decoration: new InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.card_membership,
                    size: 40.0,
                  ),
                  hintText: '',
                  labelText: 'NIN Number',
                ),
            
             //   validator: CardUtils.validateCardNum,
              ),
              const SizedBox(
                height: 30.0,
              ),
               TextFormField(
               controller: _location,
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.location_city_outlined,
                    size: 40.0,
                  ),
                  hintText: 'Location',
                  labelText: 'Location',
                ),
              ),
               SizedBox(
                height: 30.0,
              ),
               TextFormField(
               controller: _phonenumber,
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.contact_phone,
                    size: 40.0,
                  ),
                  hintText: '07xxxxxxxx',
                  labelText: 'Phone Number',
                ),
               
                keyboardType: TextInputType.number,
               
              ),SizedBox(height: 20,),Row(
                children: [
                  Text('Rate                 ${widget.rate}% per month',style: TextStyle(fontSize: 23),),
                ],
              ),


            const   SizedBox(
                height: 20.0,
              ),
               Container(
                alignment: Alignment.center,
              
              ),
            Text('${message??''}'),Row(children: [
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

                            
              Row(children: [
                            const  Padding(
                                padding:  EdgeInsets.all(.0),
                                child: Text('Payment Period',style: TextStyle(
                   // color: Colors.amberAccent[200],
                    letterSpacing: 2.2,
                    fontSize: 20.0,
                   // fontWeight: FontWeight.bold,
                  ),),
                              ),SizedBox(width: 40,),DropdownButton(items: const[
                                DropdownMenuItem(child: Text('3 months',style: TextStyle(fontSize: 20,color: Colors.orange)),value: '3',),
                                 DropdownMenuItem(child: Text('6 months',style: TextStyle(fontSize: 20,color: Colors.orange)),value: '6',),
                                  DropdownMenuItem(child: Text('1 year',style: TextStyle(fontSize: 20,color: Colors.orange)),value: '12',),
                                   DropdownMenuItem(child: Text('2 years',style: TextStyle(fontSize: 20,color: Colors.orange)),value: '24',)
                              ],value: period, onChanged: dropdownCallback)
                            ],),SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                            Row(
                              children: [
                                Text('Intial Deposit',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),SizedBox(width: MediaQuery.of(context).size.width*0.1),
                                Expanded(child: Text('Shs.${Intial??'0'}',style: TextStyle(fontSize: 20,color: Colors.orange))),
                              ],
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height*0.015,),                     
             ElevatedButton(onPressed: () async{
                                  User? user = FirebaseAuth.instance.currentUser;
                                // Check if the user is signed in
                                if (user != null) {
                                  String uid = user.uid; // <-- User ID
                                  String? emails = user.email;
                                  String? username = user.displayName;
                                  try{
                           final snapShot = await FirebaseFirestore.instance
                                  .collection('Loans')
                                  .doc(uid) // varuId in your case
                                  .get(); 
                 if (snapShot == null || !snapShot.exists) {
                      // docuement is not exist
                                    log('id is not exist');           
                                    final date = DateTime.now();
                                    final pk = DateTime.now().toString();
               final FirebaseAuth _auth = FirebaseAuth.instance;                     
                                CollectionReference loan = FirebaseFirestore.instance.collection('Loans');
                                loan.doc('$uid').set({
                                  'names':_name.text.trim(),
                                   'Application Date':DateFormat.yMMMMd().format(date),
                                    'delivery':delivery,
                                  'profit':interest,  
                                'TotalAmount':TotalToPay, 
                                 'email':emails,   
                                  'uid':uid,
                                   'username':username,
                                  'MonthlyFee':monthlyfee.toString(),
                                   'Status': 'Pending Approval',
                                   'Query':'',
                                   'app date':'Application Date',
                                'Occupation':_occupation.text.trim(),
                                'NIN no.':_nin.text.trim(),  
                                 'Car name': widget.carname, 
                                'Location':_location.text.trim(), 
                                'Phone Number':int.parse(_phonenumber.text.trim()).toString(),  
                                'image': widget.image,
                                'button':'Cancel Application',
                                'PaymentPeriod':payment,
                                 'PaymentPeriodButton':'Payment Period',
                                'Balance':TotalToPay,
                                'Paid Money':int.parse('0'),
                                'Intial Deposit':IntialDeposit,
                                'Price':widget.price,
                                'Provider_name':'',
                                'Deposit_Button':'Intial Deposit Required',
                                'Acquistion':'Delivery Method',
                                'NumberOfMonths':NumberOfMonths.toString(),
                                'sellerID': widget.pk,
                                'seller':'',
                                'Advert Pk':widget.advertpk,
                                'selleremail':widget.email,
                                'rate':widget.rate,
                                });
                                Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => NotesView()), (r) => false);
                    
                   ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('You loan Application has been submitted. We shall contact you shortly to verify your loan')));
                   }   else {
                  log('Loan exists');
                  showErrorDialog(context, 'You already have an outstanding loan. Clear the loan to qualify for another');
                }    
                                  } catch (e){
                                    throw showErrorDialog(context, '$e');
                                  }
                                  }
             }, child: Text('Submit')
             ), 
              
            ],
          ),
        ),
      ),
    );
  }
}