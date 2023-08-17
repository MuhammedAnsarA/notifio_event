import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifio_event/core/res/colours.dart';
import 'package:notifio_event/features/todo/app/task_provider.dart';
import 'package:notifio_event/features/todo/view/add_or_edit_task_screen.dart';
import 'package:notifio_event/features/todo/widgets/todo_tile.dart';

import '../utils/todo_utils.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    return FutureBuilder(
      future: TodoUtils.getCompletedTasksForToday(tasks),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Completed Tasks",
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
                return TodoTile(task, bottomMargin: isLast ? null : 10,
                    onDelete: () {
                  ref.read(taskProvider.notifier).deleteTask(task.id!);
                }, onEdit: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddOrEditTaskScreen(task: task)));
                },
                    endIcon: const Icon(
                      AntDesign.checkcircle,
                      size: 25,
                      color: Colours.green,
                    ));
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
