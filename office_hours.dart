import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OfficeHoursPage extends StatefulWidget {
  const OfficeHoursPage({super.key});

  @override
  State<OfficeHoursPage> createState() => _OfficeHoursPageState();
}

class _OfficeHoursPageState extends State<OfficeHoursPage> {
  List<Map<String, dynamic>> _allOfficeHours = [];
  List<Map<String, dynamic>> _foundOfficeHours = [];

  @override
  void initState() {
    super.initState();
    // Fetch office hours data when the widget is initialized
    getOfficeHours();
  }

  Future<void> getOfficeHours() async {
    final response = await http.get(Uri.parse('http://192.168.0.105/student_guide_api/select_officehours.php'));
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _allOfficeHours = data.cast<Map<String, dynamic>>();
        _foundOfficeHours = _allOfficeHours;
      });
    } else {
      // If the server did not return a 200 OK response, throw an error.
      throw Exception('Failed to load office hours');
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allOfficeHours;
    } else {
      results = _allOfficeHours
          .where((officeHour) =>
              officeHour["TA_Name"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              officeHour["P_Name"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              officeHour["Days"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              officeHour["Times"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundOfficeHours = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Office Hours')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: _foundOfficeHours.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundOfficeHours[index]["id"]),
                  color: Colors.blue,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(
                      'TA Name: ${_foundOfficeHours[index]["TA_Name"].toString()}, '
                      'Professor Name: ${_foundOfficeHours[index]["P_Name"].toString()}, '
                      'Days: ${_foundOfficeHours[index]["Days"].toString()}, '
                      'Times: ${_foundOfficeHours[index]["Times"].toString()}',
                      style: const TextStyle(color: Colors.white),
                    ),
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
