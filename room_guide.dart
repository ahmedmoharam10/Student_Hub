import 'package:flutter/material.dart';
import 'package:student_guide/main.dart';

class RoomGuidePage extends StatefulWidget {
  @override
  _RoomGuidePageState createState() => _RoomGuidePageState();
}

class _RoomGuidePageState extends State<RoomGuidePage> {
 List<Map<String, dynamic>> _rooms = [
  { "Room Number": 128,"Building":"A","Floor": 1, "Image": "128.jpg"},
  { "Room Number": 129,"Building":"A","Floor": 1, "Image": "129.jpg"},
  { "Room Number": 229,"Building":"A","Floor": 2, "Image": "229.jpg"},
  { "Room Number": 230,"Building":"A","Floor": 2, "Image": "230.jpg"},
];
List<Map<String, dynamic>> _foundRooms = [];

  @override
  void initState() {
    _foundRooms = _rooms;
    super.initState(); 
  }
  void _runFilter(String enteredKeyword) {
  List<Map<String, dynamic>> _Results = [];
  if (enteredKeyword.isEmpty) {
    _Results = _rooms;
  } else {
    _Results = _rooms
      .where((room) =>
          room["Room Number"].toString().toLowerCase().contains(enteredKeyword.toLowerCase()))
      .toList();
  }

  if (_Results.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('No rooms found for your search.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  } else {
    setState(() {
      _foundRooms = _Results;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room Guide'),),
      body: Padding(
        padding: const EdgeInsets.all(10.0), 
        child: Column(children: [
          const SizedBox(height: 20),
          TextField(
            onChanged:(value) => _runFilter(value),
            decoration: InputDecoration(
              labelText: 'Search', 
              suffixIcon: Icon(Icons.search)
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _foundRooms.length,
              itemBuilder:(context, index) => Card(
                key: ValueKey(_foundRooms[index]["Room Number"]),
                color: Colors.blue,
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogWidget(image: _foundRooms[index]["Image"]);
                      }
                    );
                  },
                  child: ListTile(
                    title: Text(
                      _foundRooms[index]['Room Number'].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Building:${_foundRooms[index]["Building"].toString()}, Floor: ${_foundRooms[index]["Floor"].toString()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomDialogWidget extends StatelessWidget {
  final String image;
  const CustomDialogWidget({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(10), // Adjust this value to change the dialog size
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff2A303), 
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center( // Center the image
              child: Image.asset(image,
                width: 400, // Increase the width of the image
                fit: BoxFit.cover, // Maintain the aspect ratio of the image
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Floor Plan',
                style: TextStyle(fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

