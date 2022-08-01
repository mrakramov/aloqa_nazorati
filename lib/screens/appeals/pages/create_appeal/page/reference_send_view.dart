import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/reference_send_cubit.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/reference_send_state.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/address_text_field.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/custom_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/custom_form_field.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/file_add_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/location_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/optional_text.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReferenceSendPage extends StatefulWidget {
  final int? reference_parent_id;
  final int? reference_id;
  const ReferenceSendPage(
      {super.key,
      required this.reference_parent_id,
      required this.reference_id});

  @override
  State<ReferenceSendPage> createState() => _ReferenceSendPageState();
}

class _ReferenceSendPageState extends State<ReferenceSendPage> {
  final ReferenceSendCubit _cubit = ReferenceSendCubit(AppealRepository());
  Size? _size;
  final key = GlobalKey<FormState>();
  int? regionId = -1;

  TextEditingController? murojatController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  @override
  void initState() {
    _cubit.getRegions();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    murojatController!.dispose();
    addressController!.dispose();
    super.dispose();
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
              child: getBody(),
            ),
          )),
    );
  }

  Widget getBody() {
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
            BlocBuilder<ReferenceSendCubit, ReferenceSendState>(
                // bloc: _cubit,
                builder: (context, state) {
              if (state is RegionsSuccessState && state.regions.isNotEmpty) {
                if (kDebugMode) {
                  for (var element in state.regions) {
                    print(element.id);
                  }
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.regions.length,
                    itemBuilder: (context, index) => Card(
                          child: ListTile(
                              title: Text(
                                  state.regions[index].name!.uz.toString())),
                        ));
                // return Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: TextField(
                //     decoration: InputDecoration(
                //         isDense: true,
                //         floatingLabelBehavior: FloatingLabelBehavior.auto,
                //         labelText: 'Viloyatni tanlang',
                //         focusColor: ColorsUtils.myColor,
                //         floatingLabelStyle:
                //             const TextStyle(color: ColorsUtils.myColor),
                //         focusedBorder: const OutlineInputBorder(
                //             borderSide: BorderSide(
                //           color: ColorsUtils.myColor,
                //         )),
                //         border: const OutlineInputBorder(
                //             borderSide: BorderSide(
                //           color: ColorsUtils.myColor,
                //         )),
                //         suffixIcon: const Icon(
                //           Icons.expand_more_outlined,
                //           color: Colors.grey,
                //         ),
                //         prefix: DropdownButton<int?>(
                //             isExpanded: true,
                //             value: regionId!,
                //             isDense: true,
                //             icon: const SizedBox.shrink(),
                //             underline: const SizedBox.shrink(),
                //             items: [
                //               for (var i = 0; i < state.regions.length; i++)
                //                 DropdownMenuItem(
                //                     value: i,
                //                     child: Text(
                //                         state.regions[i].name!.uz!.toString())),
                //             ],
                //             onChanged: (value) {
                //               regionId = value!;
                //               setState(() {});
                //             })),
                //   ),
                // );

              }
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }),

            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: AddressTextField(
                controller: addressController!,
                labelText: 'Viloyatni tanlang',
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

            ///location button
            LocationButton(
              size: _size,
              text: "Lokatsiyani belgilash",
              callBack: () {},
            ),
            OptionalText(
                context: context, text: "(Loksiya belgilash ixtiyoriy)"),

            ///Murojat matni
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomFormField(
                size: _size,
                text: 'Murojat matni',
                keyForm: key,
                controller: murojatController,
              ),
            ),

            ///common button
            FileAddButtonAndCamera(
              context: context,
              callBackForCamera: () {},
              callBackForFile: () {},
              text: "Fayl biriktirish",
            ),

            ///optional text
            OptionalText(
                context: context, text: "(pdf,doc,docx,xls,jpg,jpeg,png)"),
            const SizedBox(
              height: 30,
            ),

            ///Yuborish button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size!.width * 0.05),
              child: CustomButton(
                size: _size,
                context: context,
                text: "Yuborish",
                callBack: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
