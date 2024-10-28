import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/la.dart';
import 'package:lottie/lottie.dart';
import 'package:ridebhaiya/screens/Design_tools.dart';
import 'package:ridebhaiya/screens/Image_Gen_tools.dart';
import 'package:ridebhaiya/screens/Writing_tools.dart';
import 'package:ridebhaiya/screens/coding_tools.dart';
import 'dart:async';

import 'Market_tools.dart';
import 'Music_tools.dart';
import 'Productive_tools.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0.0,),
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTaggedLottieContainer(
                  lottiePath: 'assets/animations/imageGen.json',
                  tag: 'Image Generator', onTap:  () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageGenTools()),
                ),
                ),
                SizedBox(width: 10.0),
                _buildTaggedLottieContainer(
                  lottiePath: 'assets/animations/Music.json',
                  tag: 'Music', onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MusicTools()),
                ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTaggedLottieContainer(
                  lottiePath: 'assets/animations/Designing.json',
                  tag: 'Designing', onTap: ()  => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DesignTools()),
            ),
                ),
                SizedBox(width: 10.0),
                _buildTaggedLottieContainer(
                  lottiePath: 'assets/animations/coding.json',
                  tag: 'Coding',
                  onTap:  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CodingTools()),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTaggedLottieContainer(
                  lottiePath: 'assets/animations/productivity.json',
                  tag: 'Productivity', onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductiveTools()),
                ),
                ),
                SizedBox(width: 10.0),
                _buildTaggedLottieContainer(
                  lottiePath: 'assets/animations/writing.json',
                  tag: 'Writing', onTap:()=> Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WritingTools()),
                ),
                ),
              ],
            ),
          ),
        ],
      ),

    );

  }

  Widget _buildTaggedLottieContainer({
    required String lottiePath,
    required String tag,
    required VoidCallback onTap,
  }) {
    return InkResponse(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 25.0),
        child: Stack(
          children: [
            Ink(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 3,
                    spreadRadius: 2.0,
                  ),
                  BoxShadow(
                    color: Colors.white70,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 7,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Lottie.asset(
                lottiePath,
                fit: BoxFit.contain,
                height: 100,
                width: 200,
              ),
            ),
            Positioned(
              bottom: 8.0,
              left: 44.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
