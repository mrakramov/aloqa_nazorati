import 'package:flutter/material.dart';

class CreateAppealPage extends StatefulWidget {
  const CreateAppealPage({Key? key}) : super(key: key);

  @override
  State<CreateAppealPage> createState() => _CreateAppealPageState();
}

class _CreateAppealPageState extends State<CreateAppealPage> {
  var categories = [
    "Annuitet to'lovlari",
    "Differensial to'lovlar",
    "Annuitet to'lovlari (Fonddan subsidiya)",
    "Differensial to'lovlar (Fond subsidiya)"
  ];
  dynamic _category;

  @override
  void initState() {
    super.initState();
    _category = categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: const Text(
          "Murojaat yuborish",
          style: TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 22),
        ),
        backgroundColor: const Color.fromRGBO(68, 30, 221, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Murojaatingizni to’liq tushuntiring",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[800],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: DropdownButtonFormField(
                items: categories.map((String category) {
                  return DropdownMenuItem(
                      value: category,
                      child: Row(
                        children: <Widget>[
                          Text(
                            category,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: Colors.grey[900],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500),
                          ),
                        ],
                      ));
                }).toList(),
                onChanged: (newValue) {
                  _category = newValue;
                },
                value: _category,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
