import 'package:deluge_client/core/all_acc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:deluge_client/api/models/torrent_prop.dart';

class sort_helper {
  static bool reverse_order = false;
  static bool non_reverse_order = true;
  static bool by_size_order = false;
  static bool by_date_time = false;
  static Map<String, Properties> sort(Map<String,Properties> map) {
    return Map.fromEntries(map.entries.toList().reversed);
  }

  static Map<multtorrent, Properties> sort_for_multi(
      Map<multtorrent, Properties> map) {
    return Map.fromEntries(map.entries.toList().reversed);
  }

  static Map<String, Properties> sort_by_size(Map<String,Properties> map) {
    List<map_as_list_view> mid_list = new List<map_as_list_view>();
    map.entries.forEach((e) =>
        mid_list.add(map_as_list_view(hash: e.key, properties: e.value)));
    mid_list.sort((a, b) => (a.properties.totalSize ~/ 1000000)
        .compareTo(b.properties.totalSize ~/ 1000000));
    Map<String, Properties> output_map = new Map<String, Properties>();
    mid_list.forEach((val) => output_map[val.hash] = val.properties);

    return output_map;
  }

  static Map<multtorrent, Properties> sort_by_size_for_multi(
      Map<multtorrent, Properties> map) {
    List<map_as_list_view_for_multi> mid_list =
        new List<map_as_list_view_for_multi>();
    map.entries.forEach((e) => mid_list
        .add(map_as_list_view_for_multi(identity: e.key, properties: e.value)));
    mid_list.sort((a, b) => (a.properties.totalSize ~/ 1000000)
        .compareTo(b.properties.totalSize ~/ 1000000));
    Map<multtorrent,Properties> output_map = new Map<multtorrent, Properties>();
    mid_list.forEach((val) => output_map[val.identity] = val.properties);

    return output_map;
  }

  //-----------date and time comparision
  static Map<String, Properties> sort_by_date_time(Map<String,Properties> map) {
    final format = new DateFormat('dd-MM-yyyy hh:mm a');
    final eta = new DateFormat('hh:mm');
    List<map_as_list_view> mid_list = new List<map_as_list_view>();
    map.entries.forEach((e) =>
        mid_list.add(map_as_list_view(hash: e.key, properties: e.value)));
    mid_list.sort((a, b) => (format.format(DateTime.fromMillisecondsSinceEpoch(
            a.properties.timeAdded * 1000)))
        .compareTo(format.format(DateTime.fromMillisecondsSinceEpoch(
            b.properties.timeAdded * 1000))));
    Map<String, Properties> output_map = new Map<String,Properties>();
    mid_list.forEach((val) => output_map[val.hash] = val.properties);

    return output_map;
  }
  //-for multi
  static Map<multtorrent, Properties> sort_by_date_time_for_multi(
      Map<multtorrent, Properties> map) {
    final format = new DateFormat('dd-MM-yyyy hh:mm a');
    final eta = new DateFormat('hh:mm');

    List<map_as_list_view_for_multi> mid_list =
        new List<map_as_list_view_for_multi>();
    map.entries.forEach((e) => mid_list
        .add(map_as_list_view_for_multi(identity: e.key, properties: e.value)));
   mid_list.sort((a, b) => (format.format(DateTime.fromMillisecondsSinceEpoch(
            a.properties.timeAdded * 1000)))
        .compareTo(format.format(DateTime.fromMillisecondsSinceEpoch(
            b.properties.timeAdded * 1000))));
    Map<multtorrent, Properties> output_map = new Map<multtorrent,Properties>();
    mid_list.forEach((val) => output_map[val.identity] = val.properties);

    return output_map;
  }

}

class map_as_list_view {
  String hash;
  Properties properties;
  map_as_list_view({this.hash, this.properties});
}

class map_as_list_view_for_multi {
  multtorrent identity;
  Properties properties;
  map_as_list_view_for_multi({this.identity, this.properties});
}
