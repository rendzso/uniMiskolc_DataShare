import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/data/available_data.dart';
import 'package:uni_miskolc_datashare/core/widgets/custom_input_field.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/provider_request_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/bloc/main_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/widgets/provider_drawer_menu.dart';

class SubscribePage extends StatefulWidget {
  @override
  _SubscribePageState createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final availableDataList = AvailableData().availableDataValue;
  final availableDataNameList = AvailableData().availableDataName;
  UserDataModel userDataModel;
  ProviderRequestDataModel providerDataModel;

  @override
  void initState() {
    userDataModel = BlocProvider.of<MainActivityBloc>(context).state.props[0];
    providerDataModel =
        BlocProvider.of<MainActivityBloc>(context).state.props[1];

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: ProviderDrawerMenu(),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            Text('Are you sure, want to share your data with this Provider?'),
            CustomInputField(
              rowText: 'Provider Name: ',
              initialString: providerDataModel.providerName,
              isPassword: false,
              onlyText: true,
            ),
            Text('Your data to share: '),
            new ListView.builder(
                shrinkWrap: true,
                itemCount: providerDataModel.requiredDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new CustomInputField(
                    rowText: availableDataNameList[availableDataList
                        .indexOf(providerDataModel.requiredDataList[index])],
                    initialString: userDataModel.props[availableDataList
                        .indexOf(providerDataModel.requiredDataList[index])],
                    isPassword: false,
                    onlyText: true,
                  );
                }),
            RaisedButton(
                child: Text('Sure, send it!'),
                onPressed: () {
                  BlocProvider.of<MainActivityBloc>(context).add(
                      SaveSubscribeData(
                          providerFCMToken:
                              providerDataModel.providerFCMToken));
                }),
          ],
        ),
      ),
    );
  }
}