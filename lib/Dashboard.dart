import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRAVEL ITENARY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF05506D), // Sky blue BG
        primarySwatch: Colors.lightBlue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue.shade200,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
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
  final List<Map<String, String>> _trips = [
    {"destination": "Baguio", "date": "July 10 - July 13"},
    {"destination": "Cebu",   "date": "August 5 - August 9"},
    {"destination": "Siargao","date": "September 1 - September 4"},
  ];

  void _addNewTrip(Map<String, String> trip) {
    setState(() => _trips.insert(0, trip));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100, // full-screen blue
      appBar: AppBar(title: const Text('Travel Itinerary')),
      body: Container(
        color: Colors.lightBlue.shade50, // body area
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome, Caila!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final newTrip = await Navigator.push<Map<String, String>>(
                      context,
                      MaterialPageRoute(builder: (_) => const AddTripPage()),
                    );
                    if (newTrip != null) _addNewTrip(newTrip);
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Add New Trip'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Upcoming Trips',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _trips.isEmpty
                    ? const Center(child: Text('No trips yet.', style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                  itemCount: _trips.length,
                  itemBuilder: (context, index) {
                    final trip = _trips[index];
                    return TripCard(
                      destination: trip['destination']!,
                      date: trip['date']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final String destination;
  final String date;
  const TripCard({
    super.key,
    required this.destination,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.lightBlue.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue.shade200,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.place, color: Colors.blue),
        title: Text(
          destination,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        subtitle: Text(
          date,
          style: const TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }
}

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _startDateController   = TextEditingController();
  final _endDateController     = TextEditingController();

  @override
  void dispose() {
    _destinationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final dest = _destinationController.text.trim();
      final start = _startDateController.text.trim();
      final end   = _endDateController.text.trim();
      Navigator.pop(context, {"destination": dest, "date": "$start - $end"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC),
      appBar: AppBar(title: const Text('Add New Trip')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _destinationController,
                    decoration: const InputDecoration(labelText: 'Destination'),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _startDateController,
                    decoration: const InputDecoration(labelText: 'Start Date'),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _endDateController,
                    decoration: const InputDecoration(labelText: 'End Date'),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Trip'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue.shade300,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      shadowColor: Colors.lightBlue.shade200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
