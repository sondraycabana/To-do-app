import 'package:assessment/app/modules/view/task_details.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../model/task_model.dart';

class TaskDetailPage extends StatelessWidget {
  final Tasks task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(
              leading: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context),
                color: AppColors.primaryColor,
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 0.0,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1.0,
                color: const Color(0xffC8C5CB),
              ),
            ),
          ],
        ),
      ),
      body: TaskDetail(task: task),
    );
  }
}
