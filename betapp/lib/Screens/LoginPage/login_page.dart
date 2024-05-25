import 'package:betapp/Services/authentication.dart';
import 'package:flutter/cupertino.dart';


// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final Authentication _authentication = Authentication();
  final TextEditingController _usernameController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Login'),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Platz für das Logo
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/dc/bf/4a/dcbf4a50-4f8b-2f74-23ff-e94f7f877f2d/AppIcon-0-0-1x_U007emarketing-0-10-0-85-220.png/1200x630wa.png'), // Passe den Pfad zu deinem Logo an
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                  "Welcome to the Check24 Betting App by Jakob Landbrecht for the GenDev Scholarship",
                  style: TextStyle(
                    color: Color.fromARGB(255, 45, 45, 45),
                  )),
                  const SizedBox(height: 20.0,),
              // Eingabefeld für den Benutzernamen
              CupertinoTextField(
                controller: _usernameController,
                placeholder: 'Username',
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.lightBackgroundGray,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              const SizedBox(height: 20.0),
              CupertinoButton.filled(
                child: const Text('register'),
                onPressed: () async {
                  if(_usernameController.text.trim().isEmpty){
                    _showAlertDialog(context, 'Please enter a Username');
                    return;
                  }else{
                    print(_usernameController.text.trim());
                  }
                  dynamic user = _authentication.signInAnon(_usernameController.text.trim());
                  if(user == null){
                    _showAlertDialog(context, 'An error happend while trying to sign in.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String message) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Something went wrong'),
        content: Text(message),
      ),
    );
}
}
