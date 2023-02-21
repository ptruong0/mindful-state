import 'package:flutter/material.dart';

class MaterialSettings extends StatelessWidget {
  const MaterialSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaffold provides a basic material design visual layout structure
    return Scaffold(
      // AppBar displays the app bar at the top of the screen
      appBar: AppBar(
        title: const Text("Settings"), // Text to be displayed in the app bar
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
              maxWidth: 400), // limits the width of the container
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  // A custom list tile for the "Profile Information" item
                  const _CustomListTile(
                      title: "Profile Information", icon: Icons.person),
                  // A custom list tile for the "Dark Mode" item
                  _CustomListTile(
                    title: "Dark Mode",
                    icon: Icons.brightness_3,
                    // A switch widget that is used to turn on and off the dark mode
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                ],
              ),
              // A single section of custom list tiles
              const _SingleSection(
                title: "Privacy and Security",
                children: [
                  _CustomListTile(
                      title: "Privacy Policy", icon: Icons.privacy_tip),
                  _CustomListTile(title: "Acknowledgements", icon: Icons.info),
                  _CustomListTile(title: "Contact Us", icon: Icons.email),
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
    // ListTile provides a material design list item
    return ListTile(
      // The title of the list item
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      // The leading icon of the list item
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      // The trailing widget of the list item, defaults to an arrow forward icon
      trailing: trailing ??
          Icon(
            Icons.arrow_forward,
            size: 18,
            color: Theme.of(context).iconTheme.color,
          ),
      onTap: () {}, // The function to be called when the list item is tapped
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
      // Align the children at the start of the main axis (top of the screen)
      mainAxisAlignment: MainAxisAlignment.start,
      // Align the children at the start of the cross axis (left of the screen)
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add some empty space before the section title
        const SizedBox(height: 16),
        // The section title, displayed in upper case
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
        // A container that holds all the children list items, with

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
