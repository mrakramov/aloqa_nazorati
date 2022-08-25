import 'package:aloqa_nazorati/screens/appeals/data/model/AppealResponse.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/appeal_response_page.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/bloc/appeal_bloc.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/bloc/appeal_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

class AppealPage extends StatefulWidget {
  const AppealPage({Key? key}) : super(key: key);

  @override
  State<AppealPage> createState() => _AppealPageState();
}

class _AppealPageState extends State<AppealPage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  final AppealBloc _bloc = AppealBloc(AppealRepository());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _bloc.appeals(Prefs.load("token"));
    if (kDebugMode) {
      Prefs.load('token').then((value) => log(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          title: const Text("Mening murojatlaarim",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 22)),
          backgroundColor: const Color.fromRGBO(68, 30, 221, 1),
        ),
        body: BlocListener<AppealBloc, AppealState>(
          listener: (context, state) {},
          bloc: _bloc,
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is SuccessState) {
                return Column(
                  children: [
                    _initializeTab(),
                    Flexible(
                      child: TabBarView(controller: _tabController, children: [
                        _appealList(state.response.data, 0),
                        _appealList(state.response.data, 1),
                        _appealList(state.response.data, 2),
                      ]),
                    )
                  ],
                );
              } else if (state is UploadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorsUtils.myColor,
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  _initializeTab() {
    return TabBar(
        controller: _tabController,
        labelStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        labelColor: const Color.fromRGBO(68, 30, 221, 1),
        unselectedLabelColor: Colors.grey[900],
        indicator: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom:
                BorderSide(color: Color.fromRGBO(68, 30, 221, 1), width: 2.0),
          ),
        ),
        tabs: const [
          Tab(
            text: "Barchasi",
          ),
          Tab(
            text: "Ijrodagi",
          ),
          Tab(
            text: "Yakunlangan",
          )
        ]);
  }

  _dataNotFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/ic_not_found.png",
          height: 100,
          width: 100,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Ma'lumot topilmadi",
          style: TextStyle(
            fontFamily: 'Roboto',
            letterSpacing: 1,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  _appealData(List<Datum?>? data) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data!.length,
      itemBuilder: (context, index) {
        return _itemAppeal(data[index]!);
      },
    );
  }

  _appealList(List<Datum?>? data, int index) {
    if (index == 0) {
      if (data!.isNotEmpty) {
        return _appealData(data);
      }
      return _dataNotFound();
    } else if (index == 1) {
      var newL = data!
          .where((e) => int.parse(e!.status!) != 1 && int.parse(e.status!) != 5)
          .toList();
      if (newL.isNotEmpty) {
        return _appealData(newL);
      }
      return _dataNotFound();
    } else if (index == 2) {
      var newL = data!.where((e) => int.parse(e!.status!) == 5).toList();
      if (newL.isNotEmpty) {
        return _appealData(newL);
      }
      return _dataNotFound();
    }
  }

  _itemAppeal(Datum data) {
    var title = "";
    Color color = ColorsUtils.myColor;
    Color bgColor = ColorsUtils.myColor.withOpacity(0.2);
    switch (data.status) {
      case "1":
        {
          title = "Murojaat yaratildi";
          color = Colors.blueAccent;
          bgColor = Colors.blueAccent.withOpacity(0.2);
        }
        break;

      case "2":
        {
          title = "Ijroga yuborildi";
          color = Colors.orange;
          bgColor = Colors.orange.withOpacity(0.2);
        }
        break;

      case "3":
        {
          title = "Ijro qilinmoqda";
          color = Colors.blue;
          bgColor = Colors.blue.withOpacity(0.2);
        }
        break;

      case "4":
        {
          title = "Qabul qilishga yuborildi";
          color = Colors.redAccent;
          bgColor = Colors.redAccent.withOpacity(0.2);
        }
        break;

      case "5":
        {
          title = "Yakunlandi";
          color = Colors.green;
          bgColor = Colors.green.withOpacity(0.2);
        }
        break;
    }
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          log(data.file);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppealResponsePage(data)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                data.reference!.name!.uz!,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: color,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    data.sentAt.toString().split(" ").first,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
