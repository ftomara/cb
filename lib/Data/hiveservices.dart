import 'dart:typed_data';
import 'package:cb/Data/sketch.dart';
import 'package:hive/hive.dart';

class Hiveservices {
  
  Future<List<Uint8List>> getImages() async {
    var box = Hive.box("IMbox");
    List<dynamic> list = box.get('Images') ?? [];
    // Filter the list to ensure all elements are of type Uint8List
    return list.whereType<Uint8List>().toList();
  }

  Future<void> storeImage(Uint8List image) async {
    var box = Hive.box("IMbox");
    List<dynamic> images = box.get("Images") ?? [];
    images.add(image);
    await box.put("Images", images);
  }

  Future<void> updateImageAt(int index, Uint8List image) async {
   var box = Hive.box("IMbox");
    List<dynamic> images = box.get("Images") ?? [];
    images[index] = image;
    await box.put("Images", images);
}


  Future<List<List<Sketch>>> getSketches() async {
    var box = await Hive.openBox("SKbox");
    
    List<dynamic> list = box.get('sketches') ?? [];
    // Filter the list to ensure all elements are of type Uint8List
    return list.whereType<List<Sketch>>().toList();
  }

  Future<void> storeSketch(List<Sketch> sk) async {
    var box = await Hive.openBox("SKbox");
    List<dynamic> sketches = box.get("sketches") ?? [];
    sketches.add(sk);
    await box.put("sketches", sketches);
  }

  Future<void> updateSketchAt(int index, List<Sketch> sk) async {
   var box = await Hive.openBox("SKbox");
    List<dynamic> sketches = box.get("sketches") ?? [];
    sketches[index] = sk;
    await box.put("sketches", sketches);
}
}


