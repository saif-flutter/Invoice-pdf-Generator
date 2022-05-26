import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice/model/user_data_model.dart';
import 'package:invoice/steps_cubit.dart';
import 'package:invoice/widgets/description_text_field.dart';
import 'package:invoice/widgets/my_pdf.dart';
import 'package:invoice/widgets/text_form_field.dart';
import 'package:invoice/widgets/total_sum.dart';
import 'package:signature/signature.dart';
import '../widgets/custom_colors.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  /// Form Key

  final _formKey = GlobalKey<FormState>();

  /// TextEditing Controller
  final SignatureController signatureController = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 2,
  );

  TextEditingController invoiceDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController organizationToController = TextEditingController();
  TextEditingController emailToController = TextEditingController();
  TextEditingController addressToController = TextEditingController();
  TextEditingController phoneToController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController termsController = TextEditingController();


  UserModel invoice() {
    var data = UserModel(
        invoiceDate: invoiceDateController.text,
        dueDate: dueDateController.text,
        byOrganization: organizationController.text,
        byEmail: emailController.text,
        byAddress: addressController.text,
        byPhone: phoneController.text,
        toOrganization: organizationToController.text,
        toEmail: emailToController.text,
        toAddress: addressToController.text,
        toPhone: phoneToController.text,
        itemName: itemNameController.text,
        itemQuantity: itemQuantityController.text,
        itemPrice: itemPriceController.text,
        description: descriptionController.text,
        terms: termsController.text,
        items: list);
    return data;
  }

  List<Map<String, dynamic>> list = [];

  List<Step> stepList() => [
        Step(
            title: const Text('Dates'),
            content: SizedBox(
              height: 5.h,
              // color: Colors.blue,
            )),
        Step(
          title: const Text('Billed By'),
          content: SizedBox(
            height: 180.h,
            // color: Colors.blue,
            child: Column(
              children: [
                Expanded(
                    child: CustomTextFormField(
                        keyboardType: TextInputType.name,
                        text: 'Organization',
                        controller: organizationController,
                        validatorText: 'Please Provide Organization Name')),
                Expanded(
                    child: CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        text: 'Email',
                        controller: emailController,
                        validatorText: 'Please Provide Email ')),
                Expanded(
                    child: CustomTextFormField(
                        keyboardType: TextInputType.name,
                        text: 'Address',
                        controller: addressController,
                        validatorText: 'Please Provide the Address ')),
                Expanded(
                    child: CustomTextFormField(
                        keyboardType: TextInputType.number,
                        text: 'Phone',
                        controller: phoneController,
                        validatorText: 'Please Provide Phone Number')),
              ],
            ),
          ),
        ),
        Step(
          title: const Text('Billed To'),
          content: SizedBox(
            height: 180.h,
            // color: Colors.blue,
            child: Column(
              children: [
                Expanded(
                    child: CustomTextFormField(
                        keyboardType: TextInputType.name,
                        text: 'Organization',
                        controller: organizationToController,
                        validatorText: 'Please Provide Organization Name')),
                Expanded(
                    child: CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        text: 'Email',
                        controller: emailToController,
                        validatorText: 'Please Provide Email ')),
                Expanded(
                    child: CustomTextFormField(
                        keyboardType: TextInputType.name,
                        text: 'Address',
                        controller: addressToController,
                        validatorText: 'Please Provide the Address ')),
                Expanded(
                    child: CustomTextFormField(
                        keyboardType: TextInputType.number,
                        text: 'Phone',
                        controller: phoneToController,
                        validatorText: 'Please Provide Phone Number')),
              ],
            ),
          ),
        ),
        Step(
          title: const Text('Items'),
          content: SizedBox(
            height: 180.h,
            // color: Colors.blue,
            child: Column(
              children: [
                Expanded(
                    child: CustomTextFormField(
                        text: 'Name',
                        controller: itemNameController,
                        validatorText: 'Enter the Name',
                        keyboardType: TextInputType.name)),
                Expanded(
                    child: CustomTextFormField(
                        text: 'Quantity',
                        controller: itemQuantityController,
                        validatorText: 'Enter the Quantity',
                        keyboardType: TextInputType.number)),
                Expanded(
                    child: CustomTextFormField(
                        text: 'Price',
                        controller: itemPriceController,
                        validatorText: 'Enter the Price',
                        keyboardType: TextInputType.number)),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        list.add({
                          'Name': itemNameController.text,
                          'price': itemPriceController.text,
                          'quantity': itemQuantityController.text,



                        });
                        var price = int.parse(itemPriceController.text);
                        var itemQuantity = int.parse(itemQuantityController.text);
                        var total = price * itemQuantity;

                        print(total);

                        TotalSum.number.add(total);

                        print(TotalSum.number.length);
                        itemNameController.clear();
                        itemPriceController.clear();
                        itemQuantityController.clear();
                      },
                      child: Container(
                        height: 40.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(14.r)),
                        child: Center(
                            child: Text(
                          'Add Item',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )),
                  ],
                ))
              ],
            ),
          ),
        ),
        Step(
            title: const Text('Description'),
            content: SizedBox(
              height: 140.h,
              // color: Colors.blue,
              child: CustomDescriptionField(
                  text: 'Description',
                  validatorText: 'Enter Some Description',
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline),
            )),
        Step(
            title: const Text('Terms and Conditions'),
            content: SizedBox(
              height: 140.h,
              // color: Colors.blue,
              child: CustomDescriptionField(
                  text: 'Terms and Conditions',
                  validatorText: 'Enter Terms and conditions',
                  controller: termsController,
                  keyboardType: TextInputType.multiline),
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColor.mainColor,
        title: Text(
          'Form',
          style: TextStyle(
              color: CustomColor.wTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 24.sp),
        ),
      ),
      body: BlocBuilder<StepsCubit, int>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Stepper(
                      physics: const ClampingScrollPhysics(),
                      currentStep: state,
                      onStepTapped: (state) {
                        context.read<StepsCubit>().getIndex(index: state);
                      },
                      type: StepperType.vertical,
                      onStepContinue: () {
                        if (state < 5) {
                          context.read<StepsCubit>().getIndex(index: state + 1);
                        } else {
                          context.read<StepsCubit>().getIndex(index: state);
                        }
                      },
                      onStepCancel: () {
                        if (state > 0) {
                          context.read<StepsCubit>().getIndex(index: state - 1);
                        } else {
                          context.read<StepsCubit>().getIndex(index: state);
                        }
                      },
                      steps: stepList()),
                ),
                Signature(
                  controller: signatureController,
                  height: 150.h,
                  width: 300.w,
                  backgroundColor: Colors.orange.shade50,
                ),
                Container(
                  decoration:
                      const BoxDecoration(color: CustomColor.containerColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //SHOW EXPORTED IMAGE IN NEW ROUTE
                      IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.blue,
                        onPressed: () async {
                          if (signatureController.isNotEmpty) {
                            final Uint8List? data =
                                await signatureController.toPngBytes();
                            if (data != null) {
                              await Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return Scaffold(
                                      appBar: AppBar(),
                                      body: Center(
                                        child: Container(
                                          color: Colors.grey[300],
                                          child: Image.memory(data),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() => signatureController.clear());
                        },
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    /// Button Used TO make PDF File




                    if (_formKey.currentState!.validate()) {

                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please Fill the Complete Form',
                          backgroundColor: Colors.red,
                          toastLength: Toast.LENGTH_LONG);
                    }

                    var signature = await signatureController.toPngBytes();
                    if (signatureController != null ||
                        !signatureController.isEmpty) {
                      final pdf = await MyPdf.generateNewPdf(
                          model: invoice(), signature: signature!);
                      MyPdf.openMyFile(pdf);
                    } else {
                      debugPrint('==================');
                      debugPrint('======== error ==========');
                    }
                  },
                  child: Container(
                    height: 40.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: CustomColor.mainColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                        child: Text('Generate PDF',
                            style: TextStyle(
                              color: CustomColor.hColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ))),
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
