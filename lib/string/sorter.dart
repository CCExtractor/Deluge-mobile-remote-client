import 'package:deluge_client/core/all_acc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class sort_helper {
  static bool reverse_order = false;
  static bool non_reverse_order = true;
  static bool by_size_order = false;
  static bool by_date_time = false;
  static Map<String, dynamic> sort(Map<String, dynamic> map) {
    return Map.fromEntries(map.entries.toList().reversed);
  }

  static Map<multtorrent, dynamic> sort_for_multi(
      Map<multtorrent, dynamic> map) {
    return Map.fromEntries(map.entries.toList().reversed);
  }

  static Map<String, dynamic> sort_by_size(Map<String, dynamic> map) {
    List<map_as_list_view> mid_list = new List<map_as_list_view>();
    map.entries.forEach((e) =>
        mid_list.add(map_as_list_view(hash: e.key, properties: e.value)));
    mid_list.sort((a, b) => (a.properties['total_size'] ~/ 1000000)
        .compareTo(b.properties['total_size'] ~/ 1000000));
    Map<String, dynamic> output_map = new Map<String, dynamic>();
    mid_list.forEach((val) => output_map[val.hash] = val.properties);

    return output_map;
  }

  static Map<multtorrent, dynamic> sort_by_size_for_multi(
      Map<multtorrent, dynamic> map) {
    List<map_as_list_view_for_multi> mid_list =
        new List<map_as_list_view_for_multi>();
    map.entries.forEach((e) => mid_list
        .add(map_as_list_view_for_multi(identity: e.key, properties: e.value)));
    mid_list.sort((a, b) => (a.properties['total_size'] ~/ 1000000)
        .compareTo(b.properties['total_size'] ~/ 1000000));
    Map<multtorrent, dynamic> output_map = new Map<multtorrent, dynamic>();
    mid_list.forEach((val) => output_map[val.identity] = val.properties);

    return output_map;
  }

  //-----------date and time comparision
  static Map<String, dynamic> sort_by_date_time(Map<String, dynamic> map) {
    final format = new DateFormat('dd-MM-yyyy hh:mm a');
    final eta = new DateFormat('hh:mm');
    List<map_as_list_view> mid_list = new List<map_as_list_view>();
    map.entries.forEach((e) =>
        mid_list.add(map_as_list_view(hash: e.key, properties: e.value)));
    mid_list.sort((a, b) => (format.format(DateTime.fromMillisecondsSinceEpoch(
            a.properties['time_added'] * 1000)))
        .compareTo(format.format(DateTime.fromMillisecondsSinceEpoch(
            b.properties['time_added'] * 1000))));
    Map<String, dynamic> output_map = new Map<String, dynamic>();
    mid_list.forEach((val) => output_map[val.hash] = val.properties);

    return output_map;
  }
  //-for multi
  static Map<multtorrent, dynamic> sort_by_date_time_for_multi(
      Map<multtorrent, dynamic> map) {
    final format = new DateFormat('dd-MM-yyyy hh:mm a');
    final eta = new DateFormat('hh:mm');

    List<map_as_list_view_for_multi> mid_list =
        new List<map_as_list_view_for_multi>();
    map.entries.forEach((e) => mid_list
        .add(map_as_list_view_for_multi(identity: e.key, properties: e.value)));
   mid_list.sort((a, b) => (format.format(DateTime.fromMillisecondsSinceEpoch(
            a.properties['time_added'] * 1000)))
        .compareTo(format.format(DateTime.fromMillisecondsSinceEpoch(
            b.properties['time_added'] * 1000))));
    Map<multtorrent, dynamic> output_map = new Map<multtorrent, dynamic>();
    mid_list.forEach((val) => output_map[val.identity] = val.properties);

    return output_map;
  }

}

class map_as_list_view {
  String hash;
  Map<String, dynamic> properties;
  map_as_list_view({this.hash, this.properties});
}

class map_as_list_view_for_multi {
  multtorrent identity;
  Map<String, dynamic> properties;
  map_as_list_view_for_multi({this.identity, this.properties});
}
