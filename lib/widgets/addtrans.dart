import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final Function addTx;

  AddTransaction(this.addTx);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredText = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredText.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(
      enteredText,
      enteredAmount,
    );
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              // onChanged: (val) => inputText=val,
              controller: titleController,
              decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
            ),
            TextField(
                // onChanged: (val) => inputAmount=val,
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("No Date"),
                FlatButton(
                  child: Text(
                    "Choose Date",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.purple,
              highlightColor: Colors.redAccent,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
