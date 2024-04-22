import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'supabase_functions.dart';
import 'designs.dart';
import 'opportunity.dart';

class SpecificVolunteerListPage extends StatelessWidget {

  final String eventId;

  SpecificVolunteerListPage({required this.eventId});

  //displays all volunteers for a specific event
  Future<List<Volunteer>> getAllVolunteers(String eventId) async {
    List<Volunteer> volunteersdb = [];
    List tableData = await fetchSpecificVolunteers('user_table', eventId); //fetches volunteers for a specific event
    for (var i = 0; i < tableData.length; i++) {
    Volunteer volunteerdb = Volunteer( //creates a new Volunteer object
      first_name: tableData[i]['first_name'],
      last_name: tableData[i]['last_name'],
      phone: tableData[i]['phone'],
      email: tableData[i]['email'],
      category: tableData[i]['category'],
      eventId: tableData[i]['event_id'],
    );
    volunteersdb.add(volunteerdb);  //adds the new volunteer to the list of volunteers
    print(volunteerdb);
    }
    
    return volunteersdb;
  }

  
  @override
  Widget build(BuildContext context) {
    Future<List> volunteers = getAllVolunteers(eventId);
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

    // Extract all volunteers from all opportunities
    var allVolunteers = volunteers;

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
              child: FutureBuilder<List>(
                future: volunteers,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var volunteer = snapshot.data?[index];
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
