import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
      path.join(dbPath, 'recent.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE recent_searches(recent TEXT)');
      },
      version: 1
  );
  return db;
}

class DataNotifier extends StateNotifier<List<dynamic>> {
  DataNotifier() : super(const []);

  Future<void> addWeatherDetails(String city) async {
    city = city.trim();
    final url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?appid=d1f540e7e28df7f2e396f4a76ba682b3&q=$city&units=metric');

    final response = await http.get(url);
    final resData = json.decode(response.body);
    var data = {};
    var image;
    if (resData['cod'] == 200) {
      data = {
        'cod': resData['cod'],
        'name': resData['name'],
        'temperature': resData['main']['temp'].toString(),
        'humidity': resData['main']['humidity'].toString(),
        'wind speed': resData['wind']['speed'].toString(),
        'icon': resData['weather'][0]['icon'],
        'condition': resData['weather'][0]['description'],
      };
      image = Image.network('http://openweathermap.org/img/w/${data['icon']}.png', fit: BoxFit.cover, height: double.infinity, width: double.infinity,);
    }
    else {
      data = resData;
    }
      state = [data, image];
    }
  }

final dataProvider = StateNotifierProvider<DataNotifier, List<dynamic>>((ref) => DataNotifier());


class RecentNotifier extends StateNotifier<List<String>> {
  RecentNotifier() : super([]);

  Future<void> loadRecent() async {
    final db = await _getDatabase();
    final data = await db.query('recent_searches');
    final recent = data.map((row) => row['recent'] as String).toList().reversed.toList();

    state = recent ;
  }

  void deleteRecent(String city) async {
    final db = await _getDatabase();
    if(state.contains(city.toLowerCase())) {
      state.remove(city.toLowerCase());
      db.delete('recent_searches', where: 'recent = ?', whereArgs: [city.toLowerCase()]);
    }
    state = state;
  }

  void addRecent(String city) async {
    final db = await _getDatabase();
    if(state.contains(city.toLowerCase())) {
      state.remove(city.toLowerCase());
      db.delete('recent_searches', where: 'recent = ?', whereArgs: [city.toLowerCase()]);
    }

    db.insert('recent_searches', {'recent' : city.toLowerCase()});

    state = [city.toLowerCase(), ...state];
  }

  void clear() async {
    final db = await _getDatabase();
    state.clear();
    db.delete('recent_searches');
    state = [];
  }
}

final recentProvider = StateNotifierProvider<RecentNotifier, List<String>>((ref) => RecentNotifier());