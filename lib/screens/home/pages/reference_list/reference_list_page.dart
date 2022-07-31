import 'package:aloqa_nazorati/screens/home/data/model/reference_list_response.dart';
import 'package:aloqa_nazorati/screens/home/pages/reference_send/page/reference_send_view.dart';
import 'package:aloqa_nazorati/screens/home/pages/reference_list/bloc/reference_list_bloc.dart';
import 'package:aloqa_nazorati/screens/home/pages/reference_list/bloc/reference_list_state.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/network/reference_repository.dart';

class ReferenceListPage extends StatefulWidget {
  final ReferenceListResponse data;

  const ReferenceListPage(this.data, {Key? key}) : super(key: key);

  @override
  State<ReferenceListPage> createState() => _ReferenceListPageState();
}

class _ReferenceListPageState extends State<ReferenceListPage> {
  final ReferenceListBloc _bloc = ReferenceListBloc(ReferenceRepository());

  @override
  void initState() {
    super.initState();
    _bloc.referencesServiceList(widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          leading: const BackButton(),
          title: const Text("Muammo turini tanlang",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 22)),
          backgroundColor: ColorsUtils.myColor,
        ),
        body: BlocListener<ReferenceListBloc, ReferenceListState>(
          listener: (context, state) {},
          bloc: _bloc,
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is SuccessState) {
                return _body(state.response);
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
        ));
  }

  Widget _body(List<ReferenceListResponse> response) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: Card(
            color: Colors.white,
            child: Center(
              child: Text(
                widget.data.name.uz,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: ColorsUtils.myColor,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
        Expanded(
            child: ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: response.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ReferenceSendPage()));
              },
              title: Text(response[index].name.uz,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      )),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ))
      ],
    );
  }
}
