import 'package:app/providers/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import "./screens/login.dart";
import "./screens/app.dart";
import './screens/customers_tx.dart';
import './screens/customers_add.dart';
import './providers/transactions.dart';
import 'providers/customers.dart';
import './models/customer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = !(currentUser == null);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Authentication>(
          create: (_) => Authentication(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Transactions(),
        ),
        StreamProvider<List<Customer>>.value(
          value: CustomerStream().getCustomerList(),
          initialData: const [],
        )
        // 여기에 Provider 쭉쭉 추가하면 됩니다.
      ],
      child: MaterialApp(
          title: 'Laura',
          theme: ThemeData(
            fontFamily: 'OpenSans',
            primaryColor: Colors.indigo,
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.teal, fontSize: 30),
              bodyText2: TextStyle(color: Colors.indigo, fontSize: 20),
              subtitle1: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          home: isLoggedIn ? const App() : const Login(),
          routes: {
            CustomersTransaction.routeName: (context) =>
            const CustomersTransaction(),
            CustomersAdd.routeName: (context) => const CustomersAdd(),
          }),
    );
  }
}