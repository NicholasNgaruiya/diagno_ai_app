import 'package:flutter/material.dart';

import '../../../../../utils/local_storage/storage_utility.dart';

class GetUsernameWidget extends StatefulWidget {
  const GetUsernameWidget({
    super.key,
  });

  @override
  State<GetUsernameWidget> createState() => _GetUsernameWidgetState();
}

class _GetUsernameWidgetState extends State<GetUsernameWidget> {
  String? userName;

  Future<void> loadSavedCredentials() async {
    final storedUserName = await TLocalStorage.getString('user_name');
    setState(() {
      userName = storedUserName;
    });
  }

  @override
  void initState() {
    loadSavedCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userName != null
        ? Text(
            '$userName',
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
