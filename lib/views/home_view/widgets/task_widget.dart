import 'package:app_example/database/models/task.dart';
import 'package:app_example/database/models/task_reminder.dart';
import 'package:app_example/style/app_colors.dart';
import 'package:app_example/style/text_styles.dart';
import 'package:app_example/widgets/wrapper_widget.dart';
import 'package:app_example/widgets/wrapper_widget2.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

class TaskWidget extends StatelessWidget {
  final Task task;
  final Function()? onLongPress;
  final Function()? onTap;
  const TaskWidget({Key? key, required this.task, this.onLongPress, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapperWidget2(
      child: Stack(clipBehavior: Clip.none, children: <Widget>[
        Positioned(right: -20, top: -20, child: _getProgressHint(task)),
        ListTile(
            contentPadding: EdgeInsets.zero,
            onLongPress: onLongPress,
            onTap: onTap,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  _buildTaskStatisticsIndicator(task),
                  // const Spacer(),
                  // _getProgressHint(task),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.brown),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    task.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(children: [
                    Icon(Icons.alarm, size: 14, color: AppColors.description),
                    Container(width: 3),
                    Text(
                        timeago.format(task.reminders.last.scheduledOn,
                            allowFromNow: true),
                        style: TextStyles.taskDescriptionSmall)
                  ])
                ])),
      ]),
    );
  }

  Widget _buildTaskStatisticsIndicator(Task task) {
    var percentage = task.reminders.isEmpty
        ? 0.0
        : task.reminders
                .where(
                    (element) => element.state == TaskReminderActionState.done)
                .length /
            task.reminders.length;

    return Center(
        child: CircularPercentIndicator(
            radius: 25,
            lineWidth: 6,
            animation: true,
            animationDuration: 1000,
            percent: percentage,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.pink,
            backgroundColor: Colors.grey.shade300,
            center: _getProgressLabel(task)));
  }

  Widget _getProgressHint(Task task) {
    var openRemindersCount = task.reminders
        .where((element) => element.state == TaskReminderActionState.none)
        .length;

    return openRemindersCount == 0
        ? Container()
        : Row(children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$openRemindersCount",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
              ),
            )
          ]);
  }

  Widget _getProgressLabel(Task task) {
    var percentage = task.reminders.isEmpty
        ? 0.0
        : task.reminders
                .where(
                    (element) => element.state == TaskReminderActionState.done)
                .length /
            task.reminders.length;
    return percentage == 1.0
        ? Icon(Icons.check_rounded, color: AppColors.positive)
        : Text("${(percentage * 100).toStringAsFixed(0)}%");
  }
}
