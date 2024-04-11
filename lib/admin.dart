import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'designs.dart';
import 'opportunity.dart';
import 'login.dart';
import 'vollist.dart';
import 'supabase_functions.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

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
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _viewVolunteerList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VolunteerListPage()),
    );
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
            ElevatedButton(
              onPressed: _viewVolunteerList,
              child: const Text('View All Volunteers',
              style: TextStyle(color: accentColor),),
            ),
            const SizedBox(height: 16),
            const Text(
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
                      title: Text(opportunities[index].title, style: const TextStyle(color: textColor),),
                      subtitle: Text('Date: ${opportunities[index].date}', style: const TextStyle(color: accentColor),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              _acceptOpportunity(opportunities[index]);
                            },
                            color: textColor,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
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
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
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
                        style: const TextStyle(color: textColor),),
                      subtitle: Text('Date: ${opportunities[index].date}',
                        style: const TextStyle(color: accentColor)),
                      onTap: () => _viewVolunteerList(),
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
