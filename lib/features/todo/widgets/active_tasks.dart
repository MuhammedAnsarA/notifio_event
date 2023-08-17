import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifio_event/core/res/colours.dart';
import 'package:notifio_event/features/todo/app/task_provider.dart';
import 'package:notifio_event/features/todo/view/add_or_edit_task_screen.dart';
import 'package:notifio_event/features/todo/widgets/todo_tile.dart';

import '../utils/todo_utils.dart';

class ActiveTasks extends ConsumerWidget {
  const ActiveTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    return FutureBuilder(
      future: TodoUtils.getActiveTasksForToday(tasks),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Pending Tasks",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colours.darkGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return ColoredBox(
            color: Colours.light,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final task = snapshot.data![index];
                final isLast = index == snapshot.data!.length - 1;
                return TodoTile(
                  task,
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
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
