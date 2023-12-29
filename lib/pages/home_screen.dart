import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'widgets/bottom_model_sheet.dart';
import 'package:video_player/video_player.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<TextInfo> texts = [];
  late AnimationController _rotateController;
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _rotateController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _rotateController.repeat();

    _initializeVideoController();
   // _initializeVideoPlayerFuture=_videoController.initialize();// Initialize video controller here
  }

  Future<void> _initializeVideoController() async {
    final String videoUrl =
        'https://youtu.be/Gq6OKFugRqY?si=yiOp3Rl0c4jROSti';
    _videoController = VideoPlayerController.networkUrl(videoUrl as Uri);

    super.initState();
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void addText(String newText) {
    setState(() {
      texts.add(TextInfo(text: newText, isLoading: true));
    });

    // Simulate loading for 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        texts.last.isLoading = false;
      });
      _rotateController.stop();
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello User,',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: texts.isEmpty
                  ? Text(
                'No Signs Yet',
                style: TextStyle(
                  color: Colors.black87,
                ),
              )
                  : ListView.builder(
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    margin: EdgeInsets.symmetric(
                      horizontal: 19.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                texts[index].text,
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            texts[index].isLoading
                                ? AnimatedBuilder(
                              animation: _rotateController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _rotateController.value *
                                      5.0 *
                                      3.14,
                                  child: Icon(
                                    Icons.sync_rounded,
                                    color: Colors.blue,
                                  ),
                                );
                              },
                            )
                                : Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8.0),
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
                        SizedBox(height: 3),
                        FutureBuilder(future: _initializeVideoPlayerFuture,
                            builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.done){
                            return Center(
                            child:AspectRatio(
                            aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                  ),);}else{
                            return Center(
                      child: CircularProgressIndicator(),
                            );
                  }
                  },
                        ),

                      //  _videoController.value.isInitialized

                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 207, 61, 51),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) =>
                MyBottomSheet(onTextCreated: addText),
          );
          // To be implemented: Show modal bottom sheet or add text functionality
        },
        label: Text(
          'ADD SIGN',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        icon: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}

class TextInfo {
  final String text;
  bool isLoading;

  TextInfo({required this.text, this.isLoading = false});
}

