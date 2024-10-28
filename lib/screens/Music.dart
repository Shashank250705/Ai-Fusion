import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'wishlist_screen.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key, this.page = 'login', required this.onItemRemoved});
  final String page;
  final Function(String) onItemRemoved;

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool _isLiked = false;
  final String _toolName = 'HumTap';

  @override
  void initState() {
    super.initState();
    _loadLikeStatus();
  }

  // Load like status from SharedPreferences
  void _loadLikeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLiked = prefs.getBool('isLiked_$_toolName') ?? false;
    });
  }

  // Save like status to SharedPreferences
  void _saveLikeStatus(bool isLiked) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLiked_$_toolName', isLiked);
    List<String> wishlistItems = prefs.getStringList('wishlistItems') ?? [];
    if (isLiked) {
      if (!wishlistItems.contains(_toolName)) {
        wishlistItems.add(_toolName);
      }
    } else {
      wishlistItems.remove(_toolName);
      widget.onItemRemoved(_toolName); // Notify parent that the item is removed
    }
    await prefs.setStringList('wishlistItems', wishlistItems);
  }

  // Function to launch a URL
  void _launchURL(Uri uri, bool inApp) async {
    try {
      if (await canLaunchUrl(uri)) {
        if (inApp) {
          await launchUrl(
            uri,
            mode: LaunchMode.inAppWebView,
          );
        } else {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      print(e.toString());
      // Optionally show a snackbar or other alert to the user
      Fluttertoast.showToast(
          msg: 'Could not launch URL',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/OIP(2).jpeg',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40), // Add some top padding to avoid the notch area
                  Row(
                    children: [
                      SizedBox(width: 90.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 200.0),
                        child: IconButton(
                          icon: Icon(
                            _isLiked ? Icons.favorite : Icons.favorite_border,
                            color: _isLiked ? Colors.red : Colors.black87,
                            size: 30.0,
                          ),
                          onPressed: () {
                            setState(() {
                              _isLiked = !_isLiked;
                            });
                            _saveLikeStatus(_isLiked);
                            Fluttertoast.showToast(
                                msg: _isLiked ? 'Added to wishlist' : 'Removed from wishlist',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black87,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'ABOUT',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _toolName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.5,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          ' Humtap: An AI music creation app that turns your humming or tapping into   full-fledged songs.Humtap allows users to collaborate on projects, share ideas, and create content together, enhancing the creative process. It aims to simplify the creative process, allowing users to create professional-quality music and visuals with minimal effort.Humtap exemplifies how technology can transform traditional creative processes, making it easier for anyone to produce high-quality music and visual content.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'HOW TO USE:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '➔  Create music using this tool, without the need for instruments.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔  When humming a melody, try to be as clear and accurate as possible.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ Ensure your tapping is rhythmic and consistent to get the best results from the AI.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ Use the app’s editing tools to fine-tune your track.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ Focus on key elements such as tempo, key, and instrumentation to quickly achieve the desired sound.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ By following these tips and leveraging Humtap’s features, you can efficiently create high-quality music tracks and make the most of this innovative AI tool.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _launchURL(Uri.parse('https://www.humtap.com/'), true),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Try it now',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
