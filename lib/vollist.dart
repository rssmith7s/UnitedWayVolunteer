import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'designs.dart';
import 'opportunity.dart';

class VolunteerListPage extends StatelessWidget {
  const VolunteerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

    // Extract all volunteers from all opportunities
    var allVolunteers = opportunities.expand((opportunity) => opportunity.volunteers).toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
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
                    style: const TextStyle(color: textColor),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone: ${volunteer.phone}',
                        style: const TextStyle(color: accentColor),),
                        Text('Email: ${volunteer.email}',
                        style: const TextStyle(color: accentColor),),
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
