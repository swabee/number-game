import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_game/constant/app_constants.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/custom/text_custom.dart';
import 'package:number_game/features/app_data/data/models/app_data_model.dart';
import 'package:number_game/features/app_data/presentation/bloc/app_data_bloc.dart';

class HomeSettingsDialog extends StatefulWidget {
  const HomeSettingsDialog({super.key});

  @override
  State<HomeSettingsDialog> createState() => _HomeSettingsDialogState();
}

class _HomeSettingsDialogState extends State<HomeSettingsDialog> {
  late bool soundEnabled;
  late bool notificationEnabled;

  @override
  void initState() {
    super.initState();
    final state = context.read<AppDataBloc>().state;
    if (state is AppDataLoaded) {
      soundEnabled = state.appDataEntity.soundPermissionEnabled;
      notificationEnabled = state.appDataEntity.notificationPermissionEnabled;
    } else {
      soundEnabled = false;
      notificationEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(
      builder: (context, state) {
        if (state is! AppDataLoaded) return const SizedBox.shrink();

        final appData = state.appDataEntity;

        return Material(
          color: Colors.transparent,
          child: ContainerCustom(
            borderRadius: BorderRadius.circular(12.r),
            margin: EdgeInsets.symmetric(horizontal: 17.w,vertical: 200.h),
            bgColor: const Color.fromARGB(233, 152, 171, 237),
            height: 450.h,
            child: Column(
              children: [
                // Header
                ContainerCustom(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r)),
                  bgColor: primaryColor,
                  height: 65.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContainerCustom(
                        marginRight: 5.w,
                        marginTop: 5.h,
                        callback: () {
                   
                          Navigator.pop(
                              context,
                              AppDataModel(
                                totalHindBalance: appData.totalHindBalance,
                                soundPermissionEnabled: soundEnabled,
                                notificationPermissionEnabled:
                                    notificationEnabled,
                                bestScore: appData.bestScore,
                                lastRewardTakenLevel:
                                    appData.lastRewardTakenLevel,
                              ));
                        },
                        border: Border.all(
                          color: const Color.fromARGB(125, 55, 5, 141),
                        ),
                        gradient: const RadialGradient(
                          colors: [
                            Color.fromARGB(255, 144, 92, 234),
                            Color.fromARGB(255, 130, 67, 238),
                          ],
                        ),
                        height: 50.h,
                        width: 50.h,
                        borderRadius: BorderRadius.circular(60.sp),
                        child: Center(
                            child: Icon(
                          Icons.close,
                          color: const Color.fromARGB(255, 172, 138, 252),
                          size: 30.sp,
                        )),
                      ),
                    ],
                  ),
                ),

                ContainerCustom(
                  marginRight: 10.w,
                  marginLeft: 10.w,
                  marginTop: 30.h,
                  child: Column(
                    children: [
               
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.volume_down_rounded,
                                size: 35.sp,
                                color: primaryColor,
                              ),
                              SizedBox(width: 10.w),
                              TextCustomWidget(
                                text: 'Sound',
                                textStyle: GoogleFonts.fredoka(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w800,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                          Switch(
                            value: soundEnabled,
                            onChanged: (value) {
                              setState(() => soundEnabled = value);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.notifications,
                                size: 35.sp,
                                color: primaryColor,
                              ),
                              SizedBox(width: 10.w),
                              TextCustomWidget(
                                text: 'Notification',
                                textStyle: GoogleFonts.fredoka(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w800,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                          Switch(
                            value: notificationEnabled,
                            onChanged: (value) {
                              setState(() => notificationEnabled = value);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.privacy_tip,
                                size: 35.sp,
                                color: primaryColor,
                              ),
                              TextCustomWidget(
                                text: 'Privacy Policy',
                                textStyle: GoogleFonts.fredoka(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w800,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 32.sp,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 35.sp,
                                color: primaryColor,
                              ),
                              TextCustomWidget(
                                text: 'Contact Us',
                                textStyle: GoogleFonts.fredoka(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w800,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 32.sp,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//
