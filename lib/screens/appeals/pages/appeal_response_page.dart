import 'package:aloqa_nazorati/screens/appeals/data/model/AppealResponse.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/appeal_list_responses/single_appeal_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/response_bloc/appeal_response_bloc.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/response_bloc/appeal_single_response_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

class AppealResponsePage extends StatefulWidget {
  final Datum data;

  const AppealResponsePage(this.data, {Key? key}) : super(key: key);

  @override
  State<AppealResponsePage> createState() => _AppealResponsePageState();
}

class _AppealResponsePageState extends State<AppealResponsePage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;
  final SingleAppealCubit _cubit = SingleAppealCubit(AppealRepository());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _cubit.singleAppeal(Prefs.load('token'), widget.data.code);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: const Text(
              "Mening murojaatlarim",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 22),
            ),
            backgroundColor: ColorsUtils.myColor,
          ),
          body: Column(
            children: [
              _initializeTab(),
              Flexible(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _appeal(),
                    _about(),
                    _response(),
                  ],
                ),
              ),
            ],
          )),
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
            text: "Murojat",
          ),
          Tab(
            text: "Ma'lumot",
          ),
          Tab(
            text: "Javob",
          )
        ]);
  }

  _appeal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Murojat kodi:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[800],
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.data.code!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Murojat turi:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[800],
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.data.reference!.name!.uz!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Biriktirilgan fayllar:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[800],
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<SingleAppealCubit, AppealSingleResponseState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state is SuccesState) {
                  return GridButtonsForDownloadFileWidget(
                    appeal: state.appeal,
                  );
                }

                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Murojat matni:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[800],
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.data.description!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _about() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Murojat holati:",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[800],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              getAppealStatus(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Murojat turi:",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[800],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.data.reference!.name!.uz!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Murojaat yaratilgan sana:",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[800],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.data.createdAt.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Murojaat ijroga yuborilgan sana:",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[800],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.data.sentAt.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Ijro etilish vaqti:",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[800],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.data.deletedAt.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Murojaat ijrosiga mas’ul bo’lim va hududiy inspeksiya:",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[800],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.data.ticketRegion!.name!.uz.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _response() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Biriktirilgan fayllar:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[800],
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: _checkFiles(),
          )
        ],
      ),
    );
  }

  String getAppealStatus() {
    String title = "";
    switch (widget.data.status) {
      case "1":
        {
          title = "Murojaat yaratildi";
        }
        break;
      case "2":
        {
          title = "Ijroga yuborildi";
        }
        break;

      case "3":
        {
          title = "Ijro qilinmoqda";
        }
        break;

      case "4":
        {
          title = "Qabul qilishga yuborildi";
        }
        break;

      case "5":
        {
          title = "Yakunlandi";
        }
        break;
    }
    return title;
  }

  _checkFiles() {
    // widget.data
    return _dataNotFound();
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
}

class GridButtonsForDownloadFileWidget extends StatelessWidget {
  final SingleAppealResponseModel? appeal;
  const GridButtonsForDownloadFileWidget({super.key, required this.appeal});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.1 / 1.1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5),
      shrinkWrap: true,
      itemCount: appeal!.data!.userFiles!.length,
      itemBuilder: (context, index) {
        final file = appeal!.data!.userFiles![index];
        return Card(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  side: const BorderSide(
                    color: ColorsUtils.myColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10)),
              onPressed: () {},
              child: Text(
                file.fileName!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: ColorsUtils.myColor),
              )),
        );
      },
    );
  }
}
