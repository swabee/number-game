import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:number_game/constant/app_constants.dart';
import 'package:number_game/constant/app_level_condition.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/custom/text_custom.dart';
import 'package:number_game/features/game_daily_task/presentation/bloc/game_daily_task_bloc.dart';
import 'package:number_game/features/game_session/data/models/game_data_model.dart';
import 'package:number_game/features/game_session/domain/entities/game_data_entity.dart';
import 'package:number_game/features/game_session/presentation/cubit/game_session_cubit.dart';
import 'package:number_game/features/game_session/presentation/pages/game_play_session_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uuid/uuid.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;
  final Uuid uuid = Uuid();
  List<Widget> _buildDaysOfWeek() {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return days
        .map((d) => Center(
              child: Text(
                d,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ))
        .toList();
  }

  List<Widget> _buildCalendarDays(List<GameDataEntity> gameDataList) {
    final firstDayOfMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final lastDayOfMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);

    int startWeekday = firstDayOfMonth.weekday % 7; 
    int totalDays = lastDayOfMonth.day;

    List<Widget> dayWidgets = [];

  
    for (int i = 0; i < startWeekday; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }

    for (int day = 1; day <= totalDays; day++) {
      final currentDate =
          DateTime(_focusedMonth.year, _focusedMonth.month, day);

      bool isSelected = _selectedDate?.day == day &&
          _selectedDate?.month == _focusedMonth.month &&
          _selectedDate?.year == _focusedMonth.year;

      // ✅ check if any gameDataList item matches this date
      bool hasGame = gameDataList.any((game) =>
          game.date.year == currentDate.year &&
          game.date.month == currentDate.month &&
          game.date.day == currentDate.day &&
          game.isDailyChallenge == true &&
          game.levelType == 3);

      // ✅ Check if this is a future date
      bool isFuture = currentDate.isAfter(DateTime.now());

      dayWidgets.add(
        GestureDetector(
          onTap: isFuture
              ? null // ❌ Disable tap for future
              : () {
                  if (isTodayOrPast(currentDate) && !hasGame) {
                    setState(() {
                      _selectedDate = currentDate;
                    });
                  }
                },
          child: Container(
            margin: const EdgeInsets.all(4),
            child: ClipPath(
              clipper: InwardDiamondClipper(curve: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: hasGame
                          ? const Color.fromARGB(255, 236, 175, 21)
                          : isSelected
                      ? const Color.fromARGB(255, 169, 39, 176) // purple
                      : Colors.transparent,
                ),
                alignment: Alignment.center,
                child: Text(
                  "$day",
                  style: TextStyle(
                    color: isFuture
                        ? Colors.grey // 🔹 Future dates grey
                        :hasGame
                                ? Colors.black
                                : isSelected
                            ? Colors.white
                            : hasGame
                                ? Colors.black
                                : Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    String monthName = DateFormat("MMMM yyyy").format(_focusedMonth);

    return BlocBuilder<GameDailyTaskBloc, GameDailyTaskState>(
      builder: (context, gameDailyHisotrystate) {
        if (gameDailyHisotrystate is GameDailyTaskLoaded) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _focusedMonth = DateTime(
                            _focusedMonth.year, _focusedMonth.month - 1);
                      });
                    },
                    icon: const Icon(Icons.arrow_back_ios_new,
                        size: 32, color: Color.fromARGB(255, 236, 175, 21)),
                  ),
                  ContainerCustom(
                    height: 200.h,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _focusedMonth = DateTime(
                            _focusedMonth.year, _focusedMonth.month + 1);
                      });
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined,
                        size: 32, color: Color.fromARGB(255, 236, 175, 21)),
                  ),
                ],
              ),

              // 🔹 Month Selector with Left & Right Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _focusedMonth = DateTime(
                  //           _focusedMonth.year, _focusedMonth.month - 1);
                  //     });
                  //   },
                  //   icon: const Icon(Icons.arrow_left,
                  //       size: 32, color: Colors.purple),
                  // ),
                  TextCustomWidget(
                    marginLeft: 15.w,
                    marginBottom: 5.h,
                    text: monthName,
                    textStyle: GoogleFonts.fredoka(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 236, 175, 21),
                    ),
                  ),
                  TextCustomWidget(
                    marginRight: 15.w,
                    marginBottom: 5.h,
                    text: '',
                    textStyle: GoogleFonts.fredoka(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 236, 175, 21),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _focusedMonth = DateTime(
                  //           _focusedMonth.year, _focusedMonth.month + 1);
                  //     });
                  //   },
                  //   icon: const Icon(Icons.arrow_right,
                  //       size: 32, color: Colors.purple),
                  // ),
                ],
              ),

              Stack(
                children: [
                  Transform.rotate(
                    angle: 3.12,
                    child: ContainerCustom(
                      height: 540.h,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(28.r),
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple.shade800,
                          Colors.deepPurple.shade600,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  ContainerCustom(
                    height: 535.h,
                    borderRadius: BorderRadius.circular(17.r),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 208, 187, 245),
                        Color(0xFFF8F6FF),
                        Color(0xFFF8F6FF),
                        Color(0xFFF8F6FF),
                        Color(0xFFF8F6FF),
                        Color.fromARGB(255, 210, 192, 241)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Days of Week
                        GridView.count(
                          padding: EdgeInsets.only(),
                          crossAxisCount: 7,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _buildDaysOfWeek(),
                        ),

                        // Dates
                        GridView.count(
                          padding: EdgeInsets.only(),
                          crossAxisCount: 7,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _buildCalendarDays(
                              gameDailyHisotrystate.gameDailyHistory),
                        ),

                        const SizedBox(height: 20),
                        if (_selectedDate != null)
                          // 🎮 Play button
                          ZoomIn(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutBack,
                            child: ContainerCustom(
                              callback: () async {
                                final nextGame = GameDataModel(
                                  isDailyChallenge: true,
                                  date: _selectedDate!,
                                  id: uuid.v4(),
                                  levelType: 3,
                                  currentScore: 0,
                                  timeRemaining: AppLevelCondition()
                                      .getSecondsAvailable(3),
                                  addRowUsed: AppLevelCondition()
                                      .getAddRowsAvailable(3),
                                  hasCompleted: false,
                                  totalScore: 0,
                                );
                                await context
                                    .read<GameSessionCubit>()
                                    .start(nextGame.toModel());

                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: GamePlaySessionScreen(),
                                  ),
                                );
                              },
                              width: 300.w,
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFE040FB), Color(0xFF9C27B0)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(30.r),
                              shadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 126, 17, 146),
                                  blurRadius: .1.sp,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 1.sp,
                                ),
                              ],
                              child: Center(
                                child: TextCustomWidget(
                                  containerAlignment: Alignment.center,
                                  text: "Play",
                                  textStyle: GoogleFonts.fredoka(
                                    color: Color.fromARGB(255, 103, 25, 117),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 35.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return ContainerCustom();
      },
    );
  }
}

class InwardDiamondClipper extends CustomClipper<Path> {
  final double curve;

  InwardDiamondClipper({this.curve = 12});

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path();

    // Start at top center
    path.moveTo(w / 2, 0);

    // Top → Right (curving inward)
    path.quadraticBezierTo(w / 2, h * 0.20, w, h / 2);

    // Right → Bottom (curving inward)
    path.quadraticBezierTo(w / 2, h * 0.80, w / 2, h);

    // Bottom → Left (curving inward)
    path.quadraticBezierTo(w / 2, h * 0.80, 0, h / 2);

    // Left → Top (curving inward)
    path.quadraticBezierTo(w / 2, h * 0.20, w / 2, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
