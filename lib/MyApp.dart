import 'package:flutter/material.dart';
import 'AccomplishedTripsPage.dart';
import 'TripDetailsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Itinerary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:  const Color(0xFF6CAEE5), // Sky blue background
        primarySwatch: Colors.lightBlue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue.shade600,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> _trips = [
    {
      "destination": "Baguio",
      "date": "July 10 - July 13",
      "activities": [],
    },
    {
      "destination": "Cebu",
      "date": "August 5 - August 9",
      "activities": [],
    },
  ];

  List<Map<String, dynamic>> _accomplishedTrips = [];

  void _addNewTrip(Map<String, dynamic> trip) {
    setState(() => _trips.insert(0, trip));
  }

  void _markAsAccomplished(int index) {
    setState(() {
      final accomplished = _trips.removeAt(index);
      _accomplishedTrips.insert(0, accomplished);
    });
  }

  void _deleteTrip(int index) {
    setState(() {
      _trips.removeAt(index);
    });
  }

  void _showAddTripForm() {
    final destinationController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.lightBlue[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          'Add New Trip',
          style: TextStyle(color: Colors.blueAccent),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: destinationController,
              decoration: InputDecoration(
                labelText: 'Place Visited',
                labelStyle: const TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
            ),
            onPressed: () {
              final destination = destinationController.text.trim();
              final date = dateController.text.trim();
              if (destination.isNotEmpty && date.isNotEmpty) {
                _addNewTrip({
                  'destination': destination,
                  'date': date,
                  'activities': [],
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _openAccomplishedTrips() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AccomplishedTripsPage(trips: _accomplishedTrips),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel Itinerary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            tooltip: "View Accomplished Trips",
            onPressed: _openAccomplishedTrips,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTripForm,
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Welcome, Caila!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Upcoming Trips",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _trips.length,
                itemBuilder: (context, index) {
                  final trip = _trips[index];
                  return Card(
                    color: const Color(0xFFB3E5FC), // Sky blue card
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        trip['destination'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                      ),
                      subtitle: Text(
                        trip['date'],
                        style: const TextStyle(color: Colors.black54),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TripDetailsPage(trip: trip),
                          ),
                        );
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            tooltip: "Mark as Accomplished",
                            onPressed: () => _markAsAccomplished(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: "Delete Trip",
                            onPressed: () => _deleteTrip(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}