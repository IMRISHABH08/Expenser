import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onPresssed;
  //final Function dateReceived;
  NewTransaction({
    this.onPresssed,
  }) {
    // print(nameController.text);
    // print(priceController.text);
  }

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  DateTime _pickedDate;

  bool autoFocus_name = false; // (priceController)!=null
  bool autoFocus_price = false; //nameController!=null

  void submitData() {
    // var EnteredPrice;
    //final EnteredName = nameController.text;

    if (priceController.text.isNotEmpty && nameController.text.isEmpty) {
      setState(() {
        autoFocus_name = true;
        //autoFocus_price = false;
      });
    } else if (priceController.text.isEmpty && nameController.text.isNotEmpty) {
      setState(() {
        autoFocus_price = true;
        //autoFocus_name = false;
      });
    }

    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        _pickedDate == null ||
        double.parse(priceController.text) <= 0) {
      return;
    }
    widget.onPresssed(
        nameController.text,
        double.parse(
          priceController.text,
        ),
        _pickedDate);

    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    ).then((value) {
      if (value == null)
        return;
      else
        setState(() {
          _pickedDate = value;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        color: Colors.transparent,
        child: Container(
          // height: 900,
          padding: EdgeInsets.all(10),
          // padding: EdgeInsets.only(
          //     top: 0,
          //     left: 10,
          //     right: 10,
          //     bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: nameController,
                autofocus: autoFocus_name ? true : false,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  //hintText: "String",
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
                autofocus: autoFocus_price ? true : false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  //hintText: "Number",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _pickedDate == null
                        ? "No Date Choosen"
                        : DateFormat.yMd().format(_pickedDate),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    onPressed: _pickDate,
                    // child: Text(
                    //   "Choose Date",
                    //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    // ),
                    // textColor: Colors.white70,
                  )
                ],
              ),
              TextButton.icon(
                icon: Icon(Icons.add_to_queue),
                label: Text(
                  "Add Transaction",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                // padding: EdgeInsets.all(10),
                // highlightColor: Colors.indigo[200],
                // child: Text(
                //   "Add Transaction",
                //   style: TextStyle(color: Colors.white),
                // ),
                onPressed: submitData,
                // color: Colors.blue[800],
              )
            ],
          ),
        ),
      ),
    );
  }
}
