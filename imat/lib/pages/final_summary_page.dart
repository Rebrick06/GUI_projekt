import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/customer.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
import 'package:imat_app/model/imat_data_handler.dart'; // ändra vid behov
import 'package:imat_app/model/imat/order.dart'; // din Order-klass

import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/base_footer.dart';
import 'package:imat_app/pages/purchase_confirmation_page.dart'; // ny sida nedan

class PaymentSummaryPage extends StatefulWidget {
  final Customer customer;
  final String deliveryWindow;

  const PaymentSummaryPage({
    super.key,
    required this.customer,
    required this.deliveryWindow,
  });

  @override
  State<PaymentSummaryPage> createState() => _PaymentSummaryPageState();
}

class _PaymentSummaryPageState extends State<PaymentSummaryPage> {
  // UI-state för bankkort-dropdown
  bool _cardOpen = false;

  // Kortformulär
  final _formKey = GlobalKey<FormState>();
  final _cardNumberCtrl = TextEditingController(text: '');
  final _expiryCtrl = TextEditingController(text: '');
  final _cvvCtrl = TextEditingController(text: '');
  final _nameCtrl = TextEditingController(text: '');

  @override
  void dispose() {
    _cardNumberCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();
    final items = iMat.getShoppingCart().items;

    final int itemCount = items.fold<int>(0, (sum, it) => sum + it.amount.toInt());
    final double subtotal =
        items.fold<double>(0.0, (sum, it) => sum + it.product.price * it.amount);

    // Anpassa eller hämta från handler vid behov
    const double boxFee = 9.00;
    const double freight = 127.00;
    const double vatRate = 0.0;
    final double vat = subtotal * vatRate;
    final double total = subtotal + boxFee + freight + vat;

    return Scaffold(
      appBar: const BaseAppBar(),
      backgroundColor: const Color(0xFFEFEFEF),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vänster
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Betalning',
                            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        const Text('Summering',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),

                        _SectionCard(
                          title: 'Leveransinformation',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _kvLine('Namn',
                                  '${widget.customer.firstName} ${widget.customer.lastName}'),
                              _kvLine('Telefon', widget.customer.phoneNumber),
                              _kvLine('Mobil', widget.customer.mobilePhoneNumber),
                              _kvLine('E-post', widget.customer.email),
                              _kvLine('Adress', widget.customer.address),
                              _kvLine('Postkod', widget.customer.postCode),
                              _kvLine('Postadress', widget.customer.postAddress),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        _SectionCard(
                          title: 'Tidsval',
                          child: _kvLine('Leveransfönster', widget.deliveryWindow),
                        ),
                        const SizedBox(height: 16),

                        _ItemsTable(items: items),

                        const Spacer(),

                        SizedBox(
                          width: 200,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // Exempel: töm korg eller navigera bort
                              // for (final it in List.of(items)) iMat.shoppingCartRemove(it);
                              // Navigator.popUntil(context, (r) => r.isFirst);
                            },
                            child: const Text(
                              'Avbryt köp',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 24),

                  // Höger
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.brightColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.mainColor),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$itemCount varor',
                                    style: const TextStyle(fontSize: 14)),
                                Text('${subtotal.toStringAsFixed(2)} kr',
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Delsumma',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w700)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${subtotal.toStringAsFixed(2)} kr',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Divider(height: 24),
                            _kvRowRight('Lådor', boxFee),
                            const Divider(height: 24),
                            _kvRowRight('Frakt', freight),
                            if (vatRate > 0) ...[
                              const Divider(height: 24),
                              _kvRowRight('Moms', vat),
                            ],
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Totalt inkl.\nmoms',
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w700)),
                                Text('${total.toStringAsFixed(2)} kr',
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w700)),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Bankkort - dropdown
                            _BankCardBlock(
                              open: _cardOpen,
                              onToggle: () => setState(() => _cardOpen = !_cardOpen),
                              formKey: _formKey,
                              cardNumberCtrl: _cardNumberCtrl,
                              expiryCtrl: _expiryCtrl,
                              cvvCtrl: _cvvCtrl,
                              nameCtrl: _nameCtrl,
                              onPay: () {
                                if (!_formKey.currentState!.validate()) return;

                                // Skapa Order
                                final order = _createOrder(items);

                                // (Valfritt) rensa korg eller spara order någonstans globalt
                                // iMat.saveOrder(order); // om du har en sådan metod
                                // for (final it in List.of(items)) iMat.shoppingCartRemove(it);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ThankYouPage(order: order),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 8),

                            // Övriga betalalternativ – oförändrade knappar (placeholders)
                            _payButton('Swish'),
                            const SizedBox(height: 8),
                            _payButton('Faktura'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const BaseFooter(),
        ],
      ),
    );
  }

  Order _createOrder(List<ShoppingItem> items) {
    // En enkel orderskapare: slumpmässigt ordernummer (6 siffror)
    final rnd = Random();
    final orderNumber = 100000 + rnd.nextInt(900000);
    return Order(orderNumber, DateTime.now(), List<ShoppingItem>.from(items));
  }
}

class _BankCardBlock extends StatelessWidget {
  final bool open;
  final VoidCallback onToggle;

  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberCtrl;
  final TextEditingController expiryCtrl;
  final TextEditingController cvvCtrl;
  final TextEditingController nameCtrl;

  final VoidCallback onPay;

  const _BankCardBlock({
    required this.open,
    required this.onToggle,
    required this.formKey,
    required this.cardNumberCtrl,
    required this.expiryCtrl,
    required this.cvvCtrl,
    required this.nameCtrl,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle-knapp
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.darkColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onToggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bankkort',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(width: 8),
                Icon(open ? Icons.expand_less : Icons.expand_more, size: 20),
              ],
            ),
          ),
        ),

        // Innehåll
        AnimatedCrossFade(
          crossFadeState:
              open ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 200),
          firstChild: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Kortnummer
                  TextFormField(
                    controller: cardNumberCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Kortnummer',
                      hintText: '0000 0000 0000 0000',
                      filled: true,
                    ),
                    validator: (v) {
                      final digits = (v ?? '').replaceAll(' ', '');
                      if (digits.length < 15 || digits.length > 19) {
                        return 'Ange ett giltigt kortnummer';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: expiryCtrl,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            labelText: 'Giltig t.o.m. (MM/YY)',
                            hintText: 'MM/YY',
                            filled: true,
                          ),
                          validator: (v) {
                            final s = (v ?? '').trim();
                            final reg = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
                            if (!reg.hasMatch(s)) return 'Format MM/YY';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: cvvCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                            hintText: '123',
                            filled: true,
                          ),
                          obscureText: true,
                          validator: (v) {
                            final s = (v ?? '').trim();
                            if (s.length < 3 || s.length > 4) {
                              return '3–4 siffror';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  TextFormField(
                    controller: nameCtrl,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Korthållarens namn',
                      hintText: 'För- och efternamn',
                      filled: true,
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Fyll i namn' : null,
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.mainColor,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: onPay,
                      child: const Text(
                        'Betala',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

Widget _kvLine(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 120, child: Text(k, style: const TextStyle(color: Colors.black54))),
        Expanded(child: Text(v)),
      ],
    ),
  );
}

class _ItemsTable extends StatelessWidget {
  final List<ShoppingItem> items;
  const _ItemsTable({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text('Inga artiklar i beställningen',
            style: Theme.of(context).textTheme.bodyMedium),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: items.map((it) {
          final lineTotal = it.product.price * it.amount.toDouble();
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0x11000000))),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 44,
                  child: Text('${it.amount.toInt()}st',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Text(it.product.name, overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  width: 90,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('${lineTotal.toStringAsFixed(2)} kr'),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

Widget _kvRowRight(String label, double value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(fontSize: 14)),
      Text('${value.toStringAsFixed(2)} kr', style: const TextStyle(fontSize: 14)),
    ],
  );
}

Widget _payButton(String label) {
  return SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.darkColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        // TODO: implementera andra betalmetoder
      },
      child: Text(label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
    ),
  );
}
