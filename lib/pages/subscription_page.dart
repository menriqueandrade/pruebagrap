import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/book_model.dart';

class SubscriptionPage extends StatelessWidget {
  //const SubscriptionPage({Key key}) : super(key: key);

  final String addedBook = r"""
    subscription{
        bookAdded {
          id
          title
          author
        }
      }  
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Subscription'),
        ),
        body: SafeArea(
          child: Container(
            child: Subscription(
              options: SubscriptionOptions(document: gql(addedBook)),
              builder: (QueryResult result,
                  {FetchMore? fetchMore, VoidCallback? refetch}) {
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

                final bookJson = result.data!["bookAdded"];
                final book = Book.fromJson(bookJson);
                print(book);
                return ListView.builder(
          
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(book.title),
            
                );
              },
            );
              },
            ),
          ),
        ));
  }
}
