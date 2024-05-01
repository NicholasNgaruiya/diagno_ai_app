import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/data/home/bloc/home_bloc.dart';

class QuotesWidget extends StatelessWidget {
  const QuotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column();
      },
    );
  }
}
