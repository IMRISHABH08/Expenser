import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function onPresssed;
  NewTransaction({this.onPresssed}) {
    // print(nameController.text);
    // print(priceController.text);
  }

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  void submitData() {
    // var EnteredPrice;
    //final EnteredName = nameController.text;

    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        double.parse(priceController.text) <= 0) {
      return;
    }
    widget.onPresssed(nameController.text, double.parse(priceController.text));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
        //height: 300,
        //margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: "String",
                hintStyle: TextStyle(fontSize: 15),
                labelText: "Title",
                labelStyle: TextStyle(color: Colors.white, fontSize: 15),
              ),
              style: TextStyle(
                color: Colors.white,
                // fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              onSubmitted: (_) => submitData(),
              // onEditingComplete: () {
              //   submitData();
              // },
            ),
            TextField(
              //obscureText: true,
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Number",
                hintStyle: TextStyle(fontSize: 15),
                labelText: "Price",
                labelStyle: TextStyle(color: Colors.white, fontSize: 15),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              padding: EdgeInsets.all(10),
              highlightColor: Colors.indigo[200],
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
