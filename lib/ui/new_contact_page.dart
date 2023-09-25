import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _photoUrl;

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<bool> _uploadImageToFirebase(String filePath) async {
    //TODO: upload image to firebase
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.close,
              size: 20,
            ),
            onPressed: () {
              //check if person had entered any data
              if (_formKey.currentState!.validate()) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text('Discard Contact?'),
                          content: const Text(
                              'If you go back now, all the information you have entered will be lost.'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Discard')),
                          ]);
                    });
              } else {
                Navigator.pop(context);
              }
            }),
        title: const Text('New Contact'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                var firstName = _firstNameController.text;
                var lastName = _lastNameController.text.isEmpty
                    ? ''
                    : _lastNameController.text;
                var phoneNumber = _phoneController.text;
                var address = _phoneController.text.isEmpty
                    ? ''
                    : _addressController.text;
                var website = _websiteController.text.isEmpty
                    ? ''
                    : _websiteController.text;
                var notes =
                    _notesController.text.isEmpty ? '' : _notesController.text;
                var company = _companyController.text.isEmpty
                    ? ''
                    : _companyController.text;
                var email =
                    _emailController.text.isEmpty ? '' : _emailController.text;
              }
            },
            icon: const Icon(
              Icons.done,
              size: 20,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
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
                                  //bottom sheet, camera or gallery
                                  ScaffoldMessenger.of(context)
                                      .showMaterialBanner(MaterialBanner(
                                          content: const Text(
                                              'Select an image from the gallery or take a picture'),
                                          actions: [
                                        TextButton(
                                            onPressed: () async {
                                              // image picker from camera
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                              var image = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              setState(() {
                                                _photoUrl = image!.path;
                                              });
                                              print(_photoUrl ?? '');
                                            },
                                            child: const Text('Camera')),
                                        TextButton(
                                            onPressed: () async {
                                              // image picker from gallery
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                              var image = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (image != null) {
                                                setState(() {
                                                  _photoUrl = image.path;
                                                });
                                                bool response =
                                                    await _uploadImageToFirebase(
                                                        image.path);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'No image selected')));
                                              }
                                            },
                                            child: const Text('Gallery')),
                                        IconButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            icon: const Icon(Icons.close))
                                      ]));
                                },
                                icon: const Icon(Icons.add_a_photo_outlined)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'First Name',
                                    ),
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
                                    controller: _lastNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Last Name',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context).nextFocus(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _companyController,
                                    decoration: const InputDecoration(
                                      labelText: 'Company',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context).nextFocus(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _phoneController,
                              decoration:
                                  const InputDecoration(labelText: 'Phone'),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a phone number';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _emailController,
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _websiteController,
                              decoration:
                                  const InputDecoration(labelText: 'Website'),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _addressController,
                              decoration:
                                  const InputDecoration(labelText: 'Address'),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _notesController,
                              decoration: const InputDecoration(
                                labelText: 'Notes',
                              ),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
