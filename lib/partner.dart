import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'opportunity.dart';
import 'designs.dart';

class PartnerPage extends StatefulWidget {
  const PartnerPage({super.key});

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
          content: const Text('Opportunity Submitted'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK',
              style: TextStyle(color: accentColor),),
            ),
         ],
       ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill in all fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK',
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
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: organizationController,
              decoration: const InputDecoration(labelText: 'Organization'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(labelText: 'Time'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitOpportunity,
              child: const Text('Submit Opportunity',
              style: TextStyle(color: accentColor) ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Accepted Opportunities:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status == OpportunityStatus.accepted) {
                    return ListTile(
                      title: Text(opportunities[index].organization,
                        style: const TextStyle(color: textColor),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${opportunities[index].date}',
                          style: const TextStyle(color: textColor),),
                          Text('Location: ${opportunities[index].location}',
                          style: const TextStyle(color: accentColor),),
                          Text('Description: ${opportunities[index].description}',
                        style: const TextStyle(color: accentColor),),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
