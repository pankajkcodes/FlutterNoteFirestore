import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowDetailsPage extends StatefulWidget {
  final String id;
  const ShowDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowDetailsPage> createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  var title = "";
  var description = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  //  Updaing Student  //
  CollectionReference students = FirebaseFirestore.instance.collection('notes');

  Future<void> updateUser(id, title, description) {
    return students
        .doc(id)
        .update({'title': title, 'description': description})
        .then((value) => print("Note Updated"))
        .catchError((error) => print("Failed to update : $error"));
  }

  clearText() {
    titleController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('notes')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var title = data!['title'];
              var description = data['description'];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Text(title),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(description),
                  ],
                ),
              );
            },
          )),
    );
  }
}
