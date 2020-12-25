import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:second_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final Function delete;

  final List<Transaction> _userTransactions;
  TransactionList(this._userTransactions, {this.delete});
  // : this._userTransaction = userTransaction;
  // {
  //   // _userTransaction=userTransaction;
  //  // ...(userTransaction.map((e) => _userTransaction.add(e)).toList());
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      padding: EdgeInsets.all(5),
      child: _userTransactions.isEmpty
          ? Column(children: [
              Text(
                "Oops !!  You haven't added any Transactions yet .",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 290,
                child: Image.asset(
                  'assets/images/waiting.png',
                  //       loadingBuilder: (BuildContext context, Widget child,
                  //   ImageChunkEvent loadingProgress) {
                  // if (loadingProgress == null) return child;
                  // return Center(
                  //   child: CircularProgressIndicator(
                  //     value: loadingProgress.expectedTotalBytes != null
                  //         ? loadingProgress.cumulativeBytesLoaded /
                  //             loadingProgress.expectedTotalBytes
                  //         : null,
                  //   ),
                  //   );
                  //   },
                  fit: BoxFit.cover,
                  semanticLabel: 'zoom',
                ),
              ),
            ])
          : ListView.builder(
              //scrollDirection: Axis.horizontal,
              // physics: BouncingScrollPhysics(),
              itemCount: _userTransactions.length,
              itemBuilder: (context, index) {
                return
                    //  GestureDetector(
                    //   onDoubleTap: () {
                    //     print(_userTransactions.indexOf(_userTransactions[index]));
                    //   },
                    //   child:
                    Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 55,
                        width: 70,
                        margin: EdgeInsets.only( 
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black26,
                            width: 3,
                          ),
                          color: Colors.redAccent,
                        ),
                        // color: Colors.redAccent,
                        child: Text(
                          //  "\$"+e.amount.toString(),
                          //  r"$"+e.amount.toString(),
                          "${_userTransactions[index].amount.toStringAsFixed(2)} \₹",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _userTransactions[index].title,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            DateFormat.yMMMMd()
                                .format(_userTransactions[index].date),
                            style:
                                TextStyle(color: Colors.white70, fontSize: 10),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 150,
                          ),
                          //
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              delete(_userTransactions
                                  .indexOf(_userTransactions[index]));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
