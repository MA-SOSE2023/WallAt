import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';

import 'isar_folder.dart';
import 'isar_item_event.dart';
import '/pages/single_item/model/single_item.dart';

part 'isar_single_item.g.dart';

@collection
class IsarSingleItem {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  late String imagePath;

  late String description;

  late bool isFavorite;

  @Backlink(to: "items")
  final parentFolder = IsarLink<IsarFolder>();

  final events = IsarLinks<IsarItemEvent>();

  SingleItem toSingleItem() => SingleItem(
        id: id,
        title: title,
        description: description,
        image: FileImage(File(imagePath)),
        isFavorite: isFavorite,
        events: events.map((event) => event.toItemEvent()).toList(),
      );
}
