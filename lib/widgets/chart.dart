import 'package:expenzo/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transaction;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < transaction.length; i++) {
        if (transaction[i].date.day == weekDay.day &&
            transaction[i].date.month == weekDay.month &&
            transaction[i].date.year == weekDay.year) {
          totalSum += transaction[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  Chart(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: groupedTransactionValues.map((dtx) {
          var dtxamount = dtx['amount'] as double<1000 ? dtx['amount'].toString():((dtx['amount'] as double) / 1000).toStringAsFixed(2)+'K';
          var dtxday = dtx['day'];
          return Flexible(
            fit: FlexFit.tight,
            child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    FittedBox(child: Text(dtxday),),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 70,
                      width: 10,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 10,
                                color: Color.fromRGBO(220, 220, 220, 1),
                              ),
                              color: Color.fromRGBO(220, 220, 220, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          FractionallySizedBox(
                            heightFactor: totalSpending == 0.0
                                ? 0.0
                                : (dtx['amount'] as double) / totalSpending,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    FittedBox(child: Text(dtxamount)),
                  ],
                )),
          );
        }).toList(),
      ),
    );
  }
}
