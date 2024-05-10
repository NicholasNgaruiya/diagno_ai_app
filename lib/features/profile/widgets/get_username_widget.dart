import 'package:flutter/material.dart';

import '../../../utils/local_storage/storage_utility.dart';

class GetUsernameWidget extends StatefulWidget {
  const GetUsernameWidget({
    super.key,
  });

  @override
  State<GetUsernameWidget> createState() => _GetUsernameWidgetState();
}

class _GetUsernameWidgetState extends State<GetUsernameWidget> {
  String? firstName;
  String? lastName;

  Future<void> loadSavedCredentials() async {
    final storedFirstName = await TLocalStorage.getString('first_name');
    final storedLastName = await TLocalStorage.getString('last_name');
    setState(() {
      firstName = storedFirstName;
      lastName = storedLastName;
    });
  }

  @override
  void initState() {
    loadSavedCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '$firstName $lastName';
    return fullName.isNotEmpty
        ? Text(
            fullName,
            style: Theme.of(context).textTheme.titleLarge,
          )
        : Container();

    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       'Hi,',
    //       style: Theme.of(context).textTheme.bodyLarge,
    //     ),
    //     const SizedBox(
    //       width: 5,
    //     ),
    //     userName != null
    //         ? Text(
    //             '$userName',
    //             style: Theme.of(context).textTheme.titleLarge,
    //           )
    //         : Container(),
    //   ],
    // );
  }
}
