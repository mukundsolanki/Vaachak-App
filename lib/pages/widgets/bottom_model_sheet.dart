import 'package:flutter/material.dart';

class MyBottomSheet extends StatefulWidget {
  final Function(String) onTextCreated;

  MyBottomSheet({required this.onTextCreated});

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Add ',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                      text: 'Sign',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'Enter name of your sign',
            ),
          ),
          SizedBox(height: 16.0),
          // ElevatedButton(
          //   onPressed: () {
          //     String enteredText = textEditingController.text;
          //     widget.onTextCreated(
          //         enteredText); // Callback to pass text to HomeScreen
          //     textEditingController.clear(); // Clear the text field
          //     Navigator.pop(context);
          //   },
          //   child: Text('Create'),
          // ),
          ElevatedButton(
            onPressed: () {
              String enteredText = textEditingController.text;
              widget.onTextCreated(
                  enteredText); // Callback to pass text to HomeScreen
              textEditingController.clear(); // Clear the text field
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              'Create',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
