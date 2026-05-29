import 'package:flutter/material.dart';
import 'package:imat_app/model/imat/customer.dart';
import 'package:imat_app/model/imat/user.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/model/wizard_field.dart';
import 'package:imat_app/pages/main_view.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/wizard/base_wizard_page.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  int _currentStep = 0;
  String? _errorMessage;

  // Hjälpreda för listan under denna
  int _calculateStartIndex(int step) {
    int index = 0;
    for (int i = 0; i < step; i++) {
      index += _fields[i].fields.length;
    }
    return index;
  }

  List<TextEditingController> _getStepControllers(int step) {
    final startIndex = _calculateStartIndex(step);
    final fieldCount = _fields[step].fields.length;
    return _controllers.sublist(startIndex, startIndex + fieldCount);
  }

  final List<TextEditingController> _controllers = List.generate(
    9, (_) => TextEditingController(),
  );

  final List<WizardField> _fields = [
    WizardField(
      label: 'Förnamn',
      fields: [
        FieldData(
          hint: 'Skriv ditt förnamn här', 
          icon: Icons.person,
        ),
        FieldData(
          title: 'Efternamn',
          hint: 'Skriv ditt efternamn här', 
          icon: Icons.person_outline,
        ),
        FieldData(
          title: "E-post*",
          hint: 'Skriv din e-post här', 
          icon: Icons.email,
        ),
      ],
      validator: (controllers) {
        final email = controllers[2].text.trim();

        if (email.isEmpty) {
          return "Du måste ange din e-mail address";
        }

        return null;
      },
    ),

    /*WizardField(
      label: 'Efternamn',
      fields: [
        FieldData(hint: 'Skriv ditt efternamn här', icon: Icons.person_outline,)
      ],
    ),

    WizardField(
      label: 'E-post',
      fields: [
        FieldData(hint: 'Skriv din e-post här', icon: Icons.email,),
      ]

    ), */

    WizardField(
      label: 'Telefonnummer',
      fields: [
        // Hus TELEFON
        FieldData(
          hint: 'Skriv ditt telefonnummer här',
          icon: Icons.phone,
        ),
        // Mobil TELEFON
        FieldData(
          title: "Mobilnummer",
          hint: 'Skriv ditt mobilnummer här',
          icon: Icons.smartphone,
        ),
      ],
      validator: (controllers) {
        final phone = controllers[0].text.trim();
        final mobile = controllers[1].text.trim();

        if (phone.isEmpty && mobile.isEmpty) {
          return null;
        }

        return null;
      },
    ),

    /* // Om vi vill splittra på dom! //
    WizardField(
      label: 'Mobilnummer',
      fields: [
        FieldData(
          hint: 'Skriv ditt mobilnummer här',
          icon: Icons.smartphone,
        ),
      ],
    ),
    */
    WizardField(
      label: 'Adress',
      fields: [
        FieldData(
          hint: 'Skriv din adress här',
          icon: Icons.home,
        ),
        FieldData(
          title: 'Postnummer',
          hint: 'Skriv ditt postnummer här',
          icon: Icons.local_post_office,
        ),
        FieldData(
          title: 'Postort',
          hint: 'Skriv din postort här',
          icon: Icons.location_city,
        ),
      ],
      validator: (controllers) {
        final adress = controllers[0].text.trim();
        final postnummer = controllers[1].text.trim();
        final postort = controllers[2].text.trim();

        if (adress.isEmpty && postnummer.isEmpty && postort.isEmpty) {
          return null;
        }

        return null;
      },
    ),

    /*WizardField(
      label: 'Postnummer',
      fields: [
        FieldData(
          hint: 'Skriv ditt postnummer här',
          icon: Icons.local_post_office,
        ),
      ],
    ),

    WizardField(
      label: 'Postadress',
      fields: [
        FieldData(
          hint: 'Skriv din postadress här',
          icon: Icons.location_city,
        )
      ]
    ), */

    WizardField(
      label: 'Lösenord*',
      fields: [
        FieldData(
          hint: 'Skapa ett lösenord',
          icon: Icons.lock,
          obscure: true,
        )
      ],
    ),
  ];

  bool get _isLastStep => _currentStep == _fields.length - 1;

  


  @override
  void dispose() {
    for (final controller
        in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _next(ImatDataHandler iMat) {
    if (_isLastStep) {
      _createAccount(iMat);
    } else {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previous() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _errorMessage = null;
      });
    }
  }

  void _createAccount(ImatDataHandler iMat,) {

    final email = _controllers[2].text.trim();
    final password = _controllers[8].text.trim();

    final rawUsers = iMat.getExtras()['users'];

    List<User> users = [];

    if (rawUsers != null) {
      users = (rawUsers as List).map(
                (u) => User.fromJson(Map<String, dynamic>.from(u,),),
      ).toList();
    }

    final bool userExists = users.any(
      (User u) => u.userName == email,
    );

    if (userExists) {
      setState(() {
        _errorMessage = 'E-postadress har redan ett kopplat konto';
      });
      return;
    }

    final newUser = User(email,password);
    users.add(newUser);
    iMat.addExtra(
      'users', 
      users.map((u) => u.toJson()).toList(),
    );

    iMat.login(newUser);

    iMat.saveCustomerForCurrentUser(
      Customer(
        _controllers[0].text.trim(),
        _controllers[1].text.trim(),
        _controllers[3].text.trim(),
        _controllers[4].text.trim(),
        email,
        _controllers[5].text.trim(),
        _controllers[6].text.trim(),
        _controllers[7].text.trim(),
      ),
    );

    ScaffoldMessenger.of(context,).showSnackBar(
      const SnackBar(
        content: Text('Konto skapat!',),
        duration: Duration(seconds: 5),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainView(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();

    return Scaffold(
      appBar: const BaseAppBar(),

      body: BaseWizardPage(
        title: 'Skapa konto',
        currentStep: _currentStep,
        fields: _fields,
        controllers: _controllers,
        onNext: () => _next(iMat),
        onBack: _previous,
        finishText: 'Skapa konto',
      ),
    );
  }
}