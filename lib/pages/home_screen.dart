import 'package:flutter/material.dart';
import 'widgets/bottom_model_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> texts = [];

  void addText(String newText) {
    setState(() {
      texts.add(newText);
    });
  }

  void removeText(int index) {
    setState(() {
      texts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: texts.isEmpty
            ? Text('No Texts Yet')
            : ListView.builder(
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust spacing
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            texts[index],
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          onPressed: () {
                          },
                        ),
                        // SizedBox(width: 2.0),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            removeText(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) => MyBottomSheet(onTextCreated: addText),
          );
        },
        label: Text('ADD SIGN'),
        icon: Icon(Icons.edit),
      ),
    );
  }
}
