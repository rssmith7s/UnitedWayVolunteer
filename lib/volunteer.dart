import 'package:flutter/material.dart';
import 'supabase_functions.dart';
import 'opportunity.dart';
import 'event.dart';
import 'designs.dart';

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {

  Future<List<VolunteerOpportunityDatabase>> getAllOpportunities() async {
    List<VolunteerOpportunityDatabase> opportunitiesdb = [];
    List tableData = await fetchData('event_table');
    for (var i = 0; i < tableData.length; i++) {
    VolunteerOpportunityDatabase opportunitydb = VolunteerOpportunityDatabase(
      title: tableData[i]['title'],
      date: tableData[i]['date'],
      time: tableData[i]['time'],
      location: tableData[i]['location'],
      description: tableData[i]['description'],
      eventId: tableData[i]['event_id'],
      status: tableData[i]['status'],
    );
    opportunitiesdb.add(opportunitydb);
    
    }
    
    return opportunitiesdb;
  }

  @override
  Widget build(BuildContext context) {
    // var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;
    Future<List> opportunities = getAllOpportunities();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List>(
                future: opportunities,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data?[index].status == true) {
                          return ListTile(
                            title: Text(snapshot.data?[index].title,
                              style: TextStyle(color: textColor)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: ${snapshot.data?[index].date}',
                                  style: TextStyle(color: accentColor)),
                                Text('Location: ${snapshot.data?[index].location}',
                                  style: TextStyle(color: accentColor)),
                                Text('Description: ${snapshot.data?[index].description}',
                                  style: TextStyle(color: accentColor)),
                              ],
                            ),
                            onTap: () {
                              // Navigate to the details page when the event is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventDetailsPage(opportunity: snapshot.data?[index]),
                                ),
                              );
                            },
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // While data is loading:
                        return CircularProgressIndicator();
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
