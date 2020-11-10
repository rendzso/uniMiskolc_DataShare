import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/data/available_data.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/core/provider_queue/provider_queue.dart';
import 'package:uni_miskolc_datashare/core/widgets/custom_input_field.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/data/datasources/provider_activity_remote_data_source.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/widgets/provider_drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class ProviderQueueList extends StatefulWidget {
  @override
  _ProviderQueueListState createState() => _ProviderQueueListState();
}

class _ProviderQueueListState extends State<ProviderQueueList> {
  FirebaseUser user;
  String name;
  List<ClientSubscribeModel> clientList;
  final availableDataList = AvailableData().availableDataValue;
  final availableDataNameList = AvailableData().availableDataName;
  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    name = user.displayName;
    clientList = injector.get<ProviderQueueStore>().getClientList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: ProviderDrawerMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            clientList.length == 0
                ? Center(
                    child: Text('There are no clients!'),
                  )
                : new ListView.builder(
                    shrinkWrap: true,
                    itemCount: clientList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new ListTile(
                              leading: Icon(Icons.person),
                              title: Text(clientList[index].userName),
                            ),
                            new ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  clientList[index].requiredDataList.length,
                              itemBuilder:
                                  (BuildContext context, int nestedIndex) {
                                return new CustomInputField(
                                  rowText: clientList[index]
                                      .requiredDataList[nestedIndex]
                                      .keys
                                      .first,
                                  initialString: clientList[index]
                                      .requiredDataList[nestedIndex]
                                      .values
                                      .first,
                                  isPassword: false,
                                  onlyText: true,
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('CALL'),
                                  onPressed: () {
                                    injector
                                        .get<ProviderActivityRemoteDataSource>()
                                        .sendCallRequest(
                                            providerName: name,
                                            clientSubscribeModel:
                                                clientList[index]);
                                  },
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('DELETE'),
                                  onPressed: () {
                                    setState(() {
                                      injector
                                          .get<ProviderQueueStore>()
                                          .removeClient(clientList[index]);
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
