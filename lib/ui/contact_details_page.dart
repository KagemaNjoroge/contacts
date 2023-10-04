import 'package:flutter/material.dart';

import '../models/contacts.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;
  const ContactDetails({super.key, required this.contact});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers for the text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.contact.firstName;
    _lastNameController.text = widget.contact.lastName;
    _companyController.text = widget.contact.company;
    _emailController.text = widget.contact.email;
    _phoneController.text = widget.contact.phone;
    _websiteController.text = widget.contact.website;
    _addressController.text = widget.contact.address;
    _notesController.text = widget.contact.notes;
    _photoUrlController.text = widget.contact.photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.contact.firstName} ${widget.contact.lastName}'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // validate form
              if (_formKey.currentState!.validate()) {
                // update contacts

                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // form fields go here
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.contact.photoUrl),
                    radius: 40,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    //initialValue: widget.contact.firstName,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    //initialValue: widget.contact.lastName,
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    //initialValue: widget.contact.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    //initialValue: widget.contact.company,
                    controller: _companyController,
                    decoration: const InputDecoration(
                      labelText: 'Company',
                    ),
                  ),
                  TextFormField(
                    //initialValue: widget.contact.email,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    //initialValue: widget.contact.website,
                    controller: _websiteController,
                    decoration: const InputDecoration(
                      labelText: 'Website',
                    ),
                  ),
                  TextFormField(
                    //initialValue: widget.contact.address,
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                  ),

                  TextFormField(
                    //initialValue: widget.contact.notes,
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.contact.photoUrl,
                    //controller: _photoUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Photo URL',
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
