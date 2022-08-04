import 'package:aloqa_nazorati/screens/appeals/data/model/districts_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/regions_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/reference_send_cubit.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/reference_send_state.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/custom_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/custom_field_for_district.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/custom_form_field.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/file_add_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/location_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/optional_text.dart';
import 'package:aloqa_nazorati/utils/db/hive_db.dart';
import 'package:aloqa_nazorati/utils/di/locator.dart';
import 'package:aloqa_nazorati/utils/file/file_service.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  late int? regionId;
  late int? districtId;
  late DistrictsResponse? selectedDistrict;
  String? hintText = 'Viloyatni tanlang';
  String? hintTextDistrict = "Tumanni tanlang";

  TextEditingController? murojatController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    regionId = 1;
    districtId = 1;
    _cubit.getDistricts(regionId);
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

  void _onChangeDistricts(int? value, state) {
    districtId = value!;
    hintTextDistrict = state.districts
        .singleWhere((element) => element.id == districtId)
        .name!
        .uz;
    selectedDistrict =
        state.districts.singleWhere((element) => element.id == districtId);
    setState(() {});
  }

  void _onChangeRegions(int? value, dataResponse) {
    regionId = value!;
    hintText = dataResponse
        .singleWhere((element) => element!.id == regionId)!
        .name!
        .uz;
    _cubit.getDistricts(regionId);
    setState(() {});
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
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
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

            ///Regions from hive database
            FutureBuilder<List<Map<String, dynamic>>>(
                future: Future(() => serviceLocator
                    .get<HiveDB>()
                    .box
                    .get(Strings.regionsDataKey)),
                builder: (context, snapshot) {
                  List<DropdownMenuItem<int>> data = [];
                  if (snapshot.hasError) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }

                  if (snapshot.data!.isNotEmpty) {
                    List<RegionsResponse?>? dataResponse = snapshot.data!
                        .map((e) => RegionsResponse.fromJson(e))
                        .toList();
                    data.clear();
                    for (var item in dataResponse) {
                      data.add(DropdownMenuItem(
                          value: item!.id!,
                          child: Text(item.name!.oz!.toString())));
                    }

                    if (dataResponse.isEmpty) {
                      return const Center(child: CupertinoActivityIndicator());
                    }
                    return CustomFieldForRegions(
                        prefix: DropdownButton<int?>(
                            isExpanded: true,
                            value: regionId!,
                            isDense: true,
                            icon: const SizedBox.shrink(),
                            underline: const SizedBox.shrink(),
                            items: data,
                            onChanged: (value) {
                              _onChangeRegions(value, dataResponse);
                            }),
                        hintText: hintText);
                  }
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }),

            const SizedBox(
              height: 15,
            ),

            ///districts from state
            BlocBuilder<ReferenceSendCubit, ReferenceSendState>(
                // bloc: _cubit,
                builder: (context, state) {
              if (state is DistrictSuccessState && state.districts.isNotEmpty) {
                districtId = state.currentDistrict!.id;
                List<DropdownMenuItem<int>> data = [];
                for (var item in state.districts) {
                  data.add(DropdownMenuItem(
                      value: item.id, child: Text(item.name!.oz!.toString())));
                }

                if (state.districts.isEmpty) {
                  return const CupertinoActivityIndicator();
                }
                return CustomFieldForRegions(
                    prefix: DropdownButton<int?>(
                        isExpanded: true,
                        value: districtId!,
                        isDense: true,
                        icon: const SizedBox.shrink(),
                        underline: const SizedBox.shrink(),
                        items: data,
                        onChanged: (value) {
                          _onChangeDistricts(value, state);
                        }),
                    hintText: hintTextDistrict);
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
              child: TextField(
                controller: addressController,
                decoration: const InputDecoration(
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
              callBackForFile: () async {
                final fileRepo = serviceLocator.get<FileRepo>();
                FilePickerResult? result = await fileRepo.pickFiles();
                if (kDebugMode) {
                  print(result!.files.first.path);
                }
              },
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
