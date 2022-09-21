/*
Created by Axmadjon Isaqov on 22:08:06 04.08.2022
© 2022 @axi_dev 
*/
import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/page/widget/file_card_widget.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/response_file_model.dart'
    as fileMod;

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
  bool? regionSelected = false;
  bool? _isLoading = false;
  bool? isLoadingButton = false;
  String? hintText = 'Viloyatni tanlang';
  String? hintTextDistrict = "Tumanni tanlang";
  TextEditingController? murojatController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  late ImagePicker? _imagePicker;
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.2995, 69.2401),
    zoom: 14.4746,
  );

  final _mapMarkerSC = StreamController<Marker>.broadcast();

  StreamSink<Marker> get _mapMarkerSink => _mapMarkerSC.sink;

  final List<Marker> _markerList = [];
  @override
  void initState() {
    _imagePicker = ImagePicker();
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

  ///camera page
  void _cameraPage() async {
    try {
      final cameraPermisson = await Permission.camera.request();
      if (cameraPermisson == PermissionStatus.denied) return;
      // final firstCamera = cameraList!.first;
      // ignore: use_build_context_synchronously
      // final XFile? fileImage = await Navigator.push(
      //     context,
      //     CupertinoPageRoute(
      //         builder: (context) => CameraPage(
      //               description: firstCamera,
      //             )));

      // if (fileImage != null) {
      //   ToastFlutter.showToast('Rasm saqlandi');
      // }
      setState(() {});
    } catch (e) {
      log(e);
    }
  }

  ///pick images from camera
  void _pickImagesFromCamera() async {
    try {
      final XFile? fileImage = await _imagePicker!.pickImage(
          source: ImageSource.camera,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      if (fileImage == null) {
        return;
      }
      _isLoading = true;
      setState(() {});
      final File file = File(fileImage.path);
      await _cubit.uploadFile(file: file).then((value) {
        _isLoading = false;
        ToastFlutter.showToast('Rasm saqlandi');
        setState(() {});
      }).onError((error, stackTrace) {
        ToastFlutter.showToast('Xatolik sodir bo\'ldi');
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  ///google map diolog
  void _showDialogGoogleMap() {
    _markerList.clear();
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return SimpleDialog(contentPadding: EdgeInsets.zero, children: [
            SizedBox(
                height: _size!.height * 0.5,
                width: _size!.width,
                child: StreamBuilder<Marker>(
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
                          _markerList.clear();
                          _markerList.add(marker);
                          _mapMarkerSink.add(_markerList.last);
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
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size!.width * 0.25),
              child: SizedBox(
                height: 50,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 1, color: ColorsUtils.buttonColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Tanlash',
                      style: TextStyle(
                          color: ColorsUtils.myColor, letterSpacing: 1.5),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ]);
        });
  }

  ///file button call back
  void _fileAddButtonCallBack() async {
    final fileRepo = serviceLocator.get<FileRepo>();
    FilePickerResult? result =
        await fileRepo.pickFiles(fileTypes: Strings.listFileTypes);
    if (result == null) {
      return;
    }
    _isLoading = true;
    setState(() {});
    final File file = File(result.files.first.path!);
    await _cubit.uploadFile(file: file).then((value) {
      _isLoading = false;
      ToastFlutter.showToast('Rasm saqlandi');
    }).onError((error, stackTrace) {
      ToastFlutter.showToast('Xatolik sodir bo\'ldi');
    });

    if (kDebugMode) {
      print(result.files.first.path);
      print(result.count);
      print(await Prefs.load('token'));
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
    regionSelected = true;
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
    isLoadingButton = true;
    setState(() {});
    Data? userData = Data.fromJson(jsonDecode(await Prefs.load('userData')));
    AppealRequestData? requestData = AppealRequestData(
      letterId: 1,
      referenceId: widget.referenceId,
      referenceParentId: widget.referenceParentId,
      ticketRegionId: regionId,
      ticketDistrictId: districtId,
      phone: NumberUtil.getSortedPhoneNumber(userData.mobPhoneNo!),
      firstName: userData.firstName,
      lastName: userData.lastName,
      address: addressController!.text,
      description: murojatController!.text,
    );
    log(requestData.toJson());
    // ignore: use_build_context_synchronously
    _cubit.appealsUpload(requestData, context);
    isLoadingButton = false;
    setState(() {});
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
      child: Stack(
        children: [
          Builder(builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  ///text
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: SizedBox(
                      width: _size!.width,
                      child: Text(
                        'Murojaatingzni toliq tushuntiring',
                        textAlign: TextAlign.start,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
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
                            return const Center(
                                child: CupertinoActivityIndicator());
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
                          return IgnorePointer(
                            ignoring: !regionSelected!,
                            child: CustomFieldForRegions(
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
                                hintText: hintTextDistrict),
                          );
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
                  const SizedBox(
                    height: 5,
                  ),
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
                      labelText:
                          _markerList.first.position.longitude.toString(),
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

                  ///file add button
                  FileAddButtonAndCamera(
                    context: context,
                    callBackForCamera: _pickImagesFromCamera,
                    callBackForFile: _fileAddButtonCallBack,
                    text: "Fayl biriktirish",
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///optional text
                  OptionalText(
                      context: context,
                      text: "(pdf,doc,docx,xls,jpg,jpeg,png)"),
                  const SizedBox(
                    height: 30,
                  ),

                  ///bloc upload data
                  BlocBuilder<AppealSendCubit, AppealSendState>(
                      bloc: _cubit,
                      builder: (context, state) {
                        if (state is ErrorState) {
                          return const SizedBox.shrink();
                        } else if (state is FileUploadState) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SizedBox(
                              height: 50,
                              width: _size!.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  fileMod.Data? data = state.file[index]!.data;
                                  return FileCardWidget(
                                      name: data!.file!,
                                      onDelete: () {
                                        _cubit.removeFile(index: index);
                                      });
                                },
                                itemCount: state.file.length,
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: SizedBox.shrink(),
                        );
                      }),

                  const SizedBox(
                    height: 30,
                  ),

                  ///Yuborish button
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _size!.width * 0.05),
                    child: CustomButton(
                      size: _size,
                      context: context,
                      isLoading: isLoadingButton,
                      text: "Yuborish",
                      callback: _sendingAppeal,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }),
          if (_isLoading!)
            Container(
              height: _size!.height,
              width: _size!.width,
              color: Colors.grey.withOpacity(0.7),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: .0,
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: CircularProgressIndicator(),
                      title: Text('Yuklanmoqda'),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
