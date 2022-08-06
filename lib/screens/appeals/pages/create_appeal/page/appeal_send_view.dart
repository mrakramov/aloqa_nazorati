/*
Created by Axmadjon Isaqov on 22:08:06 04.08.2022
© 2022 @axi_dev 
*/
import 'dart:async';
import 'dart:convert';
import 'package:aloqa_nazorati/screens/appeals/data/model/appeal_send_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/districts_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/regions_response_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/appeal_send_cubit.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/appeal_send_state.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/custom_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/custom_field_for_district.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/custom_form_field.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/file_add_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/lat_widget.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/location_button.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/optional_text.dart';
import 'package:aloqa_nazorati/screens/auth/data/model/UserDataResponse.dart';
import 'package:aloqa_nazorati/utils/db/hive_db.dart';
import 'package:aloqa_nazorati/utils/di/locator.dart';
import 'package:aloqa_nazorati/utils/file/file_service.dart';
import 'package:aloqa_nazorati/utils/toast_flutter.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppealSendPage extends StatefulWidget {
  final int? referenceParentId;
  final int? referenceId;
  const AppealSendPage(
      {super.key, required this.referenceParentId, required this.referenceId});

  @override
  State<AppealSendPage> createState() => _AppealSendPageState();
}

class _AppealSendPageState extends State<AppealSendPage> {
  final AppealSendCubit _cubit = AppealSendCubit(AppealRepository());
  Size? _size;
  final key = GlobalKey<FormState>();
  late int? regionId;
  late int? districtId;
  late DistrictsResponse? selectedDistrict;
  bool? districtSelected = false;
  String? hintText = 'Viloyatni tanlang';
  String? hintTextDistrict = "Tumanni tanlang";
  final _listValueNotifier = ValueNotifier<List<PlatformFile>>([]);
  TextEditingController? murojatController = TextEditingController();
  TextEditingController? addressController = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.2995, 69.2401),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final _mapMarkerSC = StreamController<List<Marker>>.broadcast();

  StreamSink<List<Marker>> get _mapMarkerSink => _mapMarkerSC.sink;

  final List<Marker> _markerList = [];
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
    districtSelected = false;
    super.dispose();
  }

  ///google map diolog
  void _showDialogGoogleMap() {
    _markerList.clear();
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SizedBox(
                      height: _size!.height * 0.5,
                      width: _size!.width,
                      child: StreamBuilder<List<Marker>>(
                          stream: _mapMarkerSC.stream,
                          builder: (context, snapshot) {
                            return GoogleMap(
                              mapType: MapType.normal,
                              markers: _markerList.toSet(),
                              onTap: (argument) {
                                final marker = Marker(
                                    markerId: MarkerId(
                                        "${argument.longitude}+${argument.longitude}"),
                                    position: LatLng(
                                        argument.latitude, argument.longitude));
                                _markerList.add(marker);
                                _mapMarkerSink.add(_markerList);
                                setState(() {});
                              },
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                if (!_controller.isCompleted) {
                                  _controller.complete(controller);
                                }
                              },
                            );
                          })),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CupertinoButton(
                      color: ColorsUtils.myColor,
                      child: const Text('Tanlash'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                )
              ]);
        });
  }

  ///file button call back
  void _fileAddButtonCallBack() async {
    final fileRepo = serviceLocator.get<FileRepo>();
    FilePickerResult? result =
        await fileRepo.pickFiles(fileTypes: Strings.listFileTypes);

    _addResultToRow(result!.files);

    if (kDebugMode) {
      print(result.files.first.path);
      print(result.count);
      print(await Prefs.load('token'));
    }
  }

  ///add platform results to notifier
  void _addResultToRow(List<PlatformFile> list) {
    _listValueNotifier.value.addAll(list);
    setState(() {});
  }

  ///remove file in index
  void _removeListNotifierFileInIndex(int? index) {
    if (_listValueNotifier.value.isNotEmpty) {
      _listValueNotifier.value.removeAt(index!);
      setState(() {});
    }
  }

  ///on change districts
  void _onChangeDistricts(int? value, state) {
    districtId = value!;
    hintTextDistrict = state.districts
        .singleWhere((element) => element.id == districtId)
        .name!
        .uz;
    selectedDistrict =
        state.districts.singleWhere((element) => element.id == districtId);
    districtSelected = true;
    setState(() {});
  }

//on change regions
  void _onChangeRegions(int? value, dataResponse) {
    regionId = value!;
    hintText = dataResponse
        .singleWhere((element) => element!.id == regionId)!
        .name!
        .uz;
    _cubit.getDistricts(regionId);
    setState(() {});
  }

  ///sending appeal
  void _sendingAppeal() async {
    if (!districtSelected!) {
      ToastFlutter.showToast('Malumotlar toliq emas');
      return;
    }
    if (regionId == null ||
        districtId == null ||
        widget.referenceId == null ||
        widget.referenceParentId == null) {
      ToastFlutter.showToast('Malumotlar toliq emas');
      return;
    }
    if (_markerList.isEmpty) {
      ToastFlutter.showToast('Malumotlar toliq emas');
      return;
    }
    if (addressController!.text.isEmpty || murojatController!.text.isEmpty) {
      ToastFlutter.showToast('Malumotlar toliq emas');
      return;
    }

    UserDataResponse? userData =
        UserDataResponse.fromJson(jsonDecode(await Prefs.load('userData')));
    AppealRequestData? requestData = AppealRequestData(
      letterId: 1,
      referenceId: widget.referenceId,
      referenceParentId: widget.referenceParentId,
      ticketRegionId: regionId,
      ticketDistrictId: districtId,
      phone: userData.data.phone,
      firstName: userData.data.firstName,
      lastName: userData.data.lastName,
      address: addressController!.text,
      description: murojatController!.text,
      files: [12, 34],
    );

    _cubit.appealsUpload(requestData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<AppealSendCubit, AppealSendState>(
          listener: (context, state) {},
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              toolbarHeight: 80,
              leading: const BackButton(),
              title: const Text("Murojaat yuborish",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 22)),
              backgroundColor: ColorsUtils.myColor,
            ),
            body: SafeArea(
              child: getBody,
            ),
          )),
    );
  }

  ///page body
  Widget get getBody {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            ///text
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
            BlocBuilder<AppealSendCubit, AppealSendState>(
                bloc: _cubit,
                builder: (context, state) {
                  if (state is DistrictSuccessState &&
                      state.districts.isNotEmpty) {
                    districtId = state.currentDistrict!.id;
                    List<DropdownMenuItem<int>> data = [];
                    for (var item in state.districts) {
                      data.add(DropdownMenuItem(
                          value: item.id,
                          child: Text(item.name!.oz!.toString())));
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
            Builder(builder: (context) {
              return LocationButton(
                size: _size,
                text: "Lokatsiyani belgilash",
                callBack: _showDialogGoogleMap,
              );
            }),
            OptionalText(
                context: context, text: "(Loksiya belgilash ixtiyoriy)"),

            ///longtitude
            if (_markerList.isNotEmpty)
              const SizedBox(
                height: 15,
              ),

            ///latitude
            if (_markerList.isNotEmpty)
              LatWidget(
                addressController: TextEditingController(),
                labelText: _markerList.first.position.latitude.toString(),
                hintText: 'Lat',
              ),

            ///longtitude
            if (_markerList.isNotEmpty)
              const SizedBox(
                height: 15,
              ),

            ///longtitude
            if (_markerList.isNotEmpty)
              LatWidget(
                addressController: TextEditingController(),
                labelText: _markerList.first.position.longitude.toString(),
                hintText: 'Lng',
              ),
            const SizedBox(
              height: 15,
            ),

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
              callBackForFile: _fileAddButtonCallBack,
              text: "Fayl biriktirish",
            ),

            ///optional text
            OptionalText(
                context: context, text: "(pdf,doc,docx,xls,jpg,jpeg,png)"),
            const SizedBox(
              height: 30,
            ),

            ///list notifier
            ValueListenableBuilder<List<PlatformFile>>(
                valueListenable: _listValueNotifier,
                builder: (_, value, child) {
                  if (value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 70,
                      width: _size!.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => AspectRatio(
                          aspectRatio: 2 / 1.1,
                          child: Card(
                            elevation: 0.0,
                            color: Colors.transparent,
                            child: Chip(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              label: Text(
                                value[index].name,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              deleteIcon: const Padding(
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  Icons.delete,
                                  size: 20,
                                ),
                              ),
                              deleteIconColor: Colors.red,
                              onDeleted: () =>
                                  _removeListNotifierFileInIndex(index),
                            ),
                          ),
                        ),
                        itemCount: value.length,
                      ),
                    ),
                  );
                }),

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
                callback: _sendingAppeal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
