import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_game/custom/scafold_custom.dart';
import 'package:number_game/features/game_daily_task/presentation/widgets/custom_calender.dart';

class DailyTaskPage extends StatelessWidget {
  const DailyTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      darkenBg: true,
      bgimagePath: 'asset/images/scafold_main_bg.gif',
      body: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          CustomCalendar(),
        ],
      ),
    );
  }
}
