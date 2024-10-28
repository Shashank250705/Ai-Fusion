import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ridebhaiya/screens/Home_Screen.dart';
import 'package:ridebhaiya/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _textFadeController;
  late Animation<double> _textFadeAnimation;
  late AudioPlayer _audioPlayer;
  bool _showText = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _textFadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _textFadeAnimation = CurvedAnimation(
      parent: _textFadeController,
      curve: Curves.elasticIn,
    );

    _audioPlayer = AudioPlayer();

    // Start the animation
    _animationController.forward();

    // Show the text after the animation is complete
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showText = true;
        });

        // Play the sound effect
        _playSound();

        // Start the fade-in animation for the text
        _textFadeController.forward();

        // Navigate to the home screen after a delay
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WelcomeScreen()), // Change HomeScreen to your actual home screen widget
          );
        });
      }
    });
  }

  void _playSound() async {
    await _audioPlayer.play(AssetSource('assets/audio/Robo.mp3')); // Change this to your actual sound file
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textFadeController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a1a),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_showText)
              Lottie.asset(
                'assets/animations/Ai.json', // Change this to your actual Lottie animation file
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController.duration = composition.duration;
                },
              ),
            if (_showText)
              FadeTransition(
                opacity: _textFadeAnimation,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/AiFusion.webp', // Change this to your actual image file
                    width: 300, // Adjust the width as needed
                    height: 300, // Adjust the height as needed
                    fit: BoxFit.cover, // Ensures the image fits within the circle
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
