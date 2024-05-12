import 'package:flutter/cupertino.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Text('Login'),
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
                  "Willkommen in der Check24 Betting App von Jakob Landbrecht für das GenDev Stipendium",
                  style: TextStyle(
                    color: Color.fromARGB(255, 45, 45, 45),
                  )),
                  const SizedBox(height: 20.0,),
              // Eingabefeld für den Benutzernamen
              CupertinoTextField(
                placeholder: 'Benutzername',
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.lightBackgroundGray,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              const SizedBox(height: 20.0),
              // Beispiel für eine Schaltfläche zum Einreichen des Benutzernamens
              CupertinoButton.filled(
                child: const Text('Registrieren'),
                onPressed: () {
                  // Hier kannst du die Logik für das Einreichen des Benutzernamens einfügen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
