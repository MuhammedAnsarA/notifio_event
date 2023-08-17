import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifio_event/core/res/colours.dart';
import 'package:notifio_event/features/todo/app/task_provider.dart';
import 'package:notifio_event/features/todo/view/add_or_edit_task_screen.dart';
import 'package:notifio_event/features/todo/widgets/task_expansion_tile.dart';
import 'package:notifio_event/features/todo/widgets/todo_tile.dart';

import '../utils/todo_utils.dart';

class TasksForTomorrow extends ConsumerWidget {
  const TasksForTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    return FutureBuilder(
      future: TodoUtils.getTasksForTomorrow(tasks),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final colour = Colours.randomColor();
          return TaskExpansionTile(
            title: "Tomorrow's Tasks",
            colour: colour,
            subTitle: "Tomorrow's tasks are shown here",
            children: snapshot.data!.map((task) {
              final isLast = snapshot.data!
                      .indexWhere((element) => element.id == task.id) ==
                  snapshot.data!.length - 1;
              return TodoTile(
                task,
                colour: colour,
                bottomMargin: isLast ? null : 10,
                onDelete: () {
                  ref.read(taskProvider.notifier).deleteTask(task.id!);
                },
                onEdit: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddOrEditTaskScreen(task: task)));
                },
                endIcon: Switch(
                  inactiveTrackColor: Colours.light,
                  inactiveThumbColor: Colours.greyBackground,
                  value: task.isCompleted,
                  onChanged: (_) {
                    task.isCompleted = true;
                    ref.read(taskProvider.notifier).markAsCompleted(task);
                  },
                ),
              );
            }).toList(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
