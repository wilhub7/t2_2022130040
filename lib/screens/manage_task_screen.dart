import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t2_2022130040/models/task.dart';
import 'package:t2_2022130040/providers/task_provider.dart';
import 'package:intl/intl.dart';

class ManageTaskScreen extends StatefulWidget {
  const ManageTaskScreen({super.key});

  @override
  State<ManageTaskScreen> createState() => _ManageTaskScreenState();
}

class _ManageTaskScreenState extends State<ManageTaskScreen> {
  final TextEditingController nameController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  DateTime? selectedDate = DateTime
      .now(); //tidak menggunakan final mungkin nilainya berubah berdasarkan interaksi pengguna
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final _dateTimeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _dateTimeController.text =
        DateFormat('yyyy MMMM, dd').format(DateTime.now());
  }
// Future<void> _selectDate(BuildContext context ) async {
//                     final DateTime date = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                     );

//                     if (date != null) {
//                       setState(() {
//                         selectedDate = date;
//                         _dateTimeController.text =
//                             DateFormat('yyyy MMMM, dd').format(date);
//                       });
//                     },
//                   },
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final existingTask = ModalRoute.of(context)!.settings.arguments as Task?;
    final isEdit = existingTask != null;

    if (isEdit) {
      nameController.text = existingTask.name;
      selectedDate = existingTask.date;
      startTime = existingTask.start;
      endTime = existingTask.end;
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            isEdit ? 'Edit Task' : 'Create New Task',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Task title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Card(
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: ' Task name',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Card(
                child: TextField(
                  decoration: InputDecoration(
                    prefix: Icon(Icons.date_range),
                  ),
                  controller: _dateTimeController,
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                        _dateTimeController.text =
                            DateFormat('yyyy MMMM, dd').format(date);
                      });
                    }
                  },
                  // child: Row(
                  //   children: [
                  //     Icon(Icons.date_range),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //       child: Text(
                  //         _dateTimeController.text,
                  //         textAlign: TextAlign.start,
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Task start',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Task end',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (time != null) {
                          setState(() {
                            startTime = time;
                            _startTimeController.text = time.format(context);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.access_time),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              _startTimeController.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (time != null) {
                          setState(() {
                            endTime = time;
                            _endTimeController.text = time.format(context);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.access_time),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              _endTimeController.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;

                  final newTask = Task(
                    id: isEdit
                        ? existingTask.id
                        : DateTime.now().microsecondsSinceEpoch,
                    name: name,
                    date: selectedDate ?? DateTime.now(),
                    start: startTime ?? TimeOfDay.now(),
                    end: endTime ?? TimeOfDay.now(),
                  );

                  if (isEdit) {
                    context.read<TaskProvider>().editTask(newTask);
                  } else {
                    context.read<TaskProvider>().addTask(newTask);
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'CREATE TASK',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
  }
}
