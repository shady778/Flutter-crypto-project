import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/Routes/AppRouter.dart';
import 'core/local/DbHelper.dart';
import 'core/local/PrefHelper.dart';
import 'data/DataSource/LocalDataSource/LocalDataSource.dart';
import 'data/DataSource/RemoteDatasource/RemoteDataSource.dart';
import 'data/Repositories/AppRepo.dart';
import 'presentation/cubits/app_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  final dbHelper = DbHelper();
  final localDataSource = LocalDataSource(dbHelper);
  final remoteDataSource = RemoteDataSource();
  final appRepo = AppRepo(localDataSource, remoteDataSource);

  runApp(MyApp(appRepo: appRepo));
}

class MyApp extends StatelessWidget {
  final AppRepo appRepo;
  const MyApp({super.key, required this.appRepo});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: appRepo,
      child: BlocProvider(
        create: (context) => AppCubit(appRepo)..loadAllData(),
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}
