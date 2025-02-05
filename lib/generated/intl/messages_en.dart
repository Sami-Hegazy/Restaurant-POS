// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(item) => "Added ${item} to order";

  static String m1(id) => "Menu Item Number ${id}";

  static String m2(name) => "Order completed successfully for ${name}";

  static String m3(name) => "Order completed successfully for ${name}";

  static String m4(number) => "Table ${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addedToOrder": m0,
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
        "burger": MessageLookupByLibrary.simpleMessage("Burger"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "completeOrder": MessageLookupByLibrary.simpleMessage("Complete Order"),
        "customerInfo":
            MessageLookupByLibrary.simpleMessage("Customer Information"),
        "deliveryAddress":
            MessageLookupByLibrary.simpleMessage("Delivery Address"),
        "desserts": MessageLookupByLibrary.simpleMessage("Desserts"),
        "drinks": MessageLookupByLibrary.simpleMessage("Drinks"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "menu": MessageLookupByLibrary.simpleMessage("Menu"),
        "menuItem": m1,
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nameRequired":
            MessageLookupByLibrary.simpleMessage("Name is required"),
        "noOrdersFound":
            MessageLookupByLibrary.simpleMessage("No orders found"),
        "noodles": MessageLookupByLibrary.simpleMessage("Noodles"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "order": MessageLookupByLibrary.simpleMessage("Order"),
        "orderCompleted": m2,
        "orderCompletedFor": m3,
        "orderItems": MessageLookupByLibrary.simpleMessage("Order Items"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "promos": MessageLookupByLibrary.simpleMessage("Promos"),
        "restaurantName":
            MessageLookupByLibrary.simpleMessage("The Arabic Kitchen"),
        "search": MessageLookupByLibrary.simpleMessage("Search menu here..."),
        "searchHint": MessageLookupByLibrary.simpleMessage(
            "Search by customer name or table number..."),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "success": MessageLookupByLibrary.simpleMessage("Success!"),
        "table": m4,
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "undo": MessageLookupByLibrary.simpleMessage("UNDO"),
        "viewOrder": MessageLookupByLibrary.simpleMessage("View Order")
      };
}
