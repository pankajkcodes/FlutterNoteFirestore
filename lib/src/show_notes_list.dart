import 'package:flutter/material.dart';
import 'package:notefirestore/src/edit_note.dart';
import 'package:notefirestore/src/show_details_note.dart';

class ShowNotesPage extends StatefulWidget {
  const ShowNotesPage({Key? key}) : super(key: key);

  @override
  State<ShowNotesPage> createState() => _ShowNotesPageState();
}

class _ShowNotesPageState extends State<ShowNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: 5,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = Text("Hello");

            return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        1: FixedColumnWidth(140),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          
                          children: [
                            TableCell(
                              child: Container(
                                color: Colors.greenAccent,
                              child: ListTile(
                                title: Text("Title"),
                                onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                           (context)
                                           => const ShowDetalisNotes(
                                              // id: storedocs[i]['id']
                                              )
                                              ,
                                        ),
                                      )
                                    },
                              ),
                              ),
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
                                          builder:
                                           (context)
                                           => const EditNotePage(
                                              // id: storedocs[i]['id']
                                              )
                                              ,
                                        ),
                                      )
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => {
                                      // deleteUser(storedocs[i]['id'])
                                    },
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
                    )));
          }),
    );
  }
}
