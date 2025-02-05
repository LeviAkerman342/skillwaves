// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:myapp/core/data/model/course.dart';

import '../../core/services/local_storage/local_storage_curse.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final LocalStorageService _localStorageService = LocalStorageService();
  late List<Course> _favoriteCourses;

  @override
  void initState() {
    super.initState();
    _loadFavoriteCourses();
  }

  Future<void> _loadFavoriteCourses() async {
    final List<Course> favoriteCourses =
        await _localStorageService.getFavoriteCourses();
    setState(() {
      _favoriteCourses = favoriteCourses;
    });
  }

  Future<void> _removeFromFavorites(Course course) async {
    await _localStorageService.removeFavoriteCourse(course);
    _loadFavoriteCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: _favoriteCourses.isEmpty
          ? const Center(
              child: Text('Нет избранных курсов'),
            )
          : ListView.builder(
              itemCount: _favoriteCourses.length,
              itemBuilder: (context, index) {
                final Course course = _favoriteCourses[index];
                return ListTile(
                  title: Text(course.name),
                  subtitle: Text(course.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: () {
                      _removeFromFavorites(course);
                    },
                  ),
                );
              },
            ),
    );
  }
}
