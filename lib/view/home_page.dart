import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_colors.dart';
import 'invoice.dart';

class HomePage extends StatelessWidget {

   const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColor.mainColor,
        title: Text(
          'Invoice',
          style: TextStyle(
              color: CustomColor.wTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 24.sp),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return const Invoice();

                      }));
                    },
                    icon: Icon(
                      Icons.insert_drive_file_outlined,
                      color: CustomColor.mainColor,
                      size: 70.sp,
                    ))),

          ],
        ),
      ),
    );
  }
}
