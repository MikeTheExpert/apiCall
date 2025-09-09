import 'package:api_calls/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DrawerWidget extends StatelessWidget {
  final Users? selectedUser;
  final double widgetHeight = 20;
  const DrawerWidget({super.key, required this.selectedUser});

  String returnDateOfBirth() {
    String dob = selectedUser!.dob.date;
    DateTime date = DateTime.parse(dob);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:
          selectedUser == null
              ? const Center(child: Text('Select a user'))
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${selectedUser!.fullName.first} ${selectedUser!.fullName.last}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                          selectedUser!.picture.thumbnail.startsWith('http')
                              ? NetworkImage(selectedUser!.picture.medium)
                              : AssetImage(selectedUser!.picture.thumbnail)
                                  as ImageProvider,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widgetHeight,
                      child: Text(
                        'Gender: ${selectedUser!.gender.toUpperCase()}',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widgetHeight,
                      child: Text('Date of Birth: ${returnDateOfBirth()}'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widgetHeight,
                      child: Text('Age: ${selectedUser!.dob.age.toString()}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widgetHeight,
                      child: Text('Cell No.: ${selectedUser!.cell}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widgetHeight,
                      child: Text('Country ${selectedUser!.location.country}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widgetHeight,
                      child: Text('State: ${selectedUser!.location.state}'),
                    ),
                  ),
                ],
              ),
    );
  }
}

// CircleAvatar(
//   radius: 30,
//   backgroundImage: NetworkImage(selectedUser!.picture.thumbnail),
//   backgroundColor: Colors.blue,
// ),
