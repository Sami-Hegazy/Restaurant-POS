// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(item) => "تمت إضافة ${item} إلى الطلب";

  static String m1(id) => "عنصر القائمة رقم ${id}";

  static String m2(name) => "تم إتمام الطلب بنجاح لـ ${name}";

  static String m3(name) => "تم إتمام الطلب بنجاح لـ ${name}";

  static String m4(number) => "طاولة ${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addedToOrder": m0,
        "address": MessageLookupByLibrary.simpleMessage("العنوان"),
        "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
        "burger": MessageLookupByLibrary.simpleMessage("بورجر"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "completeOrder": MessageLookupByLibrary.simpleMessage("إتمام الطلب"),
        "customerInfo": MessageLookupByLibrary.simpleMessage("معلومات العميل"),
        "deliveryAddress":
            MessageLookupByLibrary.simpleMessage("عنوان التوصيل"),
        "desserts": MessageLookupByLibrary.simpleMessage("حلويات"),
        "drinks": MessageLookupByLibrary.simpleMessage("مشروبات"),
        "english": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
        "history": MessageLookupByLibrary.simpleMessage("السجل"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "language": MessageLookupByLibrary.simpleMessage("اللغة"),
        "menu": MessageLookupByLibrary.simpleMessage("القائمة"),
        "menuItem": m1,
        "name": MessageLookupByLibrary.simpleMessage("الاسم"),
        "nameRequired": MessageLookupByLibrary.simpleMessage("الاسم مطلوب"),
        "noOrdersFound": MessageLookupByLibrary.simpleMessage("لا توجد طلبات"),
        "noodles": MessageLookupByLibrary.simpleMessage("معكرونة"),
        "ok": MessageLookupByLibrary.simpleMessage("موافق"),
        "order": MessageLookupByLibrary.simpleMessage("الطلب"),
        "orderCompleted": m2,
        "orderCompletedFor": m3,
        "orderItems": MessageLookupByLibrary.simpleMessage("عناصر الطلب"),
        "phone": MessageLookupByLibrary.simpleMessage("الهاتف"),
        "promos": MessageLookupByLibrary.simpleMessage("العروض"),
        "restaurantName":
            MessageLookupByLibrary.simpleMessage("مطعم المطبخ العربي"),
        "search":
            MessageLookupByLibrary.simpleMessage("ابحث عن عنصر في القائمة..."),
        "searchHint": MessageLookupByLibrary.simpleMessage(
            "البحث باسم العميل أو رقم الطاولة..."),
        "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "submit": MessageLookupByLibrary.simpleMessage("إرسال"),
        "success": MessageLookupByLibrary.simpleMessage("تم بنجاح!"),
        "table": m4,
        "total": MessageLookupByLibrary.simpleMessage("المجموع"),
        "undo": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "viewOrder": MessageLookupByLibrary.simpleMessage("عرض الطلب")
      };
}
