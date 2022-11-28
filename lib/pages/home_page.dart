import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pruebagrap/main.dart';

import '../models/book_model.dart';

class HomePage extends StatelessWidget {
  final getBooks = """
    query {
      books {
        id
        title
        author
      }
    }""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books - GraphQL'),
      ),
      body: Container(
        child: Query(
          options: QueryOptions(document: gql(getBooks)),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Center(
                child: Text(result.exception.toString()),
              );
            }
            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final booksJson = result.data!["books"];
            final books = booksJson.map((b) => Book.fromJson(b)).toList();

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(books[i].title),
                  subtitle: Text(books[i].author),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.update),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
      ),
    );
  }
}
