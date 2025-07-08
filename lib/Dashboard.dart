import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Itinerary',
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, String>> _trips = [
    {"destination": "Baguio", "date": "July 10 - July 13"},
    {"destination": "Cebu", "date": "August 5 - August 9"},
    {"destination": "Siargao", "date": "September 1 - September 4"},
  ];

  void _addNewTrip(Map<String, String> trip) {
    setState(() {
      _trips.add(trip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Itinerary'),
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Caila!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final newTrip = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTripPage()),
                  );

                  if (newTrip != null) {
                    _addNewTrip(newTrip);
                  }
                },
                icon: Icon(Icons.add),
                label: Text('Add New Trip'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade100,
                ),
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Upcoming Trips',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: _trips.length,
                itemBuilder: (context, index) {
                  final trip = _trips[index];
                  return TripCard(
                    destination: trip["destination"]!,
                    date: trip["date"]!,
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
    return Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
        leading: Icon(Icons.place, color: Colors.teal),
    title: Text(destination, style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(date),
    trailing: Icon(Icons.arrow_forward_ios),
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => TripDetailPage(
    destination: destination,
    date: date,
    ),
    ),
    );
    },
    ),
    );
  }
}

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void dispose() {
    _destinationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String destination = _destinationController.text.trim();
      String startDate = _startDateController.text.trim();
      String endDate = _endDateController.text.trim();
      String fullDate = "$startDate - $endDate";

      Map<String, String> newTrip = {
        "destination": destination,
        "date": fullDate,
      };

      Navigator.pop(context, newTrip);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Trip'),
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(
                  labelText: 'Destination',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter destination' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date (e.g. July 10)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter start date' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                  labelText: 'End Date (e.g. July 13)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter end date' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save Trip'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TripDetailPage extends StatefulWidget {
  final String destination;
  final String date;

  const TripDetailPage({
    super.key,
    required this.destination,
    required this.date,
  });

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  final _budgetController = TextEditingController();
  List<String> _photos = [];

  void _pickImage() async {
    // Simulate image adding
    setState(() {
      _photos.add('Sample Photo ${_photos.length + 1}');
    });
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.destination} Trip Details'),
          backgroundColor: Colors.lightBlue.shade100,
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: ListView(
    children: [
    Text('Trip Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Text('Destination: ${widget.destination}'),
    Text('Date: ${widget.date}'),
    SizedBox(height: 20),

    Text('Budget', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    TextFormField(
    controller: _budgetController,
    decoration: InputDecoration(
    labelText: 'Enter your budget',
    border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    ),
    SizedBox(height: 20),

    Text('Trip Photos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Wrap(
    spacing: 10,
    children: _photos.map((photo) => Chip(label: Text(photo))).toList(),
    ),
    SizedBox(height: 10),
    ElevatedButton.icon(
    onPressed: _pickImage,
    icon: Icon(Icons.photo),
    label: Text('Add Photo'),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.lightBlue.shade100,
    ),
    ),
    ],
    ),
    ),
    );
  }
}
