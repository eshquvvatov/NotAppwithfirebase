import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class LinkService{


  static Future<Uri> createLongLink(String partnerId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://pinteristclone.page.link',
      link: Uri.parse("https://pinterist?partnerId=$partnerId",),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.pinterest_clone_project',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.pinterest_clone_project',
        minimumVersion: '13.0',
        appStoreId: '1605546414',
      ),
      navigationInfoParameters:
      const NavigationInfoParameters(forcedRedirectEnabled: true),
    );
    final Uri uri = await FirebaseDynamicLinks.instance.buildLink(parameters);
    // LogService.d(uri.toString());
    return uri;
  }

  static Future<Uri> createShortLink(String partnerId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://pinteristclone.page.link',
      link: Uri.parse("https://pinterist?partnerId=$partnerId",),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.pinterest_clone_project',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.pinterest_clone_project',
        minimumVersion: '13.0',
        appStoreId: '1605546414',
      ),
      navigationInfoParameters:
      const NavigationInfoParameters(forcedRedirectEnabled: true),
    );

    var shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    var shortUrl = shortLink.shortUrl;
    // LogService.d(shortUrl.toString());
    print("*********************************************");
    print(shortUrl);
    return shortUrl;
  }

  static Future<Uri?> retrieveDynamicLink() async {
    try {
      final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;
      // LogService.d(deepLink.toString());
      //#todo save deep link info to local and use when user logins in
      print("aaaaaaaaaaaaaaaaaaa" + deepLink!.query.toString());
      return deepLink;
    } catch (e) {
      // LogService.d(e.toString());
    }

    return null;
  }
}