import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//import 'package:intl/intl.dart';
//import 'package:second_app/widgets/chart.dart';
//import 'package:second_app/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
//import './widgets/user_Transactions.dart';

import './widgets/new_transaction.dart';

//import 'package:intl/intl.dart';.dart';

import './widgets/chart.dart';

//import 'dart:io';

import 'models/transaction.dart';

void main() {
  //to restrict orientation

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EXpenser",
      themeMode: ThemeMode.light,
      // darkTheme: ThemeData(
      //   primaryColor: Colors.amber
      // ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        canvasColor: Colors.blueGrey.shade900,
        accentColor: Colors.black26,

        //  platform: TargetPlatform.android,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            headline2: TextStyle(
              fontFamily: 'Acme',
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: Colors.white,
            )),
        // textTheme: TextTheme(
        //   headline1: TextStyle(
        //     fontFamily:'OpenSans',
        //     fontWeight: FontWeight.bold,
        //     fontSize: 15,
        //   )
        // ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'Opensans',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // double _totalSum7 = 0;

/* //USING FOR LOOP FILTERING THE OLD LIST

  List<Transaction> get recentTransaction {
    final weekDay = DateTime.now().subtract(Duration(days: 7));
    //List<Transaction> _FilteredTransactions;
    _userTransactions.forEach((element) {
      if (element.date.isAfter(weekDay)) {
        recentTransaction.add(element);
      }
    });
    return recentTransaction;
  }

*/

  DateTime _pickedDate = DateTime.now();

  void delete(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  List<Transaction> get _filteredTransaction {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            onPresssed: _addTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  final List<Transaction> _userTransactions = [
    // Transaction(date: DateTime.now(), amount: 700, id: "t1", title: "Shoes"),
    // Transaction(date: DateTime.now(), amount: 500, id: "t2", title: "Mouse"),
  ];

  void _addTransaction(String txTitle, double txAmount, DateTime pickedDate) {
    _pickedDate = pickedDate;
    final newTx = Transaction(
        date: _pickedDate,
        amount: txAmount,
        id: DateTime.now().toString(),
        title: txTitle);
    setState(() {
      _userTransactions.add(newTx);

      /* 
      //optional from list.fold()

      _totalSum7 = 0.0;
      _filteredTransaction.forEach((element) {
        _totalSum7 += element.amount;
      });
              
       */
      //print('total sum of last 7 days are $_totalSum7');
    });
  }

  bool Switch_Change = false;

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    String size = mediaquery.size.height.toString();
    print("available height " + size);
    String sizeWidth = mediaquery.size.width.toString();
    print("available width " + sizeWidth);
    bool isLandscap = mediaquery.orientation == Orientation.landscape;

    return Scaffold(
        // backgroundColor: Colors.blue[100],{}
        //resizeToAvoidBottomInset: false,
        floatingActionButton: Platform.isIOS
            ? Container()
            : FloatingActionButton(
                child: Icon(Icons.add),
                elevation: 50,
                onPressed: () {
                  _startAddNewTransaction(context);
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "Expenser",
          ),
          // backgroundColor: Colors.black12,
          actions: <Widget>[
            if (isLandscap)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Chart",
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  Switch.adaptive(
                    //activeColor: Colors.black12,
                    value: Switch_Change,
                    onChanged: (newValue) {
                      setState(() {
                        Switch_Change = newValue;
                        // Switch_Change = !Switch_Change;
                        // if (Switch_Change == true)
                        //   Switch_Change = false;
                        // else
                        //   Switch_Change = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                  )
                ],
              ),
          ],
        ),
        body: ListView(
          // physics: BouncingScrollPhysics(),
          //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            if (isLandscap)
              Switch_Change == true
                  ? Container(
                      height: (mediaquery.size.height -
                          mediaquery.padding.top -
                          kToolbarHeight),
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            height: mediaquery.size.height * 0.2064,
                            width: double.infinity,
                            //margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              //     image: DecorationImage(
                              //         image: AssetImage(
                              //             "assets/images/wallpaper2you_55590.jpg"),
                              //         fit: BoxFit.cover),
                            ),
                          ),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: mediaquery.size.height * 0.073,
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: mediaquery.orientation ==
                                          Orientation.portrait
                                      ? mediaquery.size.height * 0.24
                                      : mediaquery.size.height * 0.4,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    // color: Colors.black54,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      //background color of box
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 1.0, //extend the shadow
                                        offset: Offset(
                                          0.0, // Move to right 10  horizontally
                                          0.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Chart(
                                    recentTransactions: _filteredTransaction,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: (mediaquery.size.height -
                          mediaquery.padding.top -
                          kToolbarHeight),
                      child:
                          TransactionList(_userTransactions, delete: delete)),

            if (!isLandscap)
              Container(
                height: (mediaquery.size.height -
                        mediaquery.padding.top -
                        kToolbarHeight) *
                    0.4,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: mediaquery.size.height * 0.2064,
                      width: double.infinity,
                      //margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        //     image: DecorationImage(
                        //         image: AssetImage(
                        //             "assets/images/wallpaper2you_55590.jpg"),
                        //         fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: mediaquery.size.height * 0.073,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height:
                                mediaquery.orientation == Orientation.portrait
                                    ? mediaquery.size.height * 0.24
                                    : mediaquery.size.height * 0.4,
                            width: 350,
                            decoration: BoxDecoration(
                              // color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                //background color of box
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 20.0, // soften the shadow
                                  spreadRadius: 1.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    0.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: Chart(
                              recentTransactions: _filteredTransaction,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (!isLandscap)
              Container(
                  height: (mediaquery.size.height -
                          mediaquery.padding.top -
                          kToolbarHeight) *
                      0.6,
                  child: TransactionList(_userTransactions, delete: delete)),

            // Card(
            //   margin: EdgeInsets.only(
            //     bottom: 15,
            //     left: 5,
            //     right: 5,
            //     top: 10,
            //   ),
            //   elevation: 20,
            //   child: Container(
            //       height: 100,
            //       width: double.infinity,
            //       margin: EdgeInsets.all(5),
            //       color: Colors.green,
            //       alignment: Alignment.center,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            // Column(
            //   children: [
            //     Text(
            //       "₹",
            //       style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            //     Container(
            //       //margin: EdgeInsets.only(top:0,left: 15,right: 15,bottom:0 ),
            //       width: 20,
            //       height: 52,
            //       decoration: BoxDecoration(
            //         border: Border.all(
            //           color: Colors.white,
            //           width: 2,
            //         ),
            //       ),
            //     ),
            //     Text("M",
            //         style: Theme.of(context).textTheme.headline1),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Text(
            //       "₹",
            //       style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            //     Container(
            //       //margin: EdgeInsets.only(top:0,left: 15,right: 15,bottom:0 ),
            //       width: 20,
            //       height: 52,
            //       decoration: BoxDecoration(
            //           border:
            //               Border.all(color: Colors.white, width: 2)),
            //     ),
            //     Text("T",
            //         style: Theme.of(context).textTheme.headline1),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Text(
            //       "₹",
            //       style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            //     Container(
            //       // margin: EdgeInsets.only(top:0,left: 10,right: 10,bottom:0 ),
            //       width: 20,
            //       height: 52,
            //       decoration: BoxDecoration(
            //           border:
            //               Border.all(color: Colors.white, width: 2)),
            //     ),
            //     Text("W",
            //         style: Theme.of(context).textTheme.headline1),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Text(
            //       "₹",
            //       style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            //     Container(
            //       //margin: EdgeInsets.only(top:0,left: 10,right: 10,bottom:0 ),
            //       width: 20,
            //       height: 52,
            //       decoration: BoxDecoration(
            //           border:
            //               Border.all(color: Colors.white, width: 2)),
            //     ),
            //     Text("T",
            //         style: Theme.of(context).textTheme.headline1),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Text(
            //       "₹",
            //       style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            //     Container(
            //       //margin: EdgeInsets.only(top:0,left: 10,right:10,bottom:0 ),
            //       width: 20,
            //       height: 52,
            //       decoration: BoxDecoration(
            //           border:
            //               Border.all(color: Colors.white, width: 2)),
            //     ),
            //     Text("F",
            //         style: Theme.of(context).textTheme.headline1),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Text(
            //       "₹",
            //       style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            //     Container(
            //       // margin: EdgeInsets.only(top:0,left: 10,right: 10,bottom:0 ),
            //       width: 20,
            //       height: 52,
            //       decoration: BoxDecoration(
            //           border:
            //               Border.all(color: Colors.white, width: 2)),
            //     ),
            //     Text("S",
            //         style: Theme.of(context).textTheme.headline1),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Text(
            //       "₹",
            //       style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            //     Container(
            //       //margin: EdgeInsets.only(top:0,left: 8,right: 8,bottom:0 ),
            //       width: 20,
            //       height: 52,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.white, width: 2),
            //       ),
            //     ),
            //     Text("S",
            //         style: Theme.of(context).textTheme.headline1),
            //   ],
            // ),
          ],
        )
        // Text(
        //   "CHART",
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        //       ),
        // ),

        //UserTransactions(),

        );

    // Column(
    //   children: <Widget>[
    //     ...(transaction.map(
    //       (e) {
    //         return Card(
    //           child: Row(
    //             children: <Widget>[
    //               Container(
    //                 height: 50,
    //                 width: 50,
    //                 margin: EdgeInsets.only(
    //                   left: 10,
    //                   right: 10,
    //                   top: 5,
    //                   bottom: 5,
    //                 ),
    //                 alignment: Alignment.center,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(5),
    //                   border: Border.all(
    //                     color: Colors.black26,
    //                     width: 2,
    //                   ),
    //                   color: Colors.redAccent,
    //                 ),
    //                 child: Text(
    //                   //  "\$"+e.amount.toString(),
    //                   //  r"$"+e.amount.toString(),
    //                   "${e.amount} \₹",
    //                   style: TextStyle(
    //             // color: Colors.redAccent,
    //                         fontWeight: FontWeight.bold,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Text(
    //                     e.title,
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.bold, fontSize: 20),
    //                   ),
    //                   Text(DateFormat.yMMMMd().format(e.date),
    //                       style:
    //                           TextStyle(color: Colors.grey, fontSize: 15))
    //                 ],
    //               )
    //             ],
    //           ),
    //         );
    //       },
    //     )).toList(),
    //   ],
    // )
  }
}

// class MyHomePage extends StatelessWidget {
// var name;
// var price;

// final nameController = TextEditingController();
// final priceController = TextEditingController();
// final List<Transaction> transaction = [
//   Transaction(date: DateTime.now(), amount: 700, id: "t1", title: "Shoes"),
//   Transaction(date: DateTime.now(), amount: 500, id: "t2", title: "Mouse"),
// ];

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
