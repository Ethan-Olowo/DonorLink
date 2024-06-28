import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Organisations/add_financial.dart';
import 'package:donorlink/views/Organisations/view_financial.dart';
import 'package:flutter/material.dart';

class ViewFinancials extends StatefulWidget {
  final Organisation user;
  final bool requests;
  const ViewFinancials({super.key, required this.user, required this.requests,});

    @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewFinancials> {
  String _searchText = "";
  late Future<List<Financial>> _financialsFuture;

  Future<void> _reloadFinancials() async {
    setState(() {
      _financialsFuture = widget.user.getFinancials();
    });
  }
  @override
  void initState() {
    super.initState();
    _financialsFuture = widget.user.getFinancials(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.requests? const Text('View Financial Requests'):const Text('View Financials'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadFinancials,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Date',
                prefixIcon: Icon(Icons.search),
              ),
              // Update _searchText on user input change
              onChanged: (text) { 
                setState(() {
                  _searchText = text;
                });
              },
            ),
            if(widget.requests== false) ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddFinancialPage(organisation: widget.user,),),
                );
              }, 
              child: const Text('Upload Financial'),
            ),
            Expanded(
              child: FutureBuilder<List<Financial>>(
                future: _financialsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Financial documents found.'));
                  }

                  List<Financial> fins = snapshot.data!;
                  widget.requests?  fins = fins.where((element) => element.location == '').toList():fins = fins.where((element) => element.location != ''&& element.location != null).toList();
                  fins = fins.where((fin) =>
                  fin.getDate().toLowerCase().contains(_searchText.toLowerCase())).toList();

                  return ListView.builder(
                    itemCount: fins.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${fins[index].getDate()}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FinancialDocument(user: widget.user, fin: fins[index],),),
                            );
                          },
                        ),
                      );
                    },
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
