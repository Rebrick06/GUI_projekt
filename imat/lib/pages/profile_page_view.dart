import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/customer.dart';
import 'package:imat_app/model/imat/order.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _mobileController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _postCodeController;
  late TextEditingController _postAddressController;

  bool _initialized = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _postCodeController.dispose();
    _postAddressController.dispose();
    super.dispose();
  }

  void _initialize(Customer customer) {
    _firstNameController =
        TextEditingController(text: customer.firstName);

    _lastNameController =
        TextEditingController(text: customer.lastName);

    _phoneController =
        TextEditingController(text: customer.phoneNumber);

    _mobileController =
        TextEditingController(text: customer.mobilePhoneNumber);

    _emailController =
        TextEditingController(text: customer.email);

    _addressController =
        TextEditingController(text: customer.address);

    _postCodeController =
        TextEditingController(text: customer.postCode);

    _postAddressController =
        TextEditingController(text: customer.postAddress);

    _initialized = true;
  }

  void _save(ImatDataHandler iMat) {
    final updatedCustomer = Customer(
      _firstNameController.text,
      _lastNameController.text,
      _phoneController.text,
      _mobileController.text,
      _emailController.text,
      _addressController.text,
      _postCodeController.text,
      _postAddressController.text,
    );

    iMat.saveCustomerForCurrentUser(updatedCustomer);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil uppdaterad!'),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.whiteColor,
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppTheme.radius,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();
    final customer = iMat.getCustomerForCurrentUser();
    final orders = iMat.getOrderForCurrentUser();

    if (!_initialized) {
      _initialize(customer);
    }

    return Scaffold(
      appBar: const BaseAppBar(),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 650,
            padding: const EdgeInsets.all(
              AppTheme.paddingHuge,
            ),

            decoration: BoxDecoration(
              color: AppTheme.brightColor,
              borderRadius: BorderRadius.circular(
                AppTheme.radius,
              ),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Min profil',
                    style:
                        AppTheme.titleFont.copyWith(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Förnamn',
                        controller:
                            _firstNameController,
                        icon: Icons.person,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _buildTextField(
                        label: 'Efternamn',
                        controller:
                            _lastNameController,
                        icon: Icons.person_outline,
                      ),
                    ),
                  ],
                ),

                _buildTextField(
                  label: 'Email',
                  controller: _emailController,
                  icon: Icons.email,
                ),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Telefon',
                        controller:
                            _phoneController,
                        icon: Icons.phone,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _buildTextField(
                        label: 'Mobilnummer',
                        controller:
                            _mobileController,
                        icon: Icons.smartphone,
                      ),
                    ),
                  ],
                ),

                _buildTextField(
                  label: 'Adress',
                  controller: _addressController,
                  icon: Icons.home,
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildTextField(
                        label: 'Postnummer',
                        controller:
                            _postCodeController,
                        icon: Icons.local_post_office,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        label: 'Ort',
                        controller:
                            _postAddressController,
                        icon: Icons.location_city,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          AppTheme.darkColor,
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                    ),
                    onPressed: () => _save(iMat),
                    child: Text(
                      'Spara ändringar',
                      style:
                          AppTheme.textFont.copyWith(
                        color:
                            AppTheme.whiteColor,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: AppTheme.paddingMedium)
                    ),
                    onPressed: () {
                      iMat.logout();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.logout),
                    label: Text(
                      'Logga ut',
                      style: AppTheme.textFont.copyWith(),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Text(
                  'Tidigare köp',
                  style: AppTheme.titleFont.copyWith(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                if (orders.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                        AppTheme.radius,
                      ),
                    ),
                    child: Text(
                      'Du har inga tidigare köp ännu.',
                      style:
                          AppTheme.textFont,
                    ),
                  ),

                ...orders.map(
                  (order) =>
                      _OrderCard(order: order),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppTheme.radius,
        ),
      ),

      child: ExpansionTile(
        title: Text(
          'Order #${order.orderNumber}',
          style: AppTheme.textFont.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          '${order.date.day}/${order.date.month}/${order.date.year}',
        ),

        children: [
          ...order.items.map(
            (item) => ListTile(
              title: Text(item.product.name),
              trailing: Text(
                '${item.amount} st',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Totalt: ${order.getTotal().toStringAsFixed(2)} kr',
                style:
                    AppTheme.textFont.copyWith(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}