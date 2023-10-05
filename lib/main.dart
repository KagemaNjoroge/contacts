import 'package:contacts/services/contacts_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ideas/home.dart';
import 'models/contacts.dart';
import 'ui/contact_details_page.dart';
import 'ui/new_contact_page.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IdeaPage(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<BottomNavigationBarItem> _navs = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings_rounded), label: 'Settings'),
  ];

  final Contact _dummyUser = const Contact(
      firstName: "James Njoroge", phone: "0706076039", photoUrl: '');

  Future<List<Contact>> _getContacts() async {
    // database service

    return await ContactDatabaseService().retrieveAllContacts();
  }

  Widget userProfileCard(Contact user) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('My Info',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (user.photoUrl.isEmpty)
                      Image.asset('assets/default_contact.png',
                          width: 160, height: 160)
                    else
                      Image.network(user.photoUrl, width: 160, height: 160),
                    const SizedBox(height: 10),
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.phone,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContactDetails(contact: user)));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              );
            });
      },
      child: Container(
        height: 150,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // if photoUrl is empty, show a placeholder
            if (user.photoUrl.isEmpty)
              Image.asset('assets/default_contact.png', width: 80, height: 80)
            else
              Image.network(user.photoUrl, width: 80, height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "My Card",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('iContacts'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewContactPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
              onPressed: () async {
                List<Contact> contacts =
                    await ContactDatabaseService().retrieveAllContacts();
                for (var cont in contacts) {
                  print(cont.toJson());
                }
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          // search bar
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              showCursor: false,
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gapPadding: 0),
              ),
              onChanged: (value) {
                // Update search results based on the search query
                setState(() {});
              },
            ),
          ),
          userProfileCard(_dummyUser),
          FutureBuilder(
            future: _getContacts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return contactTile(snapshot.data![index]);
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: _navs,
      ),
    );
  }

  Widget contactTile(Contact contact) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactDetails(contact: contact),
            ),
          );
        },
        child: ListTile(
          leading: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        contact.firstName,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (contact.photoUrl.isEmpty)
                            Image.asset('assets/default_contact.png',
                                width: 80, height: 80)
                          else
                            Image.network(contact.photoUrl,
                                width: 80, height: 80),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        contact.phone);
                                  },
                                  icon: const Icon(Icons.call),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final Uri smsUri = Uri(
                                      scheme: 'sms',
                                      path: contact.phone,
                                    );
                                    if (await canLaunchUrl(smsUri)) {
                                      await launchUrl(smsUri);
                                    } else {
                                      // show error dialog
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                                title: Text('Error'),
                                                content:
                                                    Text('Could not send SMS'));
                                          });
                                    }
                                  },
                                  icon: const Icon(Icons.message),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // TODO: Video call contact
                                  },
                                  icon: const Icon(Icons.video_call),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // TODO: Share contact
                                  },
                                  icon: const Icon(Icons.share),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            icon: contact.photoUrl.isEmpty
                ? CircleAvatar(
                    radius: 20,
                    child: Image.asset('assets/default_contact.png', width: 30),
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundImage: Image.network(
                      contact.photoUrl,
                      width: 30,
                    ).image,
                  ),
          ),
          title: Text(
            '${contact.firstName} ${contact.lastName}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            contact.phone,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetails(contact: contact),
              ),
            );
          },
        ));
  }
}

Future<void> main(List<String> args) async {
  // initialize firebase
  //WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const Application());
}
