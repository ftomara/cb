import 'package:cb/Data/sketch.dart';

class UndoRedoState {
  List<Sketch> undoList;
  List<Sketch> redoList;

  UndoRedoState({
    required this.undoList,
    required this.redoList,
  });

  UndoRedoState copyWith({
    List<Sketch>? undoList,
    List<Sketch>? redoList,
    bool? isRedoMode,
  }) {
    return UndoRedoState(
      undoList: undoList ?? this.undoList,
      redoList: redoList ?? this.redoList,
    );
  }
}
