import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:convo/utils/brand_color.dart';
import 'package:flutter/services.dart';
import '../chat/chat_screen.dart';
import '../models/contact_list_model.dart';
import '../utils/helper_function.dart';

class ContactListScreen extends StatefulWidget {
  ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  // Initial state of the messages
  List<Contact> _contacts = [];

  _loadContactlist() async {
    // Optionally, load messages for the given contact.
    rootBundle.loadString('assets/mock_chatlist.json').then((response) {
      final List<dynamic> decodedList = jsonDecode(response) as List;

      final List<Contact> contactlists = decodedList.map((listItem) {
        return Contact.fromJson(listItem);
      }).toList();

      // Set the messages state
      setState(() {
        _contacts = contactlists;
      });
    });
  }

  @override
  void initState() {
    _loadContactlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? BrandColor.dark : BrandColor.light,
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: BrandColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, index) { return Divider(); },
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            final contact = _contacts[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(contact.profilePicUrl),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.lastMessage),
              onTap: () {
                // Navigate to ChatScreen for the selected contact.
                // You may want to pass the contact details to ChatScreen.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(contact: contact),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
