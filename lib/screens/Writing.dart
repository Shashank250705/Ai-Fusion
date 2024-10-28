import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'wishlist_screen.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key, this.page = 'login', required this.onItemRemoved});
  final String page;
  final Function(String) onItemRemoved;

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  bool _isLiked = false;
  final String _toolName = 'SEMrush Writing Assistant';

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
                          'SEMrush Writing Assistant is a powerful AI tool designed to help writers and content creators optimize their content for SEO(Search Engine Optimization).It integrates with popular writing platforms to optimize content.It integrates seamlessly with various writing platforms to provide real-time suggestions and feedback, ensuring your content is both high-quality and optimized for search engines.',
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
                          '➔ SEMrush Writing Assistant integrates with various platforms like Google Docs, WordPress, and Microsoft Word. Choose the platform where youll be writing your content.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ Install the SEMrush Writing Assistant plugin or add-on for your chosen platform.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ Before you start writing, define the primary keywords you want your content to rank for. SEMrush Writing Assistant will provide suggestions based on these keywords.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ Make final adjustments based on the suggestions and feedback from SEMrush Writing Assistant.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ By following these steps and tips, you can efficiently use SEMrush Writing Assistant to enhance your contents SEO performance, readability, and overall quality, ultimately driving more traffic and engagement to your website or blog.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _launchURL(Uri.parse('https://www.semrush.com/apps/ai-writing-assistant/'), true),
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
