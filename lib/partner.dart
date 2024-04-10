import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'opportunity.dart';
import 'designs.dart';

class PartnerPage extends StatefulWidget {
  @override
  _PartnerPageState createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  TextEditingController organizationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _submitOpportunity() {
    String organization = organizationController.text.trim();
    String date = dateController.text.trim();
    String time = timeController.text.trim();
    String location = locationController.text.trim();
    String description = descriptionController.text.trim();

    if (organization.isNotEmpty &&
        date.isNotEmpty &&
        time.isNotEmpty &&
        location.isNotEmpty &&
        description.isNotEmpty) {
      VolunteerOpportunity opportunity = VolunteerOpportunity(
        organization: organization,
        date: date,
        time: time,
        location: location,
        description: description,
        status: OpportunityStatus.pending,
      );

      var opportunities = Provider.of<OpportunityNotifier>(context, listen: false);
      opportunities.opportunities.add(opportunity);
      opportunities.notifyListeners();

      organizationController.clear();
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
                      controller: organizationController,
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
                    ElevatedButton(
                      onPressed: _submitOpportunity,
                      child: Text('Submit Opportunity',
                      style: TextStyle(color: accentColor) ),
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
                            title: Text(opportunities[index].organization,
                              style: TextStyle(color: textColor),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: ${opportunities[index].date}',
                                style: TextStyle(color: textColor),),
                                Text('Location: ${opportunities[index].location}',
                                style: TextStyle(color: accentColor),),
                                Text('Description: ${opportunities[index].description}',
                              style: TextStyle(color: accentColor),),
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
        ],
      ),
    );
  }
}
