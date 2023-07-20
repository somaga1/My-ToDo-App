import 'package:app_example/style/app_colors.dart';
import 'package:app_example/style/text_styles.dart';
import 'package:app_example/views/task_edit_view/task_edit_view_model.dart';
import 'package:app_example/widgets/wrapper_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class TaskEditView extends StatefulWidget {
  final TaskEditViewModel viewModel;

  const TaskEditView(this.viewModel, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TaskEditView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.viewModel.title;
    _descriptionController.text = widget.viewModel.description;
    _dateController.text =
        DateFormat("yyyy-MM-dd HH:mm").format(widget.viewModel.firstExecution);

    _isEdit = widget.viewModel.task != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(25, 60, 15, 10),
            child: ListView(padding: EdgeInsets.only(right: 10.0), children: [
              Center(
                child: Text(
                  "New Task",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              _buildTaskDetailWidget(),
              Container(height: 20),
              _buildTaskReminderWidget(),
              Container(height: 20),
              _buildTaskSkipOptionsWidget(),
              Container(height: 20),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await widget.viewModel.save();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 238, 139, 25),
                        ),
                        child: const Text("Save")),
                  ])
            ])));
  }

  Widget _buildTaskDetailWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(height: 5),
      TextFormField(
        controller: _titleController,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            hintText: 'Task',
            hintStyle: const TextStyle(fontSize: 14),
            icon: const Icon(Icons.list_alt_rounded, color: Colors.brown),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.brown, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            )),
        onChanged: (value) {
          widget.viewModel.title = value;
        },
      ),
      Container(height: 10),
      TextField(
        controller: _descriptionController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            hintText: 'Description',
            hintStyle: const TextStyle(fontSize: 14),
            icon: const Icon(Icons.chat_sharp, color: Colors.brown),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.brown, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            )),
        onChanged: (value) {
          widget.viewModel.description = value;
        },
      )
    ]);
  }

  Widget _buildTaskReminderWidget() {
    return WrapperWidget(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Set Daily Reminder", style: TextStyles.heading),
      SizedBox(
        height: 10.0,
      ),
      Row(children: [
        Text(
          'Start Date: \n\nDaily Time:',
          style: TextStyle(
              color: Color(0xFFb2847a),
              fontWeight: FontWeight.w500,
              fontSize: 15.0),
        ),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
            child: Text(
          DateFormat("yyyy/MM/dd \n\nHH:mm")
              .format(widget.viewModel.firstExecution),
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14.0),
        )),
        Container(
            decoration: BoxDecoration(
                color: _isEdit
                    ? AppColors.taskBackground
                    : AppColors.appBackground,
                borderRadius: BorderRadius.circular(30)),
            child: IconButton(
                onPressed: _isEdit ? null : () async => await _selectDateTime(),
                icon: Icon(Icons.calendar_today,
                    color: Color.fromARGB(255, 238, 139, 25)),
                color: AppColors.taskBackground))
      ]),
      SizedBox(
        height: 15,
      ),
      Text("* Reminders will be sent daily",
          style:
              TextStyle(fontSize: 11, color: Color.fromARGB(255, 238, 139, 25)))
    ]));
  }

  Widget _buildTaskSkipOptionsWidget() {
    return WrapperWidget(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Skip", style: TextStyles.heading),
      Container(height: 10),
      SwitchListTile(
          inactiveThumbColor: Color.fromARGB(255, 253, 157, 83),
          inactiveTrackColor: Color.fromARGB(255, 253, 204, 140),
          activeColor: Colors.grey.shade400,
          visualDensity: VisualDensity.compact,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text("Mondays"),
          contentPadding: EdgeInsets.zero,
          value: widget.viewModel.skipMondays,
          onChanged: (value) {
            widget.viewModel.skipMondays = value;
            _refreshUi();
          }),
      SwitchListTile(
          inactiveThumbColor: Color.fromARGB(255, 253, 157, 83),
          inactiveTrackColor: Color.fromARGB(255, 253, 204, 140),
          activeColor: Colors.grey.shade400,
          visualDensity: VisualDensity.compact,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text("Tuesdays"),
          contentPadding: EdgeInsets.zero,
          value: widget.viewModel.skipTuesdays,
          onChanged: (value) {
            widget.viewModel.skipTuesdays = value;
            _refreshUi();
          }),
      SwitchListTile(
          inactiveThumbColor: Color.fromARGB(255, 253, 157, 83),
          inactiveTrackColor: Color.fromARGB(255, 253, 204, 140),
          activeColor: Colors.grey.shade400,
          visualDensity: VisualDensity.compact,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text("Wednesdays"),
          contentPadding: EdgeInsets.zero,
          value: widget.viewModel.skipWednesdays,
          onChanged: (value) {
            widget.viewModel.skipWednesdays = value;
            _refreshUi();
          }),
      SwitchListTile(
          inactiveThumbColor: Color.fromARGB(255, 253, 157, 83),
          inactiveTrackColor: Color.fromARGB(255, 253, 204, 140),
          activeColor: Colors.grey.shade400,
          visualDensity: VisualDensity.compact,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text("Thursdays"),
          contentPadding: EdgeInsets.zero,
          value: widget.viewModel.skipThursdays,
          onChanged: (value) {
            widget.viewModel.skipThursdays = value;
            _refreshUi();
          }),
      SwitchListTile(
          inactiveThumbColor: Color.fromARGB(255, 253, 157, 83),
          inactiveTrackColor: Color.fromARGB(255, 253, 204, 140),
          activeColor: Colors.grey.shade400,
          visualDensity: VisualDensity.compact,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text("Fridays"),
          contentPadding: EdgeInsets.zero,
          value: widget.viewModel.skipFridays,
          onChanged: (value) {
            widget.viewModel.skipFridays = value;
            _refreshUi();
          }),
      SwitchListTile(
          inactiveThumbColor: Color.fromARGB(255, 253, 157, 83),
          inactiveTrackColor: Color.fromARGB(255, 253, 204, 140),
          activeColor: Colors.grey.shade400,
          visualDensity: VisualDensity.compact,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text("Saturdays"),
          contentPadding: EdgeInsets.zero,
          value: widget.viewModel.skipSaturdays,
          onChanged: (value) {
            widget.viewModel.skipSaturdays = value;
            _refreshUi();
          }),
      SwitchListTile(
          inactiveThumbColor: Color.fromARGB(255, 253, 157, 83),
          inactiveTrackColor: Color.fromARGB(255, 253, 204, 140),
          activeColor: Colors.grey.shade400,
          visualDensity: VisualDensity.compact,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text("Sundays"),
          contentPadding: EdgeInsets.zero,
          value: widget.viewModel.skipSundays,
          onChanged: (value) {
            widget.viewModel.skipSundays = value;
            _refreshUi();
          }),
      SizedBox(
        height: 10,
      ),
      Text("* Unselect the days you wish to skip the reminder",
          style: TextStyle(fontSize: 11, color: AppColors.description))
    ]));
  }

  Future _selectDateTime() async {
    var date = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.brown, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        helpText: "When should the task start?",
        initialDate: widget.viewModel.firstExecution,
        firstDate: DateTime.now().subtract(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (date != null) {
      var time = await showTimePicker(
        helpText: "At what time should a reminder be delivered?",
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color.fromARGB(255, 238, 139, 25),
              accentColor: const Color.fromARGB(255, 238, 139, 25),
              colorScheme: ColorScheme.light(
                  primary: const Color.fromARGB(255, 238, 139, 25)),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        widget.viewModel.firstExecution = tz.TZDateTime(
            tz.local, date.year, date.month, date.day, time.hour, time.minute);
        _refreshUi();
      }
    }
  }

  void _refreshUi() {
    setState(() {});
  }
}
