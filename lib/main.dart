import 'package:expenzo/widgets/addtrans.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transaction = [];
  List<Transaction> get recentTransaction {
    return transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addTrans(String txTitle, double txAmount) {
    final newTrans = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      transaction.add(newTrans);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            child: AddTransaction(addTrans),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Chart(recentTransaction),
        //
        Card(
          child: Container(
            child: Text(
              "CHART",
              textAlign: TextAlign.center,
            ),
            width: double.infinity,
            color: Colors.amber,
          ),
          elevation: 5,
        ),
        TransactionList(transaction),
      ],
    );
    return (Scaffold(
      appBar: AppBar(
        title: Text('Expenzo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startNewTransaction(context);
            },
          )
        ],
      ),

      ///

      body: Container(
        child: SingleChildScrollView(
          child: column,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startNewTransaction(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amberAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
