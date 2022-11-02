import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyEvent {}

//Event LoginPageView
class EventLoginPageView extends MyEvent{}

//Event pageStudentListView
class EventPageStudentListView extends MyEvent {}

//Event Map
class EventMap extends MyEvent {}

@immutable
abstract class MyState {}

class StateLoginPageView extends MyState{}
class StatePageStudentListView extends MyState {}
class StateMap extends MyState {}

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(StateLoginPageView()) {
    on<EventLoginPageView>((event, emit) => emit(StateLoginPageView()));
    on<EventPageStudentListView>((event,emit) => emit(StatePageStudentListView()));
    on<EventMap>((event, emit) => emit(StateMap()));
  }
}