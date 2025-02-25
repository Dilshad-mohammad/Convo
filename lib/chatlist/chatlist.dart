import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:convo/utils/brand_color.dart';
import '../chat/chat_screen.dart';
import '../models/contact_list_model.dart';
import '../utils/helper_function.dart';

class ContactListScreen extends StatefulWidget {
  ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContactlist();
    _searchController.addListener(_filterContacts);
  }

  _loadContactlist() async {
    // Load JSON data
    rootBundle.loadString('assets/mock_chatlist.json').then((response) {
      final List<dynamic> decodedList = jsonDecode(response) as List;
      final List<Contact> contactLists = decodedList.map((listItem) {
        return Contact.fromJson(listItem);
      }).toList();

      setState(() {
        _contacts = contactLists;
        _filteredContacts = _contacts; // Initially show all contacts
      });
    });
  }

  void _filterContacts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = _contacts
          .where((contact) => contact.name.toLowerCase().contains(query))
          .toList();
    });
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search Contact",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = _filteredContacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(contact.profilePicUrl),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.lastMessage),
                  onTap: () {
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
        ],
      ),
    );
  }
}
