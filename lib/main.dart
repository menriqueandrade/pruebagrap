import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pruebagrap/pages/home_page.dart';

import 'pages/subscription_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink('https://apipruebasus.herokuapp.com/');

  final WebSocketLink webSocketLink = new WebSocketLink(
    'wss://apipruebasus.herokuapp.com/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final link = httpLink.concat(webSocketLink);

    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(
      GraphQLClient(cache: GraphQLCache(), link: link),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        // home: HomePage(),
        home: HomePage(),
      ),
    );
  }
}
