import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:car_loan_project/views/payments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uganda_mobile_money/uganda_mobile_money.dart';

class PhoneMobileMoney extends StatefulWidget {
  final pk;
  final paids;
  final balances;
  PhoneMobileMoney(this.pk, this.paids, this.balances);

  @override
  State<PhoneMobileMoney> createState() => _PhoneMobileMoneyState();
}

class _PhoneMobileMoneyState extends State<PhoneMobileMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Option',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(color: Colors.orange),
        backgroundColor: Colors.black,
      ),
      body: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MobileMoney(widget.pk, widget.paids,
                        widget.balances, UgandaNetwork.airtel)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color.fromARGB(255, 206, 204, 204),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 300,
              child: Center(
                  child: Text(
                'Airtel Mobile Money',
                style: TextStyle(fontSize: 30, color: Colors.orange),
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MobileMoney(widget.pk, widget.paids,
                        widget.balances, UgandaNetwork.mtn)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color.fromARGB(255, 206, 204, 204),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 300,
              child: Center(
                  child: Text(
                'Mtn Mobile Money',
                style: TextStyle(fontSize: 30, color: Colors.orange),
              )),
            ),
          )
        ],
      ),
    );
  }
}

class MobileMoney extends StatefulWidget {
  final pk;
  final paids;
  final balances;
  final network;
  MobileMoney(this.pk, this.paids, this.balances, this.network);
  // const MobileMoney({super.key});

  @override
  State<MobileMoney> createState() => _MobileMoneyState();
}

class _MobileMoneyState extends State<MobileMoney> {
  late final TextEditingController _phone;
  late final TextEditingController _amounttopay;
  @override
  void initState() {
    _phone = TextEditingController();
    _amounttopay = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    _amounttopay.dispose();
    super.dispose();
  }

  final secretKey = "FLWSECK-XXXXX-X";
  // flutterwave secret key
  UgandaMobileMoney _mobileMoney =
      UgandaMobileMoney(secretKey: 'FLWSECK_TEST0f3fac06ablf');

  void chargeClient(final pk, final paids, final balances) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? username = user.displayName ?? ''; // <-- Us,
      String? uid = user.uid;
      String? email = user.email;

      final taxref = DateTime.now().toString() + uid;
      log('$taxref');
      MomoPayResponse response = await _mobileMoney.chargeClient(
        MomoPayRequest(
            txRef: "$taxref", // should be unique for each transaction
            amount: "${_amounttopay.text}", // amount in UGX you want to charge
            email: "$email", // email of the person you want to charge
            phoneNumber: "${_phone.text}", // clients phone number
            fullname: "$username", // full name of client
            redirectUrl: "https://yoursite.com", // redirect url after payment
            voucher: "128373", // useful for vodafone. you can ignore this
            network:
                UgandaNetwork.airtel // network, can be either mtn or airtel
            ),
      );
      log(response.message);
      log('$taxref');
      verifyTransaction(
          taxref, pk, paids, _amounttopay.text, balances, context);
    }
  }

  void verifyTransaction(final taxrefe, final pk, final paids, final amountpaid,
      balances, context) async {
    _mobileMoney.verifyTransaction('$taxrefe').then((value) async {
      if (value == TransactionStatus.failed) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed")));
      } else if (value == TransactionStatus.pending) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Pending")));
      } else if (value == TransactionStatus.success) {
        await PaymentProcess(pk, paids, amountpaid, balances, context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Success")));
      } else if (value == TransactionStatus.unknown) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unknown Error on Transaction Try again later")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Unknown Error during transaction")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mobile Money for Airtel',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(color: Colors.orange),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: TextFormField(
              controller: _phone,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: const Icon(
                  Icons.contact_phone,
                  size: 40.0,
                ),
                hintText: '2567XXXXXXXX',
                labelText: 'Airtel phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          TextFormField(
            controller: _amounttopay,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: const Icon(
                Icons.money,
                size: 40.0,
              ),
              hintText: '',
              labelText: 'Amount to pay',
            ),
            keyboardType: TextInputType.number,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  chargeClient(widget.pk, widget.paids, widget.balances);
                },
                child: Text('Pay')),
          ),
        ],
      ),
    );
  }
}
