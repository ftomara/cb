import 'package:cb/Data/sketch.dart';
import 'package:cb/Logic/undo_redo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UndoRedoCubit extends Cubit<UndoRedoState> {
  UndoRedoCubit()
      : super(UndoRedoState(
          undoList: [],
          redoList: [],
        ));

  void clear() {
    final UndoList = List<Sketch>.from(state.undoList);
    UndoList.clear();
    final RedoList = List<Sketch>.from(state.redoList);
    RedoList.clear();
    emit(state.copyWith(undoList: UndoList, redoList: RedoList));
  }

  void addToList(Sketch sketch) {
    final updatedUndoList = List<Sketch>.from(state.undoList)..add(sketch);
    emit(state.copyWith(undoList: updatedUndoList));
  }

  void undo() {
    if (state.undoList.isNotEmpty) {
      final updatedUndoList = List<Sketch>.from(state.undoList);
      final sketch = updatedUndoList.removeLast();
      final updatedRedoList = List<Sketch>.from(state.redoList)..add(sketch);
      emit(
          state.copyWith(undoList: updatedUndoList, redoList: updatedRedoList));
    }
  }

  void redo() {
    if (state.redoList.isNotEmpty) {
      final updatedRedoList = List<Sketch>.from(state.redoList);
      final sketch = updatedRedoList.removeLast();
      final updatedUndoList = List<Sketch>.from(state.undoList)..add(sketch);
      emit(
          state.copyWith(undoList: updatedUndoList, redoList: updatedRedoList));
    }
  }

  void addToListList(List<Sketch> sketches) {
    emit(state.copyWith(undoList: sketches));
  }
}
