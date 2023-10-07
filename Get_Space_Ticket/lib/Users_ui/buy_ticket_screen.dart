import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import 'package:get_space_ticket/utils/buy_ticket_view.dart';
import 'package:http/http.dart' as http;

import '../login_signup/ui/utils/utils.dart';

class BuyTicketScreen extends StatefulWidget {
  final String launchingID;
  const BuyTicketScreen({Key? key, required this.launchingID})
      : super(key: key);

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState(launchingID);
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  Map<String,dynamic>? paymentIntentData;
  final bookingCode = DateTime.now().microsecondsSinceEpoch.toString();
  var lid;
  bool loading = false;
  _BuyTicketScreenState(this.lid);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref2 = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
      'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("user");
  DatabaseReference ref = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Gap(30),
              Text(
                'Buy Ticket',
                style: Styles.headLineStyle,
              ),
              const Gap(10),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: ref.child(lid.toString()).onValue,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        final DataSnapshot data = snapshot.data!.snapshot;
                        final Map<dynamic, dynamic>? map =
                            data.value as Map<dynamic, dynamic>?;
                        return BuyTicket(
                          name: 'asif',
                          money: 10,
                          bookingCode: bookingCode,
                          toAd: map?['toAdd'],
                          formAd: map?['fromAdd'],
                          lunchCode: map?['lunchCode'],
                          occupation: 'occupation',
                          space: map?['spaceName'],
                          service: map?['service'],
                        );
                      } else {
                        return const Text('Wrong Something');
                      }
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  await makePayment();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fact_check,
                                color: Colors.white,
                              ),
                              Gap(10),
                              Text(
                                'Buy Now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const Gap(2),
            ],
          ),
        ),
      ),
    );
  }
  updateInfo(){
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    ref2.child(uid!).child('booking').child(bookingCode.toString()).update({
      'bookingCode':bookingCode.toString(),
      'launchingID':lid.toString(),
    }).then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      Utils().toastMessages('Info. updated');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessages(error.toString());
    });
  }
  Future<void> makePayment()async {
    try{
      paymentIntentData =await createPaymentIntent('100', 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            googlePay: const PaymentSheetGooglePay(
                merchantCountryCode: 'US',
            ),
              merchantDisplayName: 'Muntasir',
            style: ThemeMode.dark,
          ));
      displayPaymentSheet();
    }catch(e){
      print('exception: $e');
    }
  }
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        updateInfo();
        Utils().toastMessages('"Payment successful"');
      }).onError((error, stackTrace) {
        Utils().toastMessages(error.toString());
      });
    } catch (e) {
      Utils().toastMessages(e.toString());
    }
  }

  createPaymentIntent(String amount, String currency)async{
    try{
      Map<String,dynamic> body ={
        'amount': amount,
        'currency':currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':'Bearer sk_test_51NxZQlJkK65lgXgk9UPbW5NZsNlc2mWSgSo8qqdYfjauCRdWOvR2KhnIkUEaC07oB7xqDGOGZ8gMD2jecNLJWGeL00ibRBUEFM',
          'Content-Type' : 'application/x-www-form-urlencoded'
        }
      );
      return jsonDecode(response.body.toString());
    }catch(e){
      print('exception: $e');
    }
  }
}
