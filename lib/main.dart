
import 'package:api_calls/api_call/api_call.dart';
import 'package:api_calls/models/user_model.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Users> users =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('home Page'),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index){
            final user = users[index];
            final email = user.email;
            final phone = user.phone;
            final name = user.fullName.last;
            //demo code
            final corpName = user.fullName.toString();

            return ListTile(
              leading: Column(
                children: [
                  Text(name),
                  Text(corpName),
                ],
              ),
              title: Text(phone),
              subtitle: Text(email),
            );
          },
          itemCount: users.length,
        ),
      ),
    );
  }

  Future fetchUser() async{
    final response = await ApiCall().fetchUsers();
    return setState(() {
      users = response;
    });
  }
}
