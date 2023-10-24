import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class UserInfo {
  String username;
  String email;

  UserInfo(this.username, this.email);
}

class Event {
  String name;
  String description;
  String time;

  Event(this.name, this.description, this.time);
}

class Room {
  String title;
  String description;
  List<Event> events;

  Room(this.title, this.description, this.events);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? selectedCity;

  final List<String> cities = ["İstanbul", "Ankara", "İzmir"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-Posta'),
            ),
            DropdownButton<String>(
              value: selectedCity,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue;
                });
              },
              items: cities.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text;
                final email = emailController.text;
                final userInfo = UserInfo(username, email);

                if (selectedCity != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomList(
                        currentUser: userInfo,
                        selectedCity: selectedCity!,
                      ),
                    ),
                  );
                }
              },
              child: Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomList extends StatelessWidget {
  final UserInfo currentUser;
  final String selectedCity;
  final List<Room> rooms;

  RoomList({required this.currentUser, required this.selectedCity})
      : rooms = getRoomsForCity(selectedCity);

  static List<Room> getRoomsForCity(String city) {
    List<Room> rooms = [];
    if (city == "İstanbul") {
      rooms = [
        Room(
          "İstanbul Miting Alanı 1",
          "Bilgilendirme İstanbul Miting Alanı 1",
          [
            Event("Etkinlik 1", "Açıklama 1", "Saat 10:00"),
            Event("Etkinlik 2", "Açıklama 2", "Saat 14:00"),
          ],
        ),
        // Diğer oda ve etkinlikleri ekleyin
      ];
    }
    // Diğer şehirler için aynı şekilde devam edin
    return rooms;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('$selectedCity Etkinlikleri'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Bilgilendirme Odaları'),
              Tab(text: 'Profil'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RoomTab(rooms: rooms),
            UserProfile(currentUser: currentUser),
          ],
        ),
      ),
    );
  }
}

class RoomTab extends StatelessWidget {
  final List<Room> rooms;

  RoomTab({required this.rooms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(rooms[index].title),
          subtitle: Text(rooms[index].description),
          onTap: () {
            // Odaya tıklandığında yapılacak işlemleri buraya ekleyebilirsiniz.
          },
        );
      },
    );
  }
}

class UserProfile extends StatelessWidget {
  final UserInfo currentUser;

  UserProfile({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hoş geldin, ${currentUser.username}!',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

void runApp(Widget widget) {}
