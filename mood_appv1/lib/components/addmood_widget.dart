import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/save_selectdate.dart';
import '../services/setup_notes.dart';

class Icons_ModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.86,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        '${formate_time(context.read<SelectTime>().select_time)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'How was your day?',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Expanded(
                      child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: 21,
                    itemBuilder: (context, index) {
                      return addIcon('assets/icons/${index + 2}.png', context);
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String formate_time(DateTime inputDate) {
  DateFormat formatter = DateFormat('EEEE, MMMM d, y');
  String formattedDate = formatter.format(inputDate);
  return formattedDate;
}

Widget addIcon(String img, BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      context.read<Note_create>().addIcon(img);
      Navigator.pop(context);
    },
    style: ElevatedButton.styleFrom(
        elevation: 0, // Removes elevation
        backgroundColor: Colors.white),
    child: SizedBox(
      width: 70, // Set desired width
      height: 70, // Set desired height
      child: Image.asset(img),
    ),
  );
}
