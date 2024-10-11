import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:t2_2022130040/providers/task_provider.dart';
import 'package:t2_2022130040/screens/manage_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.read<TaskProvider>().clearTasks(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: Colors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '25',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'tasks',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 65,
                      child: Icon(Icons.people),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Annette Black',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'UI/UX designer',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '72 %',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'progress',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Tasks',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManageTaskScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.tasks.length,
                  itemBuilder: (context, index) {
                    final task = value.tasks[index];

                    return Card(
                      margin: EdgeInsets.all(10),
                      color: const Color.fromRGBO(255, 255, 255, .1),
                      child: ListTile(
                        // contentPadding: EdgeInsets.all(8),
                        title: Text(
                          task.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              DateFormat('MMMM, dd').format(task.date),
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${task.start.format(context)}',
                              style: TextStyle(color: Colors.white),
                            ),
                            // Text(
                            //   '${task.end.format(context)}',
                            //   style: TextStyle(color: Colors.white),
                            // )
                          ],
                        ),
                        leading: Container(
                          child: CircularPercentIndicator(
                            radius: 20,
                            progressColor: Colors.purple,
                            center: Text(
                              '75 %',
                              style: TextStyle(color: Colors.white),
                            ),
                            percent: 0.75,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.white,
                          onPressed: () {
                            value.removeTask(task);
                          },
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManageTaskScreen(),
                            settings: RouteSettings(arguments: task),
                          ),
                        ),
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
