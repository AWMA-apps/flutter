import 'package:flutter/material.dart';
import 'package:user_input/user_service.dart';

import '../user.dart';

class HomeScreen extends StatefulWidget {
 const  HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    bool isLoading = false;
    String txt = "Response";
    late Future<List<User>> _userFutureList;
    final UserService _userService = UserService();

    @override
    void initState() {
        super.initState();
        _userFutureList = _userService.fetchUsers();
    }

    void reload(){
      setState(() {
        _userFutureList = _userService.fetchUsers();
      });
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            appBar: AppBar(title: Text("Dio"),actions: [
              IconButton(onPressed: reload, icon: Icon(Icons.refresh))
            ],),
            body: FutureBuilder(future: _userFutureList,
                builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                        return SingleChildScrollView(child: Center(child: Text("Error: (${snapshot.error})\n\n",
                        selectionColor: Colors.pink,)));
                    } else if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) { 
                                final user = snapshot.data![index];
                                return Card(child: ListTile(
                                        title: Text(user.name),
                                        leading: Text("${user.id}"),
                                        subtitle: Text(user.email)
                                    ));}
                        );
                    } else {
                        return Center(child: Text("No users to load!"),);
                    }
                })
        );
    }
}
