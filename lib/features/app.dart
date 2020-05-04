import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource_impl.dart';

import 'session_handler/presentation/bloc/session_handler_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'UniMiskolc DataShare'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocProvider(
          create: (_) => injector<SessionHandlerBloc>(),
          child: BlocBuilder<SessionHandlerBloc, SessionHandlerState>(
              builder: (context, state) {
            if (state is Empty) {
              return RaisedButton(
                  child: Text('login'),
                  onPressed: () {
                    BlocProvider.of<SessionHandlerBloc>(context).add(
                        LogIn(email: 'test@test.com', password: 'testtest'));
                  });
            } else if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Ready) {
              return Text('logged in');
            } else if (state is Error) {
              return Text(state.message);
            }
          }),
        ));
  }
}
