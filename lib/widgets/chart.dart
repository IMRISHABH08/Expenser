import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    String size = MediaQuery.of(context).size.height.toString();

    return LayoutBuilder(builder: (ctx, constrains) {
      print("The height of the constrained Chart is ${constrains.maxHeight}");
      return Card(
      
        elevation: 5,
        margin: EdgeInsets.only(
            top: constrains.maxHeight * 0.09,
            bottom: constrains.maxHeight * 0.12,
            left: 15,
            right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //FcrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...individualBarChart.map((element) {
              return Flexible(
                //flex: 1,
                //  fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: constrains.maxHeight * 0.115,
                      child: FittedBox(
                        child: Text(
                          "₹ ${element['amount']}",
                          style: TextStyle(
                              fontSize: constrains.maxHeight * 0.2,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: constrains.maxHeight * 0.029,
                          left: 10,
                          right: 10,
                          bottom: constrains.maxHeight * 0.029),
                      width: 20,
                      height: constrains.maxHeight * 0.44,
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
                    Container(
                      padding: EdgeInsets.all(2.5),
                      height: constrains.maxHeight * 0.17,
                      child: Text(
                        element['day'],
                        style: TextStyle(
                            fontSize: constrains.maxHeight * 0.09,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            })
          ],
        
        ),
      );
    });
  }
}
