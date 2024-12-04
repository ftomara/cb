import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class Propertiescubit extends Cubit<List<dynamic>> {
  Propertiescubit() : super([false, Colors.black, 3.0, 5.0, 1]) {
    list = [false, Colors.black, 3.0, 5.0, 1];
  }
  List<dynamic> list = [];

  void setmode(bool value) {
    list[0] = value;
    emit(List<dynamic>.from(list));
  }

  void setcolor(Color value) {
    list[1] = value;
    emit(List<dynamic>.from(list));
  }

  void setstroke(double value) {
    list[2] = value;
    emit(List<dynamic>.from(list));
  }

  void setEraserstroke(double value) {
    list[3] = value;
    emit(List<dynamic>.from(list));
  }

  void setbrushmode(int value) {
    list[4] = value;
    emit(List<dynamic>.from(list));
  }

  void resetProperites() {
    list = [false, Colors.black, 3.0, 5.0, 1];
    emit(List<dynamic>.from(list));
  }
}
