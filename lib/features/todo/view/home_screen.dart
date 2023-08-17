import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifio_event/core/common/widgets/filled_field.dart';
import 'package:notifio_event/core/common/widgets/widgets.dart';
import 'package:notifio_event/core/helper/db_helper.dart';
import 'package:notifio_event/features/authentication/views/sign_in_screen.dart';
import 'package:notifio_event/features/todo/app/task_provider.dart';
import 'package:notifio_event/features/todo/view/add_or_edit_task_screen.dart';

import '../../../core/res/colours.dart';
import '../widgets/active_tasks.dart';
import '../widgets/completed_tasks.dart';
import '../widgets/tasks_for_day_after_tomorrow.dart';
import '../widgets/tasks_for_tomorrow.dart';
import '../widgets/tasks_from_one_month_ago.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final tabController = useTabController(initialLength: 2);
    final tabTextStyle = GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colours.light,
    );
    ref.read(taskProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton(
                        icon: const Icon(
                          AntDesign.logout,
                          color: Colours.darkBackground,
                        ),
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          await DBHelper.deleteUser();
                          navigator.pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => const SignInScreen(),
                              ),
                              (route) => false);
                        },
                      ),
                    ),
                    Text(
                      "Task Management",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colours.darkBackground,
                      ),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colours.darkBackground),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddOrEditTaskScreen(),
                            ));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colours.light,
                      ),
                    ),
                  ],
                ),
                const WhiteSpace(
                  height: 20,
                ),
                FilledField(
                  prefixIcon: const Icon(
                    AntDesign.search1,
                    color: Colours.light,
                  ),
                  hintText: "Search",
                  hintStyle: GoogleFonts.poppins(color: Colours.greyLight),
                  suffixIcon: const Icon(
                    FontAwesome.sliders,
                    color: Colours.light,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    size: 20,
                    color: Colours.darkBackground,
                  ),
                  const WhiteSpace(
                    width: 10,
                  ),
                  Text(
                    "Today's Tasks",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colours.darkBackground),
                  ),
                ],
              ),
              const WhiteSpace(
                height: 25,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: ColoredBox(
                  color: Colours.darkBackground,
                  child: TabBar(
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        color: Colours.greyLight,
                        borderRadius: BorderRadius.circular(5)),
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colours.greyLight,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colours.light,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelColor: Colours.light,
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: screenWidth * 0.5,
                          child: Center(
                            child: Text("Pending", style: tabTextStyle),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: screenWidth * 0.5,
                          child: Center(
                            child: Text("Completed", style: tabTextStyle),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const WhiteSpace(height: 20),
              SizedBox(
                height: screenHeight * 0.26,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      ActiveTasks(),
                      CompletedTasks(),
                    ],
                  ),
                ),
              ),
              const WhiteSpace(height: 20),
              const TasksForTomorrow(),
              const WhiteSpace(height: 20),
              const TasksForDayAfterTomorrow(),
              const WhiteSpace(height: 20),
              const TasksFromOneMonthAgo(),
            ],
          ),
        ),
      ),
    );
  }
}
