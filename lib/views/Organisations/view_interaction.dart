import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

class ViewInteraction extends StatefulWidget {
  final Organisation user;
  final Interaction element;
  final String type;
  const ViewInteraction(
      {super.key,
      required this.user,
      required this.element,
      required this.type});
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewInteraction> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Appointment? app;
    if (widget.element is Appointment) app = widget.element as Appointment;
    return Scaffold(
        appBar: Bar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Image(
                image: AssetImage('assets/images/NamedLogo.png'),
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                widget.type.capitalize(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              Text(widget.element.toString()),
              if (app!.approvalStatus == false)
                ElevatedButton(
                  onPressed: () async {
                    (widget.element as Appointment).approvalStatus = true;
                    await widget.element.updateInteraction()
                        ? setState(() {
                            (widget.element as Appointment).approvalStatus =
                                true;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Appointment Approved')));
                          })
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to Save Changes')));
                  },
                  child: const Text('Approve'),
                ),
              if (app.approvalStatus == false)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ignore'),
                ),
            ]),
          ),
        ));
  }
}
