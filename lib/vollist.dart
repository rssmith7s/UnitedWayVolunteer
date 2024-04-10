import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'designs.dart';
import 'opportunity.dart';

class VolunteerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

    // Extract all volunteers from all opportunities
    var allVolunteers = opportunities.expand((opportunity) => opportunity.volunteers).toList();

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Volunteers:',
              style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allVolunteers.length,
                itemBuilder: (context, index) {
                  var volunteer = allVolunteers[index];
                  return ListTile(
                    title: Text('${volunteer.first_name} ${volunteer.last_name}',
                    style: TextStyle(color: textColor),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone: ${volunteer.phone}',
                        style: TextStyle(color: accentColor),),
                        Text('Email: ${volunteer.email}',
                        style: TextStyle(color: accentColor),),
                      ],
                    ),
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
