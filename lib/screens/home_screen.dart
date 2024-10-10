import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.all(65),
            color: Colors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                Column(
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
                if (value.tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      style: TextStyle(fontSize: 50),
                      'My Tasks',
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: value.tasks.length,
                  itemBuilder: (context, index) {
                    final task = value.tasks[index];

                    return Card(
                      margin: EdgeInsets.all(40),
                      color: Colors.blue,
                      child: ListTile(
                        // leading: CircularPercentIndicator(
                        //   radius: 10,
                        //   progressColor: Colors.purple,
                        // ),
                        title: Text(
                          task.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        // subtitle: Text(task.email),
                        leading: CircleAvatar(
                          child: CircularPercentIndicator(
                            radius: 10,
                            progressColor: Colors.purple,
                            center: Text('75 %'),
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
