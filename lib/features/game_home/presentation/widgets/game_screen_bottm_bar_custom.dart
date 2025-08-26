import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_game/constant/app_constants.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/custom/text_custom.dart';
import 'package:number_game/features/app_data/presentation/bloc/app_data_bloc.dart';
import 'package:number_game/features/game_session/presentation/cubit/game_session_cubit.dart';

class GameScreenBottmBarCustom extends StatelessWidget {
  const GameScreenBottmBarCustom(
      {super.key, required this.onHintClick, required this.onaddNewRow});
  final VoidCallback onaddNewRow;
  final VoidCallback onHintClick;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameSessionCubit, GameSessionState>(
      builder: (context, gameSessionstate) {
        return BlocBuilder<AppDataBloc, AppDataState>(
          builder: (context, appDatastate) {
            if (appDatastate is AppDataLoaded &&
                gameSessionstate.currentGame != null) {
              return ContainerCustom(
                gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(.5)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
                shadow: [
                  BoxShadow(
                      blurRadius: 5.sp,
                      spreadRadius: 6.sp,
                      offset: Offset(0, -3),
                      color: primaryColor.withOpacity(.9))
                ],
                bgColor: primaryColor,
                height: 110.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerCustom(
                      callback: () {
                        if (gameSessionstate.currentGame!.addRowUsed > 0) {
                          context.read<GameSessionCubit>().addNumbers();
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ContainerCustom(
                            border: Border.all(
                              color: const Color.fromARGB(255, 55, 5, 141),
                            ),
                            marginRight: 40.w,
                            gradient: RadialGradient(
                              colors: [
                                const Color.fromARGB(255, 55, 5, 141),
                                const Color.fromARGB(255, 71, 6, 182),
                              ],
                            ),
                            height: 70.h,
                            width: 70.h,
                            borderRadius: BorderRadius.circular(60.sp),
                            child: Center(
                                child: Icon(
                              Icons.add,
                              color: whiteColor,
                              weight: 40.sp,
                              size: 45.sp,
                            )),
                          ),
                          TextCustomWidget(
                            marginLeft: 10.h,
                            marginBottom: 50.h,
                            textColor: Colors.red,
                            text: gameSessionstate.currentGame!.addRowUsed
                                .toInt()
                                .toString(),
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ],
                      ),
                    ),
                    ContainerCustom(
                      callback: () {
                        if (appDatastate.appDataEntity.totalHindBalance > 0) {
                          context.read<GameSessionCubit>().showHint();
                          final newAppData = appDatastate.appDataEntity
                              .copyWith(
                                  totalHindBalance: appDatastate
                                          .appDataEntity.totalHindBalance -
                                      1.0);
                          context
                              .read<AppDataBloc>()
                              .add(AppDataUpdateEvent(newAppData.toModel()));
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ContainerCustom(
                            border: Border.all(
                              color: const Color.fromARGB(255, 55, 5, 141),
                            ),
                            marginLeft: 40.w,
                            gradient: RadialGradient(
                              colors: [
                                const Color.fromARGB(255, 55, 5, 141),
                                const Color.fromARGB(255, 71, 6, 182),
                              ],
                            ),
                            height: 70.h,
                            width: 70.h,
                            borderRadius: BorderRadius.circular(60.sp),
                            child: Center(
                                child: Icon(
                              Icons.lightbulb_outline,
                              color: whiteColor,
                              weight: 40.sp,
                              size: 45.sp,
                            )),
                          ),
                          TextCustomWidget(
                            marginLeft: 90.h,
                            marginBottom: 50.h,
                            textColor: Colors.red,
                            text: appDatastate.appDataEntity.totalHindBalance
                                .toInt()
                                .toString(),
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return ContainerCustom(
              gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withOpacity(.5)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
              shadow: [
                BoxShadow(
                    blurRadius: 5.sp,
                    spreadRadius: 6.sp,
                    offset: Offset(0, -3),
                    color: primaryColor.withOpacity(.9))
              ],
              bgColor: primaryColor,
              height: 110.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            );
          },
        );
      },
    );
  }
}
