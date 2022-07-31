import 'package:aloqa_nazorati/screens/home/data/network/reference_repository.dart';
import 'package:aloqa_nazorati/screens/home/pages/reference_list/reference_list_page.dart';
import 'package:aloqa_nazorati/screens/home/pages/references/bloc/reference_bloc.dart';
import 'package:aloqa_nazorati/screens/home/pages/references/bloc/reference_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/utils.dart';
import '../../data/model/reference_list_response.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ReferenceBloc _bloc = ReferenceBloc(ReferenceRepository());

  @override
  void initState() {
    super.initState();
    _bloc.references();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            title: const Text("Aloqa nazorati",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 22)),
            backgroundColor: ColorsUtils.myColor,
          ),
          body: BlocListener<ReferenceBloc, ReferenceState>(
            listener: (context, state) {},
            bloc: _bloc,
            child: BlocBuilder(
              bloc: _bloc,
              builder: (context, state) {
                if (state is SuccessState) {
                  return _referenceBody(state.response);
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
          )),
    );
  }

  _referenceBody(List<ReferenceListResponse> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Murojat yo'nalishini tanlang",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  childAspectRatio: 1.2),
              itemBuilder: (context, index) {
                return _itemCard(data[index], context);
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorsUtils.myColor)),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              highlightColor: ColorsUtils.myColor.withOpacity(0.2),
              onTap: () {
                _launchUrl(Uri.parse('tel:1144'));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      "Call Center",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorsUtils.myColor,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Text(
                      "1144",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorsUtils.myColor,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  _itemCard(ReferenceListResponse data, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ReferenceListPage(data)));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _loadImage(data.id),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data.name.uz,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  _loadImage(int id) {
    if (id == 9) {
      return Image.asset(
        "assets/images/ic_smartphone.png",
        height: 40,
        width: 40,
        color: ColorsUtils.myColor,
      );
    } else if (id == 2) {
      return Image.asset("assets/images/ic_telephone.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    } else if (id == 3) {
      return Image.asset("assets/images/ic_satellite.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    } else if (id == 6) {
      return Image.asset("assets/images/ic_mail.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    } else if (id == 10) {
      return Image.asset("assets/images/ic_television.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    } else if (id == 7) {
      return Image.asset("assets/images/ic_public.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    } else if (id == 97) {
      return Image.asset("assets/images/ic_cyber.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    } else if (id == 8) {
      return Image.asset("assets/images/ic_corruption.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    } else if (id == 5) {
      return Image.asset("assets/images/ic_agreement.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    } else if (id == 100) {
      return Image.asset("assets/images/ic_others.png",
          height: 40, width: 40, color: ColorsUtils.myColor);
    }
  }
}
