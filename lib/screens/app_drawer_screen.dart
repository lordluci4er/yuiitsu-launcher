import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import '../services/apps_service.dart';

class AppDrawerScreen extends StatefulWidget {
  const AppDrawerScreen({super.key});

  @override
  State<AppDrawerScreen> createState() => _AppDrawerScreenState();
}

class _AppDrawerScreenState extends State<AppDrawerScreen> {
  List<Application> apps = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadApps();
  }

  Future<void> loadApps() async {
    apps = await AppsService.getInstalledApps();

    apps.sort(
      (a, b) => a.appName.toLowerCase().compareTo(
            b.appName.toLowerCase(),
          ),
    );

    setState(() {
      loading = false;
    });
  }

  void openApp(String packageName) {
    DeviceApps.openApp(packageName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("All Apps"),
        backgroundColor: Colors.black,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: apps.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final app = apps[index];

                return GestureDetector(
                  onTap: () => openApp(app.packageName),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (app is ApplicationWithIcon)
                        Image.memory(
                          app.icon,
                          width: 48,
                          height: 48,
                        ),
                      const SizedBox(height: 8),
                      Text(
                        app.appName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}