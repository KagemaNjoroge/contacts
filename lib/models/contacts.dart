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
