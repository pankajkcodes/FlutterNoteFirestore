import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notefirestore/src/edit_note.dart';
import 'package:notefirestore/src/show_details_note.dart';

class ShowNotesPage extends StatefulWidget {
  const ShowNotesPage({Key? key}) : super(key: key);

  @override
  State<ShowNotesPage> createState() => _ShowNotesPageState();
}

class _ShowNotesPageState extends State<ShowNotesPage> {
  final Stream<QuerySnapshot> noteStream =
      FirebaseFirestore.instance.collection('notes').orderBy("id").snapshots();

  // For Deleting User
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  Future<void> deleteNote(id) {
    // print("User Deleted $id");
    return notes
        .doc(id)
        .delete()
        .then((value) => print('Notes Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: noteStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: InkWell(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShowDetailsPage(id: storedocs[i]['id']),
                                ),
                              )
                            },
                            child: Text(storedocs[i]['title'],
                                style: const TextStyle(fontSize: 18.0)),
                          )),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditNotePage(id: storedocs[i]['id']),
                                    ),
                                  )
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 0, 81, 255),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    {deleteNote(storedocs[i]['id'])},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
