import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import '/router/router.dart';
import '/common/provider.dart';
import '/common/services/persistence/persistence_service.dart';
import '/pages/folders/folder_model.dart';
import '/pages/single_item/model/single_item.dart';

List<String> randomItemTitles = [
  'An item',
  'Another item',
  'Yet another item',
  'Example item',
  'Example item elsewhere',
  'Some item',
  'Some other item'
];

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future<String> imagePath1 =
    getImageFileFromAssets('dev_debug_images/hampter1.jpg')
        .then((value) => value.path);
Future<String> imagePath2 =
    getImageFileFromAssets('dev_debug_images/example_document.png')
        .then((value) => value.path);

Future<List<SingleItem>> createExampleItems(
    PersistenceService service, int? folder,
    {int count = 10}) {
  return Future.wait(
    List.generate(
      count,
      (index) async => service.createSingleItem(
        title: randomItemTitles[index % randomItemTitles.length],
        imagePath: index % 2 == 0 ? (await imagePath1) : (await imagePath2),
        description:
            'This is ${randomItemTitles[index % randomItemTitles.length]}',
        parentFolderId: folder,
      ),
    ),
  );
}

Future<List<Folder>> createExampleFolders(PersistenceService service) async {
  Future<Folder> containerFolder = service.createFolder(title: 'Nested folder');

  createExampleItems(service, null);
  containerFolder
      .then((folder) => createExampleItems(service, folder.id, count: 5));

  Future<List<Future<Folder>>> subFolders = containerFolder.then(
    (folder) => List.generate(2, (index) async {
      Future<Folder> createdFolder = service.createFolder(
          title: 'Sub folder $index', parentFolderId: folder.id);
      createExampleItems(service, (await createdFolder).id);
      return createdFolder;
    }),
  );

  List<Future<Folder>> normalFolders = List.generate(3, (index) async {
    Future<Folder> createdFolder =
        service.createFolder(title: 'Example folder $index');
    createExampleItems(service, (await createdFolder).id,
        count: 10 - index * 4);
    return createdFolder;
  });

  return Future.wait(
      [containerFolder, ...(await subFolders), ...normalFolders]);
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Call to this provider should open the database
    PersistenceService persistence =
        ref.read(Providers.persistenceServiceProvider);

    // Place the asset image in the app's document directory so that it can be
    // accessed by the database

    // Create example folders and items if the database is empty
    persistence.getRecentItems().then((items) {
      if (items.isEmpty) {
        createExampleFolders(persistence);
      }
    });

    return CupertinoApp.router(
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routerDelegate: Routers.globalRouterDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}

void main() =>
    {tz.initializeTimeZones(), runApp(const ProviderScope(child: App()))};
