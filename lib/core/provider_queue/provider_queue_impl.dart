import 'package:uni_miskolc_datashare/core/provider_queue/provider_queue.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';

class ProviderQueueStoreImplementation implements ProviderQueueStore {
  List<ClientSubscribeModel> actualList = [];

  @override
  Null addClient(ClientSubscribeModel client) {
    actualList.add(client);
    return null;
  }

  @override
  List<ClientSubscribeModel> getClientList() {
    return actualList;
  }

  @override
  Null removeClient(ClientSubscribeModel client) {
    actualList
        .removeWhere((element) => element.userFCMToken == client.userFCMToken);
  }
}
