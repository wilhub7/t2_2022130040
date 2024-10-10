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
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final existingTask = ModalRoute.of(context)!.settings.arguments as Task?;
    final isEdit = existingTask != null;
    DateTime?
        selectedDate; //tidak menggunakan final mungkin nilainya berubah berdasarkan interaksi pengguna
    TimeOfDay? startTime;
    TimeOfDay? endTime;
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
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
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: ' Task name',
                ),
              ),
              const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () async {
              //         final date = await showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(),
              //           firstDate: DateTime(2000),
              //           lastDate: DateTime(2100),
              //         );

              //         if (date != null) {
              //           _controller2.text =
              //               DateFormat('dd MMMM yyyy').format(date);
              //         } ,
              //   child: TextFormField(
              //       controller: _controller2,
              //       decoration: const InputDecoration(
              //         labelText: 'Arrival Date',
              //         border: OutlineInputBorder(),
              //         suffixIcon: Icon(Icons.date_range_sharp),
              //       ),
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return 'tolong pilih Arrival Date';
              //         }
              //         return null;
              //       },
              //       onTap:
              //       },
              //     ),),
              // ElevatedButton(
              //   onPressed: () async {
              //     final date = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime(2000),
              //       lastDate: DateTime(2100),
              //     );

              //     if (date != null) {
              //       selectedDate = date;
              //     }
              //   },
              //   child: Text(
              //     selectedDate != null
              //         ? 'Selected Date: ${DateFormat('dd MMMM yyyy').format(selectedDate!)}'
              //         : 'Select Date',
              //   ),
              // ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(height: 16),
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
