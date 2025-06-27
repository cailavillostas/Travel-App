import 'package:flutter/material.dart';

void main() {
  runApp(TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel Itinerary',
      debugShowCheckedModeBanner: false,
      home: TravelHomePage(),
    );
  }
}


class TravelHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F5F2), // soft beige background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title Section
            Text(
              'MY TRAVEL ITINERARY',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),

            // Image Stack Section
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 30,
                  child: Transform.rotate(
                    angle: -0.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150),
                        topRight: Radius.circular(150),
                      ),
                      child: Image.asset(
                        'assets/image1.jpg',
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  child: Transform.rotate(
                    angle: 0.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150),
                        topRight: Radius.circular(150),
                      ),
                      child: Image.asset(
                        'assets/image2.jpg',
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/image3.jpg',
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            // Start Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent.shade100,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: StadiumBorder(),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Travel()),
                );
              },
              child: Text(
                'Tap to Start',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Travel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Itenary'),
        backgroundColor: Colors.lightBlueAccent.shade100,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: Text(
          'Welcome to your Travel Itinerary!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}