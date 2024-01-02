import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  TextEditingController ipAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.asset("assets/videos/backgroundvideo.mp4");
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            aspectRatio: constraints.maxWidth / constraints.maxHeight,
            autoPlay: true,
            looping: true,
            autoInitialize: true,
            showControls: false,
          );
          return Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Chewie(
                controller: chewieController,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black87,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 550),
                            Text(
                              'Welcome,',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(height: 20),
                            const Text(
                              'Please enter IP address of your device to pair',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 25),
                            Row(

                              children: [
                                Expanded(
                                  flex: 5 ,

                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: ipAddressController,
                                      style: TextStyle(color: Colors.white,fontSize: 16),
                                      decoration: InputDecoration(

                                        hintText: 'IP address',
                                        contentPadding: const EdgeInsets.symmetric(
                                          vertical: 3,
                                          horizontal: 8,
                                        ),
                                        hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        fillColor: Colors.transparent,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  flex: 1,

                                  child: SizedBox(
                                  //  width: 1,
                                    child: ElevatedButton(

                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        shape: CircleBorder(),
                                            padding:EdgeInsets.all(10),
                                         // borderRadius: BorderRadius.circular(40.0),


                                      ),
                                      onPressed: () {
                                        String ipAddress = ipAddressController.text;
                                        // Use the IP address as needed
                                        print('Entered IP address: $ipAddress');
                                      },
                                      child:  Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [

                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          ],

                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
