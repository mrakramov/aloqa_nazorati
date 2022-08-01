import 'package:aloqa_nazorati/screens/home/data/network/reference_repository.dart';
import 'package:aloqa_nazorati/screens/home/pages/reference_send/bloc/reference_send_cubit.dart';
import 'package:aloqa_nazorati/screens/home/pages/reference_send/bloc/reference_send_state.dart';
import 'package:aloqa_nazorati/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReferenceSendPage extends StatefulWidget {
  const ReferenceSendPage({super.key});

  @override
  State<ReferenceSendPage> createState() => _ReferenceSendPageState();
}

class _ReferenceSendPageState extends State<ReferenceSendPage> {
  final ReferenceSendCubit _cubit = ReferenceSendCubit(ReferenceRepository());
  Size? _size;

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<ReferenceSendCubit, ReferenceSendState>(
        listener: (context, state) {},
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leading: const BackButton(),
              title: const Text("Murojat yuborish",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 22)),
              backgroundColor: ColorsUtils.myColor,
            ),
            body: SafeArea(
              child: Container(),
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: 'zero',
              key: const ValueKey('zero'),
              onPressed: () {
                // BlocProvider.of<ReferenceSendCubit>(context, listen: false)
                //     .referencesUpload();
                _cubit.referencesUpload();
              },
              child: const Icon(Icons.abc),
            )),
      ),
    );
  }

  Widget get getBody {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: SizedBox(
                width: _size!.width,
                child: Text(
                  'Murojaatingzni toliq tushuntiring',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Viloyatni tanlang',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(
                    Icons.expand_more_outlined,
                    color: Colors.grey,
                  ),
                  prefix: DropdownButton<String>(
                      isExpanded: true,
                      isDense: true,
                      icon: const SizedBox.shrink(),
                      underline: const SizedBox.shrink(),
                      items: const [
                        DropdownMenuItem(child: Text('Andijon')),
                      ],
                      onChanged: (value) {}),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(child: Text('Andijon')),
                    ],
                    onChanged: (value) {}),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    // hintText: 'Manzilni kiriting',
                    labelText: 'Manzilni kiriting',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: _size!.width * 0.18),
              height: 60,
              width: double.infinity,
              child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: ColorsUtils.myColor,
                      side: const BorderSide(color: ColorsUtils.myColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.mapLocationDot),
                  label: const Text("Lokatsiyani belgilash")),
            ),
            Text("(Loksiya belgilash ixtiyoriy)",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
