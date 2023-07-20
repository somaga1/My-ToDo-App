import 'package:app_example/database/models/task.dart';
import 'package:app_example/navigation/navigation_service.dart';
import 'package:app_example/navigation/route_generator.dart';
import 'package:app_example/notification/notification_service.dart';
import 'package:app_example/providers/reminder_update_provider.dart';
import 'package:app_example/providers/reminder_update_state_provider.dart';
import 'package:app_example/providers/task_list_provider.dart';
import 'package:app_example/style/app_colors.dart';
import 'package:app_example/style/text_styles.dart';
import 'package:app_example/views/home_view/home_view_model.dart';
import 'package:app_example/views/home_view/widgets/task_widget.dart';
import 'package:app_example/widgets/app_bar_button.dart';
import 'package:app_example/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HomeView extends ConsumerStatefulWidget {
  final HomeViewModel viewModel;

  const HomeView(this.viewModel, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    // navigates to the task page with the given id
    // NotificationService.notificationsList.stream.listen((event) {
    //   Get.find<NavigationService>()
    //       .navigateTo(RouteGenerator.routeTask, arguments: int.parse(event));
    // });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(taskListProvider);

    return provider.when(
        loading: _buildLoadingContent,
        error: _buildErrorContent,
        data: (data) => _buildDataContent(data, ref));
  }

  Widget _buildLoadingContent() {
    return const Scaffold(body: LoadingWidget());
  }

  Widget _buildErrorContent(Object? o, StackTrace? st) {
    return Scaffold(body: ErrorWidget(o.toString()));
  }

  Widget _buildDataContent(List<Task> data, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 75,
          leading: Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(color: AppColors.brown, shape: BoxShape.circle),
              child: Icon(Icons.person, color: Colors.brown, size: 23),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacementNamed(context, "/login");
                });
              },
              child: CircleAvatar(
                radius: 18,
                child: Icon(Icons.logout_sharp, color: Colors.white, size: 23),
              ),
            ),
            SizedBox(
              width: 15.0,
            )
          ],
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown,
          onPressed: () async {
            await widget.viewModel.addNewTask(ref);
            ref.refresh(taskListProvider);
          },
          child: const Icon(Icons.add),
        ),

        // bottomNavigationBar: BottomAppBar(
        //     color: AppColors.taskBackground,
        //     child: AppBarButton(
        //         icon: Icons.add,
        //         onPressed: () async {
        //           await widget.viewModel.addNewTask(ref);
        //           ref.refresh(taskListProvider);
        //         })),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: BottomNavigationBar(
              // currentIndex: _selectedIndex,
              selectedItemColor: Colors.brown,
              unselectedItemColor: Colors.black,
              // onTap: (index) {
              //   setState(() {
              //     _selectedIndex = index;
              //     pageController.jumpToPage(index);
              //   });
              // },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.square_list,
                    color: Color.fromARGB(99, 255, 255, 255),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.tag,
                    color: Color.fromARGB(99, 255, 255, 255),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
        body: data.isEmpty
            ? const Center(
                child: Text("No tasks to display", textAlign: TextAlign.center))
            : Stack(children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(25, 45, 25, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back 👋",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You have ${data.length} pending tasks",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 238, 139, 25)),
                          ),
                          Container(height: 30),
                          Expanded(
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: data.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0),
                                  itemBuilder: (context, index) {
                                    final item = data[index];

                                    return TaskWidget(
                                        task: item,
                                        onLongPress: () async {
                                          if (!await widget.viewModel
                                              .isDeleteConfirmed(
                                                  item, context)) {
                                            return;
                                          }

                                          await widget.viewModel
                                              .deleteTask(item);
                                          ref.refresh(taskListProvider);
                                        },
                                        onTap: () async {
                                          await widget.viewModel
                                              .goToTaskView(item.id);
                                          await widget.viewModel
                                              .updateNotification(item);
                                          ref.refresh(taskListProvider);
                                        });
                                  }))
                        ])),
                _buildUpdateIndicator()
              ]));
  }

  Widget _buildUpdateIndicator() {
    final updateDone = ref.watch(reminderUpdateStateProvider);

    if (updateDone) return Container();

    final provider = ref.watch(reminderUpdateProvider);
    return provider.when(
        data: (data) => Container(),
        error: (o, s) => Container(),
        loading: () => Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: const Text("Updating reminders..."))));
  }
}
