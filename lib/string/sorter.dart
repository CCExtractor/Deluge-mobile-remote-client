import 'package:deluge_client/components/all_acc.dart';
import 'package:flutter/material.dart';

class sort_helper {
  static bool reverse_order = false;
  static bool non_reverse_order = true;
  static Map<String, dynamic> sort(Map<String, dynamic> map)  {
    
    return Map.fromEntries(map.entries.toList().reversed);
  }



}
