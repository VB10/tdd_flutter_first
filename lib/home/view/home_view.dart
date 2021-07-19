import 'package:flutter/material.dart';
import 'package:tdd_flutter_first/home/service/home_service.dart';
import 'package:tdd_flutter_first/home/viewModel/home_view_model.dart';
import 'package:tdd_flutter_first/product/cache/home_cache.dart';
import 'package:tdd_flutter_first/product/product_constants.dart';
import 'package:vexana/vexana.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final IHomeViewModel homeViewModel;
  @override
  void initState() {
    super.initState();
    final manager = NetworkManager(isEnableLogger: true, options: BaseOptions(baseUrl: ProductConstants.BASE_URL));
    homeViewModel = HomeViewModel(setState, HomeCacheShared(time: 100000), HomeService(manager), showScaffoldMessage);
    homeViewModel.fetchAllDatas();
  }

  void showScaffoldMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ok')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeViewModel.backgroundColor,
      appBar: AppBar(title: Text(homeViewModel.title ?? '')),
      body: homeViewModel.isLoading ? buildIndicator() : buildListReqPRofile(),
    );
  }

  Widget buildIndicator() => Center(child: CircularProgressIndicator.adaptive());

  ListView buildListReqPRofile() {
    return ListView.builder(
      itemCount: homeViewModel.reqProfiles.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          homeViewModel.cacheItItem(homeViewModel.reqProfiles[index]);
        },
        leading: CircleAvatar(child: Text(homeViewModel.reqProfiles[index].id.toString())),
        title: Text(homeViewModel.reqProfiles[index].name ?? ''),
      ),
    );
  }
}
