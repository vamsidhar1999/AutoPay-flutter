import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionDesign extends StatefulWidget {

  final String currency,status,hash,timestamp,to,amount,address;
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
  @override
  Widget build(BuildContext context) {
    String transactionName;
    IconData transactionIconData;
    Color color;

    return Container(
      margin: EdgeInsets.all(9.0),
      padding: EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg",
                  ),
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.to,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$ ${widget.amount}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.hash,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Text(
                      widget.address,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}