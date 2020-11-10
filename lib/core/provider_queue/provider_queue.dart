import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';

abstract class ProviderQueueStore {
  Null addClient(ClientSubscribeModel client);
  Null removeClient(ClientSubscribeModel client);
  List<ClientSubscribeModel> getClientList();
}
