import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/custom/text_custom.dart';
import 'package:number_game/features/app_data/presentation/bloc/app_data_bloc.dart';

class HomeBestScoreTile extends StatelessWidget {
  const HomeBestScoreTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      alignment: Alignment.center,
      child: BlocBuilder<AppDataBloc, AppDataState>(
        builder: (context, state) {
          if(state is AppDataLoaded){
                return Column(
            children: [
              TextCustomWidget(
                marginTop: 40.h,
                text: 'All-Time Best Score',
                containerAlignment: Alignment.center,
                textStyle: GoogleFonts.fredoka(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 236, 175, 21)),
              ),
              TextCustomWidget(
                marginTop: 10.h,
                text: '🏆 ${state.appDataEntity.bestScore}',
                containerAlignment: Alignment.center,
                textStyle: GoogleFonts.fredoka(
                    fontSize: 37.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 236, 175, 21)),
              ),
            ],
          );
          }
          return Column(
            children: [
              TextCustomWidget(
                marginTop: 40.h,
                text: '',
                containerAlignment: Alignment.center,
                textStyle: GoogleFonts.fredoka(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 236, 175, 21)),
              ),
              TextCustomWidget(
                marginTop: 10.h,
                text: '',
                containerAlignment: Alignment.center,
                textStyle: GoogleFonts.fredoka(
                    fontSize: 37.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 236, 175, 21)),
              ),
            ],
          );
        },
      ),
    );
  }
}
