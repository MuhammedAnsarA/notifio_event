import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notifio_event/core/common/widgets/fading_text.dart';
import 'package:notifio_event/core/common/widgets/white_space.dart';
import 'package:notifio_event/core/extensions/date_extensions.dart';
import 'package:notifio_event/features/todo/models/task_model.dart';

import '../../../core/res/colours.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
    this.task, {
    required this.endIcon,
    super.key,
    this.onEdit,
    this.onDelete,
    this.bottomMargin,
    this.colour,
  });

  final TaskModel task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget endIcon;
  final double? bottomMargin;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      margin: bottomMargin == null
          ? null
          : EdgeInsets.only(
              bottom: bottomMargin!.h,
            ),
      decoration: BoxDecoration(
        color: Colours.darkBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 80.h,
                width: 5.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colour ?? Colours.randomColor()),
              ),
              const WhiteSpace(
                width: 15,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadingText(
                      task.title!,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      colour: Colours.light,
                    ),
                    const WhiteSpace(
                      height: 3,
                    ),
                    FadingText(
                      task.description!,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                      colour: Colours.light,
                    ),
                    const WhiteSpace(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.h,
                            horizontal: 15.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colours.light,
                            border:
                                Border.all(width: .3, color: Colours.greyLight),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "${task.startTime!.timeOnly} | ${task.endTime!.timeOnly}",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colours.darkBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        if (!task.isCompleted)
                          IconButton(
                            onPressed: onEdit,
                            icon: const Icon(
                              MaterialCommunityIcons.circle_edit_outline,
                              color: Colours.light,
                              size: 28,
                            ),
                          ),
                        IconButton(
                          onPressed: onDelete,
                          icon: const Icon(
                            MaterialCommunityIcons.delete_circle,
                            color: Colours.light,
                            size: 29,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          endIcon,
        ],
      ),
    );
  }
}
