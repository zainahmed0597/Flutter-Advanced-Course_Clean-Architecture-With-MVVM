
// extension of String
import 'package:project_1/data/mapper/mapper.dart';

extension NonNullString on String?{
  String orEmpty(){
    if (this == null){
      return EMPTY;
    }else {
      return this!;
    }
  }
}


// extension of Integer
extension NonNullInt on int?{
  int orZero(){
    if (this == null){
      return ZERO;
    }else {
      return this!;
    }
  }
}