import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:ridebhaiya/screens/Market_tools.dart';
import 'package:ridebhaiya/screens/chat_screen.dart';
import 'package:ridebhaiya/screens/chatbot_tools.dart';
import 'package:ridebhaiya/screens/See_more.dart';
import 'package:ridebhaiya/screens/logged_out.dart';
import 'package:ridebhaiya/screens/notification_settings.dart';
import 'package:ridebhaiya/screens/travel_tools.dart';
import 'package:ridebhaiya/screens/welcome_screen.dart';
import 'package:ridebhaiya/screens/wishlist_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Video_tools.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<String> _imagePaths = [
    'assets/images/homee.png',
    'assets/images/like.png',
    'assets/images/notification.png',
    'assets/images/about.png',
    'assets/images/logout.png',
    'assets/images/like.png',
  ];

  String? _fullName;

  @override
  void initState() {
    super.initState();
    _fetchUserFullName();
  }

  void _fetchUserFullName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _fullName = userDoc['full_name'];
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  void _navigateToWishlist() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WishlistScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Color(0xFF17203A),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 400),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.black,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 20.0),
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              SizedBox(height: 20.0),
              Text(
                _fullName ?? 'Loading...',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins'
                ),
              ),
              SizedBox(height: 30.0),
              ListTile(
                leading: Image.asset(_imagePaths[0], height: 45.0),
                title: Text('Home', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', letterSpacing: 2.0)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuccessScreen()),
                ),
              ),
              SizedBox(height: 30.0),
              ListTile(
                leading: Image.asset(_imagePaths[2], height: 40.0),
                title: Text('Notifications', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', letterSpacing: 2.0)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationSettingsScreen()),
                ),
              ),
              SizedBox(height: 30.0),
              ListTile(
                leading: Image.asset(_imagePaths[5], height: 47.0),
                title: Text('WishList', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', letterSpacing: 2.0)),
                onTap: _navigateToWishlist,
              ),
              SizedBox(height: 210.0),
              ListTile(
                leading: Image.asset(_imagePaths[4], height: 45.0),
                title: Text('Logout', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', letterSpacing: 2.0)),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Center(child: Text('')),
          leading: IconButton(
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: value.visible
                      ? Image.asset(
                    'assets/images/cancel.png',
                    key: ValueKey<bool>(value.visible),
                  )
                      : Image.asset(
                    'assets/images/menuu.png',
                    height: 30.0,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
            onPressed: () => _advancedDrawerController.showDrawer(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 240.0),
                child: Text(
                  'EXPLORE',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                height: 220.0,
                child: PageView(
                  controller: _pageController,
                  children: [
                    InkWell(
                      onTap: () => _launchURL(Uri.parse('https://ai.google/'), true),
                      child: Container(
                        height: 150,
                        width: 90,
                        color: Colors.blue,
                        child: Image.asset('assets/images/AIgoogle.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    InkWell(
                      onTap: () => _launchURL(Uri.parse('https://www.franksworld.com/2022/12/14/chatgpt-tutorial-a-crash-course-on-chat-gpt-for-beginners/'), true),
                      child: Container(
                        height: 150,
                        width: 90,
                        color: Colors.blue,
                        child: Image.asset('assets/images/chatgpt.webp', fit: BoxFit.cover),
                      ),
                    ),
                    InkWell(
                      onTap: () => _launchURL(Uri.parse('https://aws.amazon.com/ai/generative-ai/?trk=45539a4f-cdaa-456f-bff3-7477c3bcaa1f&sc_channel=ps&s_kwcid=AL!4422!10!72086990128092!72087527585242&ef_id=8a39e9a187be195916a58fd4fcdf87c8:G:s&msclkid=8a39e9a187be195916a58fd4fcdf87c8'), true),
                      child: Container(
                        height: 150,
                        width: 90,
                        color: Colors.blue,
                        child: Image.asset('assets/images/genAI.webp', fit: BoxFit.cover),
                      ),
                    ),
                    InkWell(
                      onTap: () => _launchURL(Uri.parse('https://be10x.in/'), true),
                      child: Container(
                        height: 150,
                        width: 90,
                        color: Colors.blue,
                        child: Image.asset('assets/images/be10x.webp', fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              SmoothPageIndicator(
                controller: _pageController,
                count: 4,
                effect: JumpingDotEffect(
                  activeDotColor: Colors.black54,
                  dotColor: Colors.grey,
                  verticalOffset: 8.0,
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                ),
                child: Container(
                  height: 58,
                  width: 230,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color
                        color: Cs.purple,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                      BoxShadow(olors.white70,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(-4, -4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "AF Chatbot",
                      style: TextStyle(color: Colors.purple, fontSize: 17, fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(right: 200.0),
                child: Text(
                  'CATEGORIES',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              InkResponse(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Category()),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 280.0),
                  child: Ink(
                    child: Text(
                      'see more',
                      style: TextStyle(fontSize: 17.0, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTaggedLottieContainer(
                          lottiePath: 'assets/animations/travel.json',
                          tag: 'Travel',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TravelTools()),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        _buildTaggedLottieContainer(
                          lottiePath: 'assets/animations/robo.json',
                          tag: 'ChatBot',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatbotTools()),
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
                          lottiePath: 'assets/animations/Marketing.json',
                          tag: 'Marketing',
                          onTap:  () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MarketTools()),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        _buildTaggedLottieContainer(
                          lottiePath: 'assets/animations/Video.json',
                          tag: 'Video Editor',
                          onTap:() => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoTools()),
                        ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaggedLottieContainer({
    required String lottiePath,
    required String tag,
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


