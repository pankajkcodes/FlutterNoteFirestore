import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNotePage extends StatefulWidget {
  final String id;
  const EditNotePage({Key? key, required this.id}) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
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
        title: const Text("Update Note"),
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: title,
                        autofocus: false,
                        onChanged: (value) => title = value,
                        decoration: const InputDecoration(
                          labelText: 'Title: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Can Not Be Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: title,
                        autofocus: false,
                        minLines: 5,
                        maxLines: 7,
                        onChanged: (value) => title = value,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Can Not Be Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState!.validate()) {
                              updateUser(widget.id, title, description);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () => {
                        //     clearText()
                        //   },
                        //   child: const Text(
                        //     'Reset',
                        //     style: TextStyle(fontSize: 18.0),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //       primary: Colors.blueGrey),
                        // ),
                      ],
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
