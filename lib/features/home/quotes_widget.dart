import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/home/bloc/home_bloc.dart';
import '../../utils/constants/colors.dart';
import '../../utils/device/device_utility.dart';

class QuotesWidget extends StatelessWidget {
  const QuotesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: TColors.primaryColor,
            ),
          );
        } else if (state is QuotesLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              width: TDeviceUtils.getScreenWidth(context),
              // height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      '"${state.text}"',
                      // textAlign: TextAlign.center,
                      style: const TextStyle(
                        // fontStyle: FontStyle.italic,
                        // fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    width: double.infinity,
                    child: Text(
                      '- ${state.author}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
