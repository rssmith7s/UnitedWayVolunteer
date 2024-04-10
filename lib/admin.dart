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
  
  void _acceptOpportunity(VolunteerOpportunity opportunity) {
    updateOpportunityStatus(opportunity.title);
    opportunity.status = OpportunityStatus.accepted;
    Provider.of<OpportunityNotifier>(context, listen: false).notifyListeners();
  }
  void _rejectOpportunity(VolunteerOpportunity opportunity) {
    opportunity.status = OpportunityStatus.rejected;
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
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

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
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status == OpportunityStatus.pending) {
                    return ListTile(
                      title: Text(opportunities[index].title, style: TextStyle(color: textColor),),
                      subtitle: Text('Date: ${opportunities[index].date}', style: TextStyle(color: accentColor),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              _acceptOpportunity(opportunities[index]);
                            },
                            color: textColor,
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: (){
                              _rejectOpportunity(opportunities[index]);
                              setState(() {
                                opportunities.removeAt(index);
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
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Approved Opportunities:',
              style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status == OpportunityStatus.accepted) {
                    return ListTile(
                      title: Text(opportunities[index].title,
                        style: TextStyle(color: textColor),),
                      subtitle: Text('Date: ${opportunities[index].date}',
                        style: TextStyle(color: accentColor)),
                      onTap: () => _viewVolunteerList(),
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
    );
  }
}
