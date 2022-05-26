import 'package:intl/intl.dart';

class TotalSum{

  static List<int> number=[];

  static int grandTotal() {
    var sum=0 ;

    var data = number;
    for(var i=0 ; i<data.length;i++)
    {
      sum += data[i];

    }

    print('Sum ${sum}');

    return sum;
  }


}