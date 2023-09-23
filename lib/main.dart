import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
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
  int _currentNav = 0;
  final List<BottomNavigationBarItem> _navs = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings_rounded), label: 'Settings'),
  ];

  final Contact _dummyUser = const Contact(
      firstName: "James Njoroge", phone: "0706076039", photoUrl: '');
  final List<Contact> _contacts = [
    const Contact(
        firstName: "James Njoroge",
        phone: "0706076039",
        photoUrl:
            'https://w7.pngwing.com/pngs/770/378/png-transparent-user-profile-icon-contact-information-s-face-head-avatar.png'),
    const Contact(firstName: "James Njoroge", phone: "0706076039"),
    const Contact(firstName: "James Njoroge", phone: "0706076039"),
    const Contact(
      firstName: "Baby Girl",
      phone: "0742136231",
    ),
    // Add more contacts here...
  ];
  List<Contact> _searchContacts = []; // Updated search results list

  // ... Other widget methods ...
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
              offset: const Offset(0, 3), // changes position of shadow
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
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
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
                setState(() {
                  _searchContacts = _contacts.where((contact) {
                    final fullName = '${contact.firstName} ${contact.lastName}'
                        .toLowerCase();
                    final phoneNumber = contact.phone.toLowerCase();
                    return fullName.contains(value.toLowerCase()) ||
                        phoneNumber.contains(value.toLowerCase());
                  }).toList();
                });
              },
            ),
          ),
          userProfileCard(_dummyUser),
          Expanded(
            child: ListView.builder(
              itemCount: _searchContacts.isEmpty
                  ? _contacts.length
                  : _searchContacts.length,
              itemBuilder: (context, index) {
                // Use _searchContacts if there are search results, otherwise, use _contacts
                final contact = _searchContacts.isEmpty
                    ? _contacts[index]
                    : _searchContacts[index];
                return contactTile(contact);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentNav = value;
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
                                  onPressed: () {
                                    //TODO: Call contact
                                  },
                                  icon: const Icon(Icons.call),
                                ),
                                IconButton(
                                  onPressed: () {
                                    //TODO: Message contact
                                  },
                                  icon: const Icon(Icons.message),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // TODO: Video call contact
                                  },
                                  icon: const Icon(Icons.video_call),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            // if photoUrl is empty, show a placeholder as the leading icon
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

void main(List<String> args) {
  runApp(const Application());
}

class Contact {
  final String firstName;
  final String lastName;
  final String company;
  final String photoUrl;
  final String email;
  final String phone;
  final String website;
  final String address;
  final String notes;

  const Contact({
    required this.firstName,
    this.lastName = '',
    this.company = '',
    this.email = '',
    required this.phone,
    this.website = '',
    this.address = '',
    this.notes = '',
    this.photoUrl = '',
  });

  factory Contact.fromJson(Map<String, String> json) {
    return Contact(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      company: json['company'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      address: json['address'] ?? '',
      notes: json['notes'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }
  Map<String, String> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'company': company,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address,
      'notes': notes,
    };
  }
}

class ContactDetails extends StatefulWidget {
  final Contact contact;
  const ContactDetails({super.key, required this.contact});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.contact.firstName} ${widget.contact.lastName}'),
        centerTitle: true,
      ),
    );
  }
}

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        centerTitle: true,
      ),
    );
  }
}
