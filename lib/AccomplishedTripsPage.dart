import 'package:flutter/material.dart';

class AccomplishedTripsPage extends StatelessWidget {
  final List<Map<String, dynamic>> trips;

  const AccomplishedTripsPage({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Light sky blue
      appBar: AppBar(
        title: const Text("Accomplished Trips"),
        backgroundColor: Colors.lightBlue.shade400,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: trips.isEmpty
          ? const Center(
        child: Text(
          "No accomplished trips yet.",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      )
          : ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          final activities = trip['activities'] ?? [];

          return Card(
              color: const Color(0xFFB3E5FC), // Sky blue card
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          trip['destination'] ?? '',
          style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black87,
          ),
          ),
          const SizedBox(height: 4),
          Text(
          trip['date'] ?? '',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 12),
          Text(
          "Places Visited:",
          style: TextStyle(
          color: Colors.blueAccent.shade700,
          fontWeight: FontWeight.w600,
          ),
          ),
          const SizedBox(height: 6),
          if (activities.isEmpty)
          const Text(
          "No activities added.",
          style: TextStyle(color: Colors.black54),
          )
          else
          ...activities.map<Widget>((activity) => Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Row(
          children: [
          const Icon(Icons.place, size: 16, color: Colors.blueAccent),
          const SizedBox(width: 6),
          Text(
          activity,
          style: const TextStyle(color: Colors.black87),
          ),
          ],
          ),
          )),
          ],
          ),
          ),
          );
        },
      ),
    );
  }
}