import 'package:chatapp/models/contact_model.dart';
import 'package:chatapp/services/api_service.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<ContactModel> _contacts = [];
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      List<ContactModel> contacts = await _apiService.getContacts(context);
      setState(() {
        _contacts = contacts;
      });
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contacts.isEmpty
          ? Center(child: const Text('No se encontraron contactos.'))
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return _buildContactCard(contact);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Mas');
        },
      ),
    );
  }

  Widget _buildContactCard(ContactModel contact) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text('Nombre: ${contact.name}'),
        subtitle: Text('Celular ${contact.celularNumber}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Acción para editar el contacto
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Acción para eliminar el contacto
              },
            ),
          ],
        ),
      ),
    );
  }
}
