import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/utils.dart';
import '../auth/data/model/UserDataResponse.dart';

class AboutUserPage extends StatefulWidget {
  final Data data;

  const AboutUserPage(this.data, {Key? key}) : super(key: key);

  @override
  State<AboutUserPage> createState() => _AboutUserPageState();
}

class _AboutUserPageState extends State<AboutUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: const BackButton(),
        title: const Text("Profil",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 22)),
        backgroundColor: ColorsUtils.myColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey[400],
                child: SvgPicture.asset(
                  "assets/icons/ic_profile.svg",
                  height: 30,
                  width: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_profile.svg",
                  height: 20,
                  width: 20,
                  color: ColorsUtils.myColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "F.I.O: ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[800],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.data.name,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/ic_email.png",
                  height: 20,
                  width: 20,
                  color: ColorsUtils.myColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Email:",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[800],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.data.email,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/ic_location.png",
                  height: 20,
                  width: 20,
                  color: ColorsUtils.myColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Manzil:",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[800],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.data.address,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/ic_call.png",
                  height: 20,
                  width: 20,
                  color: ColorsUtils.myColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Telefon:",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[800],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.data.mobPhoneNo,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
