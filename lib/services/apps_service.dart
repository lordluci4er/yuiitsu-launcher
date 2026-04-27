import 'package:device_apps/device_apps.dart';

class AppsService {
  static Future<List<Application>> getInstalledApps() async {
    return await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      onlyAppsWithLaunchIntent: true,
    );
  }
}