import 'package:flutter/material.dart';
import 'path_to_user_model.dart';
import 'path_to_user_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserPage(),
    );
  }
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserController _userController = UserController();
  List<User> _users = [];
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  _refreshUserList() async {
    List<User> x = await _userController.getAllUsers();
    setState(() {
      _users = x;
    });
  }

  _onSubmit() async {
    var user = User(name: _nameController.text, email: _emailController.text);
    int id = await _userController.addUser(user);
    user.id = id;
    setState(() {
      _users.add(user);
    });
    _nameController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SQLite'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshUserList,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _form(),
            _list(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Bạn có thể thêm chức năng cho nút này, như mở một màn hình thêm người dùng mới
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  _form() => Container(
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Column(
      children: <Widget>[
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _onSubmit,
          child: Text('Submit'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
        ),
      ],
    ),
  );

  _list() => Container(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _users.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(_users[index].name),
            subtitle: Text(_users[index].email),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await _userController.deleteUser(_users[index].id);
                _refreshUserList();
              },
            ),
          ),
        );
      },
    ),
  );
}
