import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _sendHttpRequest(String enteredText) async {
    final port = 8000;
    final url = Uri.parse('http://192.168.34.67:$port/receive-text');

    try {
      final response = await http.post(url, body: {'text': enteredText});

      if (response.statusCode == 200) {
        print('Text sent successfully!');
      } else {
        print('Failed to send text. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
         decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          color: Colors.white,
         ),
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
            ElevatedButton(
              onPressed: () async {
                String enteredText = textEditingController.text;
                print(enteredText);
                await _sendHttpRequest(enteredText);
                widget.onTextCreated(enteredText);
                textEditingController.clear();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
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
      ),
    );
  }
}
