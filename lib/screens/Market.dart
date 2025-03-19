import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'wishlist_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key, this.page = 'login', required this.onItemRemoved});
  final String page;
  final Function(String) onItemRemoved;

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  bool _isLiked = false;
  final String _toolName = 'Robin';

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

  // Save like status to SharedPreferences for login
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
                          ' Robin AI is a leader in legal AI, offering a Legal AI Assistant used by businesses worldwide to streamline contract processes. It empowers legal teams to make drafting and negotiating contracts effortless, aiming for a world where law moves at the speed of business. Additionally, Robin AI includes a marketing tool designed to optimize and automate marketing tasks, including campaign management, customer engagement, and analytics',
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
                          '➔  Set clear goals for your marketing campaigns, such as increasing sales, generating leads, or boosting brand awareness.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔  Use Robin AI to segment your audience based on demographics, behavior, and preferences.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '➔ Utilize Robin’s AI to generate ad copy, images, and other creative elements. The tool can suggest optimal formats and messaging for different platforms.',
                          style: TextStyle(fontSize: 17.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _launchURL(Uri.parse('https://www.robinai.com/'), true),
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
