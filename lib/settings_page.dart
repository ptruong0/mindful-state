import 'package:flutter/material.dart';

class MaterialSettings extends StatelessWidget {
  const MaterialSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  const _CustomListTile(
                      title: "About Phone", icon: Icons.phone_android),
                  _CustomListTile(
                      title: "Dark Mode",
                      icon: Icons.brightness_3,
                      trailing: Switch(value: false, onChanged: (value) {})),
                  const _CustomListTile(
                      title: "System Apps Updater", icon: Icons.cloud_download),
                  const _CustomListTile(
                      title: "Security Status", icon: Icons.security),
                ],
              ),
              _SingleSection(
                title: "Network",
                children: [
                  const _CustomListTile(
                      title: "SIM Cards and Networks", icon: Icons.sim_card),
                  _CustomListTile(
                    title: "Wi-Fi",
                    icon: Icons.wifi,
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  _CustomListTile(
                    title: "Bluetooth",
                    icon: Icons.bluetooth,
                    trailing: Switch(value: false, onChanged: (val) {}),
                  ),
                  const _CustomListTile(
                    title: "VPN",
                    icon: Icons.vpn_key,
                  )
                ],
              ),
              const _SingleSection(
                title: "Privacy and Security",
                children: [
                  _CustomListTile(
                      title: "Multiple Users", icon: Icons.people_outline),
                  _CustomListTile(
                      title: "Lock Screen", icon: Icons.lock_outline),
                  _CustomListTile(title: "Display", icon: Icons.screen_share),
                  _CustomListTile(
                      title: "Sound and Vibration", icon: Icons.volume_up),
                  _CustomListTile(title: "Themes", icon: Icons.color_lens)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward,
            size: 18,
            color: Theme.of(context).iconTheme.color,
          ),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Container(
          width: double.infinity,
          color: Theme.of(context).canvasColor,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
