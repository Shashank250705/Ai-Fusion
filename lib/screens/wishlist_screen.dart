import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Chatbot.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<String> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  // Load wishlist from SharedPreferences
  void _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      wishlistItems = prefs.getStringList('wishlistItems') ?? [];
    });
  }

  // Remove item from wishlist and update like status
  void _removeFromWishlist(String item) async {
    final prefs = await SharedPreferences.getInstance();
    wishlistItems.remove(item);
    await prefs.setStringList('wishlistItems', wishlistItems);
    _updateLikeStatus(item, false);
    setState(() {});
  }

  // Update the like status for a specific item
  void _updateLikeStatus(String item, bool isLiked) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLiked_$item', isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist', style: TextStyle(fontFamily: 'Poppins', color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: wishlistItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 12,
                shadowColor: Colors.black87,
                child: ListTile(
                  title: Text(
                    wishlistItems[index],
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      _removeFromWishlist(wishlistItems[index]);
                      Fluttertoast.showToast(
                          msg: 'Removed from wishlist',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
