import 'package:flutter/material.dart';
import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

class GetEmailWidget extends StatefulWidget {
  const GetEmailWidget({super.key});

  @override
  State<GetEmailWidget> createState() => _GetEmailWidgetState();
}

class _GetEmailWidgetState extends State<GetEmailWidget> {
  String? email;

  Future<void> loadSavedEmail() async {
    final storedEmail = await TLocalStorage.getString('email');
    setState(() {
      email = storedEmail;
    });
  }

  @override
  void initState() {
    super.initState();
    loadSavedEmail();
  }

  @override
  Widget build(BuildContext context) {
    final emailText = '$email';
    return emailText.isNotEmpty
        ? Text(
            emailText,
            style: Theme.of(context).textTheme.titleLarge,
          )
        : Container();
  }
}
