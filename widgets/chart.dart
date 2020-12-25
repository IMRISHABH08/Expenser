import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  //final double totalSum;
  // double perCentPart = 0.0;

  Chart({
    this.recentTransactions,
  });

  double get totalSum {
    return individualBarChart.fold(0.0, (sum, element) {
      return sum = sum + element['amount'];
    });
  }

  List<Map<String, Object>> get individualBarChart {
    return List.generate(
      7,
      (index) {
        double amount = 0.0;
        final weekDay = DateTime.now().subtract(Duration(days: index));
        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            amount += recentTransactions[i].amount;
          }
        }
        // perCentPart = ((amount) / (totalSum));
        //print(perCentPart);
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': amount
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('The total sum of last 7 days are $totalSum');
    print(individualBarChart);

    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //FcrossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...individualBarChart.map((element) {
            return Flexible(
              //flex: 1,
              //fit: FlexFit.loose,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FittedBox(
                    child: Text(
                      "₹ ${element['amount']}",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                    width: 20,
                    height: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            alignment: Alignment.bottomCenter,
                            heightFactor: totalSum == 0.0
                                ? 0.0
                                : (element['amount'] as double) / totalSum,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[300],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 4, color: Colors.deepOrange),
                              ),
                              //color: Colors.lime,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    element['day'],
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
            );
          })
        ],
       
      ),
    );
  }
}
