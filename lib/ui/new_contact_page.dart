import 'package:flutter/material.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  Widget _newContactForm() {
    return Form(
        child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 32, left: 10),
              child: CircleAvatar(
                radius: 30,
                child: IconButton(
                    onPressed: () {
                      // TODO: pick photo
                    },
                    icon: const Icon(Icons.add_a_photo_outlined)),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Last Name', border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Company', border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Email', border: OutlineInputBorder()),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Website', border: OutlineInputBorder()),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Address', border: OutlineInputBorder()),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Notes', border: OutlineInputBorder()),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _newContactForm(),
        ),
      ),
    );
  }
}
