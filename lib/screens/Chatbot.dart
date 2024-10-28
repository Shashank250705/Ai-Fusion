import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'wishlist_screen.dart';

class GetOTPScreen extends StatefulWidget {
  const GetOTPScreen({super.key, this.page = 'login', required this.onItemRemoved});
  final String page;
  final Function(String) onItemRemoved;

  @override
  State<GetOTPScreen> createState() => _GetOTPScreenState();
}

class _GetOTPScreenState extends State<GetOTPScreen> {
  bool _isLiked = false;
  final String _toolName = 'ADA Tool';

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
                          'ADA Chatbot leverages advanced AI and NLP to provide intelligent, conversational experiences. It is designed to understand and respond to user queries, automate tasks, and offer personalized assistance. With customizable models and seamless integration capabilities, ADA Chatbot can be tailored to meet specific business needs, enhancing user engagement and satisfaction.',
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
                          '➔ Use Ada AI to empower and take a proactive approach to your health by providing valuable information and guidance based on symptom assessments.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ However, it’s important to remember that Ada is not a substitute for professional medical advice and diagnosis.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ Ask Ada AI questions about a wide range of topics, depending on its capabilities.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ This could include general inquiries, product support, recommendations, and more.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _launchURL(Uri.parse('https://ada.com/'), true),
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
