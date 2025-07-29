import 'package:flutter/material.dart';

class TripDetailsPage extends StatefulWidget {
  final Map<String, dynamic> trip;

  const TripDetailsPage({super.key, required this.trip});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  void _addPlaceVisited() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Place Visited"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter place or activity"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newPlace = controller.text.trim();
              if (newPlace.isNotEmpty) {
                setState(() {
                  widget.trip['activities'].add(newPlace);
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    final activities = trip['activities'] as List;

    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Light blue background
      appBar: AppBar(
        title: Text(trip['destination']),
        backgroundColor: Colors.lightBlue.shade400,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📅 Date: ${trip['date']}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text("📍 Places Visited:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: activities.isEmpty
                  ? const Center(child: Text("No places added yet."))
                  : ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.place),
                  title: Text(activities[index]),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addPlaceVisited,
              icon: const Icon(Icons.add_location_alt),
              label: const Text("Add Place Visited"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}