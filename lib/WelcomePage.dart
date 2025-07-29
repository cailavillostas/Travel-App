import 'package:flutter/material.dart';
import 'package:project/MyApp.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBFDAEA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            // Title
            Text(
            'MY',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 2,
            ),
          ),
          Text(
            'TRAVEL ITINERARY',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black45,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),


            SizedBox(height: 30),

            // Better spaced photos
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildPhoto('assets/image1.jpg',
                      angle: -0.08, offset: Offset(-120, 40), zIndex: 1),
                  _buildPhoto('assets/image2.jpg',
                      angle: 0.08, offset: Offset(120, 40), zIndex: 2),
                  _buildPhoto('assets/image3.jpg',
                      angle: 0.0, offset: Offset(0, -10), zIndex: 3, isFront: true),
                ],
              ),
            ),

            SizedBox(height: 50),

            // Tap to Start Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'TAP TO START',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  // Photo with spacing, layering and border
  Widget _buildPhoto(
      String assetPath, {
        required double angle,
        required Offset offset,
        required int zIndex,
        bool isFront = false,
      }) {
    return Positioned(
      left: null,
      right: null,
      child: Transform.translate(
        offset: offset,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            height: isFront ? 140 : 120,
            width: isFront ? 170 : 140,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(assetPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}