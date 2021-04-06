import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'models/color.dart';
import 'models/color.dart';
import 'models/color.dart';
import 'models/color.dart';
import 'models/my_flutter_app_icons.dart';

class PaymentMsg extends StatefulWidget {
  final int amt;
  final String rec;
  final String hash;
  PaymentMsg({this.amt, this.rec, this.hash});
  @override
  _PaymentMsgState createState() => _PaymentMsgState(amt:amt,rec:rec,hash:hash);

}

class _PaymentMsgState extends State<PaymentMsg> {
  final int amt;
  final String rec;
  final String hash;
  _PaymentMsgState({this.amt, this.rec, this.hash});
  @override
  Widget build(BuildContext context){
   return Scaffold(
     backgroundColor:Colors.white,
     body:Column(

       mainAxisAlignment: MainAxisAlignment.center,
       mainAxisSize: MainAxisSize.max,

       children: [
         Padding(
           padding: const EdgeInsets.all(15),
           child: Image(
               image: AssetImage("images/success.gif"),
              height: 100,
             fit: BoxFit.cover,
           ),
         ),

         Text('Payment Successful!',
             textAlign: TextAlign.center,
             style: TextStyle(
             color:Colors.black,
             fontSize:30,
             fontWeight:FontWeight.bold)),

          Padding(
            padding: const EdgeInsets.all(30),
            child: Text('The payment of '+amt.toString()+' has successfully been sent to '+rec.toUpperCase()+' and the transaction hash is '+hash,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:Colors.black54,
                    fontSize:20,
                    fontWeight:FontWeight.bold)),
          ),
         RaisedButton(
           onPressed:(){},
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(18.0),

           ),
           color: Colors.purple,
           child: Text(
             "Continue",
    style: TextStyle(
             color:Colors.white,
             fontSize:25,
        fontWeight:FontWeight.bold
    ),
           ),),
       ],
     ),

   );
 }
}