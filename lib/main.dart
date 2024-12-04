import 'package:cb/Data/offsetAdapter.dart';
import 'package:cb/Data/sketch.dart';
import 'package:cb/Logic/propertiescubit.dart';
import 'package:cb/Logic/undo_redo_cubit.dart';
import 'package:cb/Presentation/Screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

//
// echo 'export PATH="/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home:$PATH"' >> ~/.zshrc
// echo 'export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home"' >> ~/.zshrc

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("IMbox");
  Hive.registerAdapter(SketchAdapter());
  Hive.registerAdapter(OffsetAdapter());
  Hive.registerAdapter(ColorAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Make the status bar transparent
        statusBarIconBrightness: Brightness.light, // Icons will be dark
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<Propertiescubit>(create: (context) => Propertiescubit()),
          BlocProvider<UndoRedoCubit>(create: (context) => UndoRedoCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0XFF8842EC)),
            useMaterial3: true,
          ),
          // home: P(),
          home: const Homescreen(),
          // home: Zoom(),
          // home: Paintscreen(),
        ),
      ),
    );
  }
}
