import 'package:flutter/material.dart';

class MaterialSettings extends StatelessWidget {
  const MaterialSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
                      title: "Profile Information", icon: Icons.person),
                  _CustomListTile(
                      title: "Dark Mode",
                      icon: Icons.brightness_3,
                      trailing: Switch(value: false, onChanged: (value) {})),
                ],
              ),
              const _SingleSection(
                title: "Privacy and Security",
                children: [
                  _CustomListTile(
                      title: "Privacy Policy", icon: Icons.privacy_tip),
                  _CustomListTile(title: "Acknowledgements", icon: Icons.info),
                  _CustomListTile(title: "Contact Us", icon: Icons.email),
                ],
              ),
              // _SingleSection(
              //   title: "Network",
              //   children: [
              //     const _CustomListTile(
              //         title: "SIM Cards and Networks", icon: Icons.sim_card),
              //     _CustomListTile(
              //       title: "Wi-Fi",
              //       icon: Icons.wifi,
              //       trailing: Switch(value: true, onChanged: (val) {}),
              //     ),
              //     _CustomListTile(
              //       title: "Bluetooth",
              //       icon: Icons.bluetooth,
              //       trailing: Switch(value: false, onChanged: (val) {}),
              //     ),
              //     const _CustomListTile(
              //       title: "VPN",
              //       icon: Icons.vpn_key,
              //     )
              //   ],
              // ),
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
