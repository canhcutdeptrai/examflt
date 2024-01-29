import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('AppBar', textAlign: TextAlign.left,),
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 120,
                width: double.infinity,
              ),
              TabBar(
                tabs: [
                  Tab(text: 'tab bar 1'),
                  Tab(text: 'tab bar 2'),
                  Tab(text: 'tab bar 3'),
                ],
              ),
              buildCardView(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardView() {
    // Đây giờ là một widget riêng lẻ không còn trong TabBarView
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: buildCard(),
          ),
          Expanded(
            child: buildCard(),
          ),
        ],
      ),
    );
  }

  Card buildCard() {
    // Code cho buildCard() giữ nguyên như trước
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: double.infinity,
        height: 120.0,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Image.network(
              'https://placekitten.com/200/200',
              width: double.infinity,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Short content',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
