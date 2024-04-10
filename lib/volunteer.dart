import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'opportunity.dart';
import 'event.dart';
import 'designs.dart';

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: opportunities.length,
                    itemBuilder: (context, index) {
                      if (opportunities[index].status == OpportunityStatus.accepted) {
                        return ListTile(
                          title: Text(opportunities[index].organization,
                            style: TextStyle(color: textColor)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${opportunities[index].date}',
                                style: TextStyle(color: accentColor)),
                              Text('Location: ${opportunities[index].location}',
                                style: TextStyle(color: accentColor)),
                              Text('Description: ${opportunities[index].description}',
                                style: TextStyle(color: accentColor)),
                            ],
                          ),
                          onTap: () {
                            // Navigate to the details page when the event is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailsPage(opportunity: opportunities[index]),
                              ),
                            );
                          },
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
