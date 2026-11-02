import 'dart:math';
import 'package:dio/dio.dart';
import '../models/todo.dart';

final _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

Future<T> withRetry<T>(Future<T> Function() op) async {
  for (var i = 0;; i++) {
    try {
      return await op();
    } catch (e) {
      if (i == 4) rethrow;
      final b = 400 * (1 << i);
      final delay = b + Random().nextInt(b);
      print('Attempt ${i + 1} failed. Retrying in $delay ms...');
      await Future.delayed(Duration(milliseconds: delay));
    }
  }
}

Future<List<Todo>> fetchTodos() async {
  return withRetry(() async {
    final res = await _dio.get('/todos'); 
    final raw = res.data as List<dynamic>;
    return raw.map((j) => Todo.fromJson(j as Map<String, dynamic>)).toList();
  });
}