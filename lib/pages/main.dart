import 'package:api_calls/api_call/api_call.dart';
import 'package:api_calls/models/user_model.dart';
import 'package:api_calls/pages/profile_page_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Call',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Users>> _usersFuture;
  Users? selectedUser;
  final TextEditingController newFilter = TextEditingController();
  List<Users> allUsers = [];
  List<Users> filteredList = [];

  @override
  void initState() {
    super.initState();
    _usersFuture = ApiCall().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Center(child: const Text('API Call & Search ', textAlign: TextAlign.center,)),
          actions: [
            SizedBox(
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(
                  controller: newFilter,
                  hintText: "...Browse Through...",
                  onChanged: searchResult,
                  leading: const Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),

        drawer: DrawerWidget(selectedUser: selectedUser),

        body: FutureBuilder<List<Users>>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No users found'));
            }

            // Initialize lists once
            if (allUsers.isEmpty) {
              allUsers = snapshot.data!;
              filteredList = allUsers;
            }

            return filteredList.isEmpty
                ? const Center(child: Text('No results match your search'))
                : ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final user = filteredList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Text(user.fullName.first),
                    title: Text(user.phone),
                    subtitle: Text(user.email),
                    tileColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () => drawerWidget(index),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void searchResult(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredList = allUsers;
      } else {
        filteredList = allUsers
            .where((user) =>
        user.fullName.first.toLowerCase().contains(query.toLowerCase()) ||
            user.fullName.last.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  //allows the drawer widget to acces the selected listTile Item
  void drawerWidget(int index) {
    setState(() {
      selectedUser = filteredList[index]; // Always from filteredList
    });
    Scaffold.of(context).openDrawer();
  }
}


