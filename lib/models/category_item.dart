import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String name;
  final Icon icon;
  // final String language;
  final bool isPage;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
    // required this.language,
    required this.isPage,
  });

  factory CategoryItem.fromJson(Map<String, String> json) {
    return CategoryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      // language: json['language'] as String,
      icon: const Icon(CupertinoIcons.doc_append),
      isPage: true,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryItem &&
          runtimeType == other.runtimeType &&
          id == other.id;
}

enum KFilterValue { id, icon }

final List<CategoryItem> kNewsCategories = [
  const CategoryItem(
    id: "",
    name: "General",
    icon: Icon(CupertinoIcons.collections),
    isPage: false,
  ),
  const CategoryItem(
    id: "sports",
    name: "Sports",
    icon: Icon(Icons.sports),
    isPage: false,
  ),
  const CategoryItem(
    id: "business",
    name: "Business",
    icon: Icon(Icons.business),
    isPage: false,
  ),
  const CategoryItem(
    id: "technology",
    name: "Technology",
    icon: Icon(Icons.computer),
    isPage: false,
  ),
  const CategoryItem(
    id: "entertainment",
    name: "Entertainment",
    icon: Icon(Icons.movie),
    isPage: false,
  ),
  const CategoryItem(
    id: "health",
    name: "Health",
    icon: Icon(Icons.healing),
    isPage: false,
  ),
  const CategoryItem(
    id: "science",
    name: "Science",
    icon: Icon(Icons.healing),
    isPage: false,
  ),
];

List<CategoryItem> kFamousNewspapers = [
  const CategoryItem(
    id: "bbc-news",
    name: "BBC",
    icon: Icon(CupertinoIcons.doc_append),
    isPage: true,
  ),
  const CategoryItem(
    id: "cbc-news",
    name: "CBC",
    icon: Icon(CupertinoIcons.doc_append),
    isPage: true,
  )
];
