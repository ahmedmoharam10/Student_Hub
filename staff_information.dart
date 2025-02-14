import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StaffInformationPage extends StatefulWidget {
  @override
  State<StaffInformationPage> createState() => _StaffInformationPageState();
}

class _StaffInformationPageState extends State<StaffInformationPage> {
  List<Map<String, dynamic>> staffData = [];
  List<Map<String, dynamic>> filteredStaffData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse("http://192.168.0.105/student_guide_api/select_staff.php"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          staffData = List<Map<String, dynamic>>.from(data);
          filteredStaffData = staffData; // Initialize filtered data with all staff members
        });
      } else {
        print("Failed to fetch data from server");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void filterStaff(String query) {
    setState(() {
      filteredStaffData = staffData.where((staff) =>
          staff["Type"] == 'TA'
              ? staff["TA_Name"].toLowerCase().contains(query.toLowerCase())
              : staff["P_Name"].toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Information'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                filterStaff(value);
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search for TA or Professor...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStaffData.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(
                      filteredStaffData[index]["Type"] == 'TA' ? filteredStaffData[index]["TA_Name"] : filteredStaffData[index]["P_Name"],
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${filteredStaffData[index]["Type"] == 'TA' ? filteredStaffData[index]["TA_Email"] : filteredStaffData[index]["P_Email"]}'),
                        Text('Room: ${filteredStaffData[index]["Room_Num"]}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
