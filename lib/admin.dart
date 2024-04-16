import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'designs.dart';
import 'opportunity.dart';
import 'login.dart';
import 'vollist.dart';
import 'supabase_functions.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  
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
  
  void _acceptOpportunity(VolunteerOpportunityDatabase opportunity) {
    updateOpportunityStatus(opportunity.title);
    Provider.of<OpportunityNotifier>(context, listen: false).notifyListeners();
  }
  void _rejectOpportunity(VolunteerOpportunityDatabase opportunity) {

    removeOpportunity(opportunity.title);
    
  }

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _viewVolunteerList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VolunteerListPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    Future<List> opportunities = getAllOpportunities();

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _viewVolunteerList,
              child: Text('View All Volunteers',
              style: TextStyle(color: accentColor),),
            ),
            SizedBox(height: 16),
            Text(
              'Pending Opportunities:',
              style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.bold, color: textColor),
            ),
            Expanded(
              child: FutureBuilder<List>(
                future: opportunities,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (snapshot.data?[index].status == false) {
                          return ListTile(
                            title: Text(snapshot.data?[index]?.title ?? '', style: TextStyle(color: textColor),),
                            subtitle: Text('Date: ${snapshot.data?[index].date}', style: TextStyle(color: accentColor),),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.check),
                                  onPressed: () {
                                    _acceptOpportunity(snapshot.data?[index]);
                                    setState(() {
                                      opportunities = getAllOpportunities();
                                    });
                                  },
                                  color: textColor,
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: (){
                                    _rejectOpportunity(snapshot.data?[index]);
                                    setState(() {
                                      opportunities = getAllOpportunities();
                                    });
                                  },
                                  color: textColor,
                                ),
                              ],
                            ),
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
            SizedBox(height: 16),
            Text(
              'Approved Opportunities:',
              style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.bold, color: textColor),
            ),
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
                              style: TextStyle(color: textColor),),
                            subtitle: Text('Date: ${snapshot.data?[index].date}',
                              style: TextStyle(color: accentColor)),
                            onTap: () => _viewVolunteerList(),
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
  } //Widget
} //Class
