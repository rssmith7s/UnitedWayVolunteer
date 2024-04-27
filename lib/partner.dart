import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'opportunity.dart';
import 'designs.dart';
import 'supabase_functions.dart';
// import 'dart:io';

class PartnerPage extends StatefulWidget {
  @override
  _PartnerPageState createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // File? _imageFile;

  

  void _submitOpportunity() {
    String title = titleController.text.trim();
    String date = dateController.text.trim();
    String time = timeController.text.trim();
    String location = locationController.text.trim();
    String description = descriptionController.text.trim();
    String eventId = '';

    if (title.isNotEmpty &&
        date.isNotEmpty &&
        time.isNotEmpty &&
        location.isNotEmpty &&
        description.isNotEmpty) {
      VolunteerOpportunity opportunity = VolunteerOpportunity(
        title: title,
        date: date,
        time: time,
        location: location,
        description: description,
        eventId: eventId,
        status: OpportunityStatus.pending,
      );

      insertOpportunity(opportunity);

      var opportunities = Provider.of<OpportunityNotifier>(context, listen: false);
      opportunities.opportunities.add(opportunity);
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      opportunities.notifyListeners();

      titleController.clear();
      dateController.clear();
      timeController.clear();
      locationController.clear();
      descriptionController.clear();

      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          content: Text('Opportunity Submitted'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK',
              style: TextStyle(color: accentColor),),
            ),
         ],
       ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK',
              style: TextStyle(color: accentColor),),
            ),
          ],
        ),
      );
    }

  }

  @override
Widget build(BuildContext context) {
  var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

  return Scaffold(
    appBar: CustomAppBar(),
    body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Image.network(
              'https://unitedwayofsemo.org/wp-content/uploads/2021/04/United-Way-Logo-White.png',
              width: 100,
              height: 80,
            ),
          ),
        ),
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Organization'),
                    style: TextStyle(color: textColor),
                    cursorColor: accentColor,
                  ),
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(labelText: 'Date'),
                    style: TextStyle(color: textColor),
                    cursorColor: accentColor,
                  ),
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(labelText: 'Time'),
                    style: TextStyle(color: textColor),
                    cursorColor: accentColor,
                  ),
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                    style: TextStyle(color: textColor),
                    cursorColor: accentColor,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    style: TextStyle(color: textColor),
                    cursorColor: accentColor,
                  ),
                  SizedBox(height: 20),
                  // _buildImagePicker(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitOpportunity,
                    child: Text('Submit Opportunity', style: TextStyle(color: accentColor)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Accepted Opportunities:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: opportunities.length,
                    itemBuilder: (context, index) {
                      if (opportunities[index].status == OpportunityStatus.accepted) {
                        return ListTile(
                          title: Text(opportunities[index].title, style: TextStyle(color: textColor)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${opportunities[index].date}', style: TextStyle(color: textColor)),
                              Text('Location: ${opportunities[index].location}', style: TextStyle(color: accentColor)),
                              Text('Description: ${opportunities[index].description}', style: TextStyle(color: accentColor)),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        // Diagonal lines
        Positioned(
          top: 0,
          left: 0,
          child: CustomPaint(
            size: Size(40, 40),
            painter: DiagonalLinePainter(isBottomLeftAngle: false),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            size: Size(40, 40),
            painter: DiagonalLinePainter(isBottomLeftAngle: true),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomPaint(
            size: Size(40, 40),
            painter: DiagonalLinePainter(isBottomLeftAngle: true),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CustomPaint(
            size: Size(40, 40),
            painter: DiagonalLinePainter(isBottomLeftAngle: false),
          ),
        ),
        // Additional diagonal lines
        Positioned(
          top: 0,
          left: 0,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DiagonalLinePainter(isBottomLeftAngle: false),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DiagonalLinePainter(isBottomLeftAngle: true),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DiagonalLinePainter(isBottomLeftAngle: true),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DiagonalLinePainter(isBottomLeftAngle: false),
          ),
        ),
        ],
      ),
    );
  }
}

// Widget _buildImagePicker() {
//   return Column(
//     children: [
//       ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: 150), // Set maximum width for the button
//         child: ElevatedButton(
//           onPressed: () {
//             _pickImage(); // Always open the image picker
//           },
//           child: Text(
//             'Upload Flyer',
//             style: TextStyle(color: accentColor),
//           ),
//         ),
//       ),
//       SizedBox(height: 10),
//       if (_imageFile != null)
//         Text(
//           'Selected Image: ${_imageFile!.path}',
//           style: TextStyle(color: textColor),
//         ),
//     ],
//   );
// }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
// }

class DiagonalLinePainter extends CustomPainter {
  final bool isBottomLeftAngle;

  DiagonalLinePainter({this.isBottomLeftAngle = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = alternateColor
      ..strokeWidth = 3.0;

    if (isBottomLeftAngle) {
      canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    } else {
      canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}