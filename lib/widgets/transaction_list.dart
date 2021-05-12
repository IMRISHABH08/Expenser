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
    return LayoutBuilder(
      builder: (ctx, constrains) {
        print(
            " The max height of the constrained transaction widget is ${constrains.maxHeight}");
        return Container(
          height: constrains.maxHeight * 0.94,
          padding: EdgeInsets.all(5),
          child: _userTransactions.isEmpty
              ? Column(children: [
                  SizedBox(
                    height: constrains.maxHeight * 0.52,
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      " Oops !!  You haven't added any Transactions yet . ",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),

                  // Container(
                  //   height: 290,
                  //   child: Image.asset(
                  //     'assets/images/waiting.png',
                  //     //       loadingBuilder: (BuildContext context, Widget child,
                  //     //   ImageChunkEvent loadingProgress) {
                  //     // if (loadingProgress == null) return child;
                  //     // return Center(
                  //     //   child: CircularProgressIndicator(
                  //     //     value: loadingProgress.expectedTotalBytes != null
                  //     //         ? loadingProgress.cumulativeBytesLoaded /
                  //     //             loadingProgress.expectedTotalBytes
                  //     //         : null,
                  //     //   ),
                  //     //   );
                  //     //   },
                  //     fit: BoxFit.cover,
                  //     semanticLabel: 'zoom',
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: CircleAvatar(
                  //     radius: 20,
                  //     child: Text("hey"),
                  //   ),
                  //   trailing: Icon(Icons.delete),
                  //   title: Text("LIST"),
                  //   tileColor: Colors.red,
                  //   subtitle: Text("Tile"),
                  //   dense: true,
                  //   hoverColor: Colors.white,

                  // )
                ])
              : Scrollbar(
               // isAlwaysShown: true,
                showTrackOnHover: true,
                hoverThickness: 0,               
                  child: ListView.builder(
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
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.07
                                  : MediaQuery.of(context).size.height * 0.15,
                              width: 70,
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: constrains.maxHeight * 0.013,
                                bottom: constrains.maxHeight * 0.013,
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
                              child: Container(
                                padding: EdgeInsets.all(3),
                                // constraints:
                                // BoxConstraints(minHeight: 18, maxHeight: 18),
                                height: 28,
                                width: 58,
                                child: FittedBox(
                                  child: Text(
                                    //  "\$"+e.amount.toString(),
                                    //  r"$"+e.amount.toString(),
                                    "${_userTransactions[index].amount.toStringAsFixed(2)} \₹",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constrains.maxHeight * 0.035,
                                      color: Colors.white,
                                    ),
                                  ),
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
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: constrains.maxHeight * 0.027),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? constrains.maxWidth * 0.42
                                      : constrains.maxWidth * 0.67,
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
                ),
        );
      },
    );
  }
}
