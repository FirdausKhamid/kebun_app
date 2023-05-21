import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kebun_app/bricks/Widgets%20Example/add_button.dart';
import 'package:kebun_app/bricks/Widgets%20Example/gradient_button_rounded.dart';

class Employee extends StatelessWidget {
  const Employee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 47, 47, 47),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 47, 47, 47),
              elevation: 0,
              centerTitle: false,
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Employee',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: Center(
            child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: GradientButtonFb4(
                        text: "Manage Payment", onPressed: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child:
                        AddButton(text: "Add New Employee", onPressed: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: AddButton(text: "Track Loans", onPressed: () {}),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.5,
                    endIndent: 20,
                    indent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 140),
                    child: Text('Recently Completed Jobs',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: DataTable(
                        columnSpacing: 46,
                        columns: [
                          DataColumn(
                              label: Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )),
                          DataColumn(
                              label: Text(
                            'Type',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )),
                          DataColumn(
                              label: Text(
                            'DateTime',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )),
                          DataColumn(
                              label: Text(
                            'Block',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('Armand')),
                            DataCell(Text('Harvest')),
                            DataCell(Text('20.5.2023')),
                            DataCell(Text('A')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Firdaus')),
                            DataCell(Text('Fixing')),
                            DataCell(Text('19.5.2023')),
                            DataCell(Text('B')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Danial')),
                            DataCell(Text('Pruning')),
                            DataCell(Text('18.5.2023')),
                            DataCell(Text('B')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Ikmal')),
                            DataCell(Text('Fertilize')),
                            DataCell(Text('18.5.2023')),
                            DataCell(Text('C')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Haziq')),
                            DataCell(Text('Harvest')),
                            DataCell(Text('15.5.2023')),
                            DataCell(Text('C')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Farhan')),
                            DataCell(Text('Pruning')),
                            DataCell(Text('14.5.2023')),
                            DataCell(Text('D')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Hasliza')),
                            DataCell(Text('Fertilize')),
                            DataCell(Text('13.5.2023')),
                            DataCell(Text('A')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Ainul')),
                            DataCell(Text('Fixing')),
                            DataCell(Text('12.5.2023')),
                            DataCell(Text('C')),
                          ]),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        )));
  }
}
