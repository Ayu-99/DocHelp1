import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class PaymentHomePage extends StatefulWidget {
  @override
  _PaymentHomePageState createState() => _PaymentHomePageState();
}

class _PaymentHomePageState extends State<PaymentHomePage> {
  int totalAmount=2000;
  Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay=Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentExternalWallet);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
//rzp_test_8d0NtLpi3MINz7
  void openCheckout() async{
//    Map<String, Object> options;
    var options = {
      'key': 'rzp_test_8d0NtLpi3MINz7',
      'amount': 100*100,
      'name': 'DocHelp',
      'description': 'Online Consultation',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com'
      }
    };
    try{
      _razorpay.open(options);
    }catch(e){
      debugPrint(e);
    }

  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "SUCCESS: "+response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "ERROR: "+response.code.toString());

  }

  void _handlePaymentExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: "EXTERNAL WALLET: "+response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:RaisedButton(
          color: Colors.teal,
          child: Text("Make Payment",
              style:TextStyle(
                color: Colors.white,
              )),
          onPressed: (){
            openCheckout();
          },

        ),
      ),


    );
  }
}
