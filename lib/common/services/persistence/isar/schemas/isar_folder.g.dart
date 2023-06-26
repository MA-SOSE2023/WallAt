// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_folder.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarFolderCollection on Isar {
  IsarCollection<IsarFolder> get isarFolders => this.collection();
}

const IsarFolderSchema = CollectionSchema(
  name: r'IsarFolder',
  id: -7805229368695537870,
  properties: {
    r'isRoot': PropertySchema(
      id: 0,
      name: r'isRoot',
      type: IsarType.bool,
    ),
    r'title': PropertySchema(
      id: 1,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _isarFolderEstimateSize,
  serialize: _isarFolderSerialize,
  deserialize: _isarFolderDeserialize,
  deserializeProp: _isarFolderDeserializeProp,
  idName: r'id',
  indexes: {
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'folders': LinkSchema(
      id: -7870916985988617568,
      name: r'folders',
      target: r'IsarFolder',
      single: false,
    ),
    r'parentFolder': LinkSchema(
      id: -8436806462782148624,
      name: r'parentFolder',
      target: r'IsarFolder',
      single: true,
      linkName: r'folders',
    ),
    r'items': LinkSchema(
      id: -4924808400924372778,
      name: r'items',
      target: r'IsarSingleItem',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _isarFolderGetId,
  getLinks: _isarFolderGetLinks,
  attach: _isarFolderAttach,
  version: '3.1.0+1',
);

int _isarFolderEstimateSize(
  IsarFolder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _isarFolderSerialize(
  IsarFolder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isRoot);
  writer.writeString(offsets[1], object.title);
}

IsarFolder _isarFolderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarFolder();
  object.id = id;
  object.isRoot = reader.readBool(offsets[0]);
  object.title = reader.readString(offsets[1]);
  return object;
}

P _isarFolderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarFolderGetId(IsarFolder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarFolderGetLinks(IsarFolder object) {
  return [object.folders, object.parentFolder, object.items];
}

void _isarFolderAttach(IsarCollection<dynamic> col, Id id, IsarFolder object) {
  object.id = id;
  object.folders.attach(col, col.isar.collection<IsarFolder>(), r'folders', id);
  object.parentFolder
      .attach(col, col.isar.collection<IsarFolder>(), r'parentFolder', id);
  object.items.attach(col, col.isar.collection<IsarSingleItem>(), r'items', id);
}

extension IsarFolderQueryWhereSort
    on QueryBuilder<IsarFolder, IsarFolder, QWhere> {
  QueryBuilder<IsarFolder, IsarFolder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhere> anyTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'title'),
      );
    });
  }
}

extension IsarFolderQueryWhere
    on QueryBuilder<IsarFolder, IsarFolder, QWhereClause> {
  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> titleEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> titleNotEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> titleGreaterThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [title],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> titleLessThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [],
        upper: [title],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> titleBetween(
    String lowerTitle,
    String upperTitle, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [lowerTitle],
        includeLower: includeLower,
        upper: [upperTitle],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> titleStartsWith(
      String TitlePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [TitlePrefix],
        upper: ['$TitlePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [''],
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterWhereClause> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ));
      }
    });
  }
}

extension IsarFolderQueryFilter
    on QueryBuilder<IsarFolder, IsarFolder, QFilterCondition> {
  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> isRootEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRoot',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension IsarFolderQueryObject
    on QueryBuilder<IsarFolder, IsarFolder, QFilterCondition> {}

extension IsarFolderQueryLinks
    on QueryBuilder<IsarFolder, IsarFolder, QFilterCondition> {
  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> folders(
      FilterQuery<IsarFolder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'folders');
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      foldersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'folders', length, true, length, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> foldersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'folders', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      foldersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'folders', 0, false, 999999, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      foldersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'folders', 0, true, length, include);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      foldersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'folders', length, include, 999999, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      foldersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'folders', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> parentFolder(
      FilterQuery<IsarFolder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'parentFolder');
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      parentFolderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parentFolder', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> items(
      FilterQuery<IsarSingleItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'items');
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', length, true, length, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition> itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, false, 999999, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, true, length, include);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', length, include, 999999, true);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterFilterCondition>
      itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'items', lower, includeLower, upper, includeUpper);
    });
  }
}

extension IsarFolderQuerySortBy
    on QueryBuilder<IsarFolder, IsarFolder, QSortBy> {
  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> sortByIsRoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoot', Sort.asc);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> sortByIsRootDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoot', Sort.desc);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarFolderQuerySortThenBy
    on QueryBuilder<IsarFolder, IsarFolder, QSortThenBy> {
  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> thenByIsRoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoot', Sort.asc);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> thenByIsRootDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoot', Sort.desc);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarFolderQueryWhereDistinct
    on QueryBuilder<IsarFolder, IsarFolder, QDistinct> {
  QueryBuilder<IsarFolder, IsarFolder, QDistinct> distinctByIsRoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRoot');
    });
  }

  QueryBuilder<IsarFolder, IsarFolder, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension IsarFolderQueryProperty
    on QueryBuilder<IsarFolder, IsarFolder, QQueryProperty> {
  QueryBuilder<IsarFolder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarFolder, bool, QQueryOperations> isRootProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRoot');
    });
  }

  QueryBuilder<IsarFolder, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
