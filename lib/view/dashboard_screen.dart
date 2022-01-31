import 'package:duas/controller/dashboard_screen_controller.dart';
import 'package:duas/custom/components.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'drawer_screen.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // drawer: const DrawerScreen(),

          // appBar: Components().customAppBar('Dashboard', Colors.green[900]),

          body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.2,
                width: Get.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xff0a2141),
                  Color(0xff092b51),
                  Color(0xff084379),
                ])),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Hello,',
                              style: GoogleFonts.adventPro(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          ),
                          Text('Dua',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.adventPro(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 30))),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Communications',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.adventPro(
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 30))),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Obx(
                  () => Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      accountsDropDown(),
                      const SizedBox(height: 20),
                      controller.selectedAccount.value == 'Post Paid Bill'
                          ? form2()
                          : form1(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  // Widget dropDown2() {
  //   return DropdownButton(

  //   );
  // }
  Widget form1() {
    return Form(
      key: controller.formkey,
      child: Column(children: [
        customTextField(
          hint: 'MSISDN',
          formater: controller.msisdnFormatter,
          textType: TextInputType.number,
          icon: Icons.email,
          controllers: controller.msisdn,
          validation: controller.msisdnValidation,
        ),
        const SizedBox(
          height: 20,
        ),
        customTextField(
          hint: 'Customer Name',
          formater: controller.customerNameFormatter,
          icon: Icons.person,
          controllers: controller.customerName,
          validation: controller.customerNameValidation,
        ),
        const SizedBox(
          height: 20,
        ),
        customTextField(
          hint: 'Amount',
          formater: controller.amountFormater,
          textType: TextInputType.number,
          icon: Icons.monetization_on_rounded,
          controllers: controller.amount,
          validation: controller.amountValidation,
        ),
        const SizedBox(
          height: 20,
        ),
        customTextField(
          hint: 'TRX ID',
          formater: controller.trxIdFormatter,
          textType: TextInputType.number,
          icon: Icons.perm_identity,
          controllers: controller.trxId,
          validation: controller.trxIdValidation,
        ),
        const SizedBox(height: 30),
        submitButton()
      ]),
    );
  }

/////////////////
  form2() {
    return Form(
      key: controller.formkey2,
      child: Column(
        children: [
          postPaidBillAccounts(),
          const SizedBox(
            height: 20,
          ),
          customTextField(
            hint: 'Amount',
            formater: controller.amountFormater,
            textType: TextInputType.number,
            icon: Icons.monetization_on_rounded,
            controllers: controller.amount2,
            validation: controller.amountValidation,
          ),
          const SizedBox(
            height: 20,
          ),
          customTextField(
            hint: 'MSISDN',
            formater: controller.msisdnFormatter,
            textType: TextInputType.number,
            icon: Icons.email,
            controllers: controller.msisdn,
            validation: controller.msisdnValidation,
          ),
          const SizedBox(
            height: 20,
          ),
          submitButton2(),
        ],
      ),
    );
  }

  Widget postPaidBillAccounts() {
    return Obx(
      () => DropdownButton(
        isExpanded: true,
        value: controller.selectedPost.value,
        items: controller.getpostPaidItems(),
        onChanged: (value) {
          controller.selectedPost.value = value.toString();
        },
      ),
    );
  }

  ///////////////

  Widget accountsDropDown() {
    return Obx(
      () => DropdownButton(
        isExpanded: true,
        value: controller.selectedAccount.value,
        items: controller.getItems(),
        onChanged: (value) {
          controller.selectedAccount.value = value.toString();
        },
      ),
    );
  }

  Widget customTextField(
      {hint, icon, controllers, textType, validation, formater}) {
    return TextFormField(
      controller: controllers,
      keyboardType: textType,
      validator: validation,
      inputFormatters:
          formater == null ? [controller.customerNameFormatter] : [formater],
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: '$hint',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade900))),
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap: () {
        controller.addData();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 10,
        shadowColor: Color(0xff084379),
        child: Container(
          height: 50,
          width: Get.width,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0xff0a2141),
                Color(0xff092b51),
                Color(0xff084379),
              ]),
              borderRadius: BorderRadius.circular(30)),
          child: const Center(
              child: Text(
            'submit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )),
        ),
      ),
    );
  }

  Widget submitButton2() {
    return GestureDetector(
      onTap: () {
        controller.validate2();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 10,
        shadowColor: Color(0xff084379),
        child: Container(
          height: 50,
          width: Get.width,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0xff0a2141),
                Color(0xff092b51),
                Color(0xff084379),
              ]),
              borderRadius: BorderRadius.circular(30)),
          child: const Center(
              child: Text(
            'submit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )),
        ),
      ),
    );
  }
}
