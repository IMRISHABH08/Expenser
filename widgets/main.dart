import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'models/transaction.dart';
import './widgets/chart.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "hello this is seond app",
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
          )),
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

  final List<Transaction> _userTransactions = [];

  void _addTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        date: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.blue[100],{}
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 50,
          onPressed: () {
            _startAddNewTransaction(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text(
            "Expenser",
          ),
          // backgroundColor: Colors.black12,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _startAddNewTransaction(context);
              },
            )
          ],
        ),
        body: ListView(
          // physics: BouncingScrollPhysics(),
          children: [
            Chart(
              recentTransactions: _filteredTransaction,
            ),
            TransactionList(_userTransactions,delete:delete),
           
          ],
        )
       
        );

   
  }
}

