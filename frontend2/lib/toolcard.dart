import 'package:flutter/material.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.image,      // Widget to show in the icon area (e.g. Image.asset, Icon, SvgPicture)
    required this.title,      // Bold heading text shown below the icon
    required this.subtitle,   // Muted description text shown below the title
    this.onTap,               // Optional tap callback; wraps the card in an InkWell when provided
    this.width,               // Card width; defaults to 180 — set to double.infinity for full-width
    this.height,
    this.iconBackgroundColor, // Background color of the icon container; defaults to a soft coral
  });
 
  final Widget image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? iconBackgroundColor;
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 250,           // constrains the card to a fixed width by default
      height: height ?? 225,
      child: Material(
        color: Colors.white,          // card surface color
        borderRadius: BorderRadius.circular(16),  // corner radius matching the screenshot
        elevation: 5,                 // no Material elevation — shadow is handled via BoxDecoration
        child: InkWell(
          onTap: onTap,               // ripple tap; set null to disable interaction
          borderRadius: BorderRadius.circular(16),  // clips ripple to card corners
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(20),  // inner spacing on all sides
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  // left-aligns all children
                mainAxisSize: MainAxisSize.min,                // shrink-wraps height to content
                children: [
                  // ── Icon container ──────────────────────────────────────────
                  Container(
                    width: 52,   // icon box width
                    height: 52,  // icon box height
                    decoration: BoxDecoration(
                      color: iconBackgroundColor ?? const Color(0xFFEF6E50),  // coral default
                      borderRadius: BorderRadius.circular(10),  // icon box corner radius
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 28,   // constrain the image/icon inside the container
                        height: 28,
                        child: image,  // your image/icon widget goes here
                      ),
                    ),
                  ),
 
                  const SizedBox(height: 16),  // vertical gap between icon and title
 
                  // ── Title ────────────────────────────────────────────────────
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,              // title font size
                      fontWeight: FontWeight.w700, // bold weight
                      color: Color(0xFF1A1A2E),  // near-black title color
                      height: 1.3,               // line height multiplier
                    ),
                  ),
 
                  const SizedBox(height: 6),  // vertical gap between title and subtitle
 
                  // ── Subtitle ─────────────────────────────────────────────────
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,              // subtitle font size; smaller than title
                      fontWeight: FontWeight.w400, // regular weight
                      color: Color(0xFF6B7280),  // muted gray color
                      height: 1.5,               // looser line height for readability
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 