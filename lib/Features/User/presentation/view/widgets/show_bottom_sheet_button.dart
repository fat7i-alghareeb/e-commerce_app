import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/cubits/cubit/user_info_cubit.dart';
import 'edit_personal_info.dart';

class ShowBottomSheetButton extends StatelessWidget {
  const ShowBottomSheetButton(
      {super.key, required this.userName, required this.gmail});
  final String userName;
  final String gmail;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  HapticFeedback.heavyImpact();
                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 50,
                  ),
                ),
              ),
            ),
            body: BottomSheetBody(
              userName: userName,
              gmail: gmail,
            ),
          );
        },
      ),
      child: Text(
        "Edit",
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({
    super.key,
    required this.userName,
    required this.gmail,
  });
  final String userName;
  final String gmail;
  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

//todo fix textEditingController
class _BottomSheetBodyState extends State<BottomSheetBody> {
  void _changeInfo({String? userName, String? gmail, String? password}) {
    BlocProvider.of<UserInfoCubit>(context)
        .changeInfo(userName: userName, gmail: gmail, password: password);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EditPersonalInfoWidget(
          personalInfoName: "User Name",
          onPressed: (String newInfo) {
            _changeInfo(userName: newInfo);
          },
          controller: TextEditingController(text: widget.userName),
        ),
        //////////////////////////////////////////////////////////////////////////////////////
        EditPersonalInfoWidget(
          personalInfoName: "Gmail",
          controller: TextEditingController(text: widget.gmail),
          onPressed: (String newInfo) {
            _changeInfo(gmail: newInfo);
          },
        ),
        //////////////////////////////////////////////////////////////////////////////////////
        EditPersonalInfoWidget(
          personalInfoName: "Password",
          onPressed: (String newInfo) {
            _changeInfo(password: newInfo);
          },
          controller: TextEditingController(),
        ),
      ],
    );
  }
}
