import 'package:autopayflutter/things/orderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionDesign extends StatefulWidget {

  final String currency,status,hash,to,amount,address;
  final int timestamp;
  const TransactionDesign(
      {Key key,
        this.currency,
        this.status,
        this.hash,
        this.timestamp,
        this.to,
      this.address,
      this.amount})
      : super(key: key);

  @override
  _TransactionDesignState createState() => _TransactionDesignState();
}

class _TransactionDesignState extends State<TransactionDesign> {


  geturl(hash,currency) async{
    String urlString;
    if(currency=="eth")
     urlString = "http://ropsten.etherscan.io/tx/"+hash;
    else
    urlString="https://diemscan.io/version/"+hash;
    print(urlString);
    if(await canLaunch(urlString)) {
      launch(
        urlString,
        forceSafariVC: false,
        forceWebView: true,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    String transactionName;
    IconData transactionIconData;
    Color color;

    return Container(
      height: 90,
      margin: EdgeInsets.all(9.0),
      padding: EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.grey[350],
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(FontAwesomeIcons.was,color: Colors.purple,),
                  // borderRadius: BorderRadius.circular(15.0),
                  // child: Image.network(
                  //   "https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg",
                  // ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: FittedBox(
                      child: Icon(
                        transactionIconData,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 5.0),
          Flexible(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 12, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.to,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                      Text(
                        "\$ ${widget.amount}",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 12, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(widget.timestamp).toString().substring(0,16),
                        style: TextStyle(color: Colors.grey[700]),
                      ),

                      Text(
                        widget.status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: GestureDetector(
                    onTap: () async{
                      if(widget.to=="Detergent"){
                        String url="https://diemscan.io/version/"+widget.hash;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetails(url: url,)));
                      }
                      else
                      await geturl(widget.hash,widget.currency);
                    },
                    child: Text(
                      "More Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decoration: TextDecoration.underline
                      ),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}