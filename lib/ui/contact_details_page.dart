import 'package:flutter/material.dart';

import '../models/contacts.dart';

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
