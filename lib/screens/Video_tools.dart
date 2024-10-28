import 'package:flutter/material.dart';
import 'package:ridebhaiya/screens/Market.dart';

import 'Video.dart';


class VideoTools extends StatefulWidget {
  const VideoTools({Key? key}) : super(key: key);

  @override
  State<VideoTools> createState() => _VideoToolsState();
}

class _VideoToolsState extends State<VideoTools> {
  // Function to handle onTap
  void _onContainerTap(String toolName) {
    if (toolName == 'Animoto') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VideoScreen(onItemRemoved: (String ) {  },)),
      );
    }
    // Perform your action here. For example, navigate to a new screen or show a dialog.
  }

  Widget buildTaggedLottieContainer(String text, List<Color> gradientColors) {
    return InkResponse(
      onTap: () {
        _onContainerTap(text); // Call the onTap handler
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 25.0),
        child: Container(
          height: 150,
          width: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(4.0, 4.0),
                blurRadius: 3,
                spreadRadius: 2.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 7,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text, // Use the passed text parameter
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            'List Of AI Tools',
            style: TextStyle(fontSize: 30.0, fontFamily: 'Poppins'),
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildTaggedLottieContainer('Animoto', [Colors.blue, Colors.lightBlueAccent]),
                SizedBox(height: 10.0),
                buildTaggedLottieContainer('Kapwing', [Colors.purple, Colors.deepPurpleAccent]),
                SizedBox(height: 10.0),
                buildTaggedLottieContainer('Synthesia', [Colors.indigo, Colors.indigoAccent]),
                SizedBox(height: 10.0),
                buildTaggedLottieContainer('Magisto', [Colors.orange, Colors.deepOrangeAccent]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
