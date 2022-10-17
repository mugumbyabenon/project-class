import 'package:car_loan_project/views/buy.dart';
import 'package:car_loan_project/views/mobilemoney.dart';
import 'package:car_loan_project/views/payments.dart';
import 'package:flutter/material.dart';

import '../views/loan.dart';
import '../views/login_view.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An error occurred '),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      });
}

Future<void> PaymentsOptions(
    BuildContext context, String text, final pk, final paid, final balance) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payments'),
          content: Text('Which payment mode do you want to use'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PhoneMobileMoney(pk, paid, balance)),
                  );
                },
                child: const Text('Mobile Money')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MakePayment(
                              title: Strings.appName,
                              pk: pk,
                              balance: balance,
                              paid: paid,
                            )),
                  );
                },
                child: const Text('Card Payment')),
          ],
        );
      });
}

Future<bool> DeleteAdvert(
  BuildContext context,
) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Remove Advert'),
        content: const Text('Are you sure you want to delete this Advert'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('ok'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'))
        ],
      );
    },
  ).then((value) => value ?? false);
}

Future<void> PurchaseRequest(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thank you '),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      });
}

Future<void> PromptLogin(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Join our Family Today '),
          content: Text(
              'Reach Out to thousands of customers or obtain unsecured loans'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
                child: const Text('Login/SignUp'))
          ],
        );
      });
}

Future<void> BuyLoan(BuildContext context, final price, final carname,
    final image, final sellerID, final email, final rate, final advertpk) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: const Text('Options')),
          content: Text('Do you want to buy or apply for loan'),
          actions: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Buy(advertpk)),
                      );
                    },
                    child: Text('Buy')),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestLoan(
                                price ?? 0,
                                carname,
                                image,
                                sellerID,
                                email,
                                rate,
                                advertpk)),
                      );
                    },
                    child: Expanded(child: Text('Loan')))
              ],
            ),
          ],
        );
      });
}
