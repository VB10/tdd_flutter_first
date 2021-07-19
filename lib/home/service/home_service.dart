// https://jsonplaceholder.typicode.com/users

import 'package:tdd_flutter_first/home/model/home_model.dart';
import 'package:vexana/vexana.dart';

abstract class IHomeService {
  final INetworkManager networkManager;

  IHomeService(this.networkManager);
  Future<List<ReqProfile>?> getAllItems();
}

class HomeService extends IHomeService {
  HomeService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<List<ReqProfile>?> getAllItems() async {
    final response = await networkManager.send<ReqProfile, List<ReqProfile>>('/users',
        parseModel: ReqProfile(), method: RequestType.GET);

    return response.data;
  }
}
