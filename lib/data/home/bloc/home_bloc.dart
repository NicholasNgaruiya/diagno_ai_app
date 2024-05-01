import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_frontend/features/home/models/quotes_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Timer _timer;
  HomeBloc() : super(HomeInitial()) {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        add(FetchQuotesEvent());
      },
    );
    on<FetchQuotesEvent>(fetchQuotesEvent);
  }

  FutureOr<void> fetchQuotesEvent(FetchQuotesEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    try {
      final String jsonString = await rootBundle.loadString('assets/json/health_quotes.json');
      final List<dynamic> data = jsonDecode(jsonString);
      final List<Quote> quotes = data.map((json) => Quote.fromJson(json)).toList();
      final random = Random();
      final index = random.nextInt(quotes.length);
      emit(QuotesLoadedState(text: quotes[index].text, author: quotes[index].author));
    } catch (e) {
      print('Error loading quotes: $e');
      emit(const QuotesErrorLoadingState(error: 'Error loading quote'));
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
