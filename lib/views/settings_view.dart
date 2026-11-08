
import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/repositories/user_settings_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _patronNumberController;

  bool _receiveNews = false;

  @override
  void initState() {
    super.initState();

    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _patronNumberController = TextEditingController();

    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings =
        await UserSettingsRepository.instance.loadSettings();

    if (!mounted) return;

    setState(() {
      _addressController.text = settings.address;
      _emailController.text = settings.email;
      _patronNumberController.text = settings.patronNumber;
      _receiveNews = settings.receiveNews;
    });
  }

  void _cancelChanges() {
    _loadSettings();
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final settings = UserSettings(
      address: _addressController.text,
      email: _emailController.text,
      patronNumber: _patronNumberController.text,
      receiveNews: _receiveNews,
    );

    await UserSettingsRepository.instance.saveSettings(settings);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved successfully'),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _patronNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Settings',
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              _buildLabel('Address'),
              _buildTextField(
                controller: _addressController,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _addressController.clear();
                  },
                ),
              ),
              const SizedBox(height: 28),
              _buildLabel('Email Address'),
              _buildTextField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 28),
              _buildLabel('Patron Number'),
              _buildTextField(
                controller: _patronNumberController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your patron number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              _buildLabel('Preferences'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Receive news by email',
                      style: TextStyle(
                        color: cinemaFontWhite,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Switch(
                    value: _receiveNews,
                    activeThumbColor: cinemaBrand,
                    onChanged: (value) {
                      setState(() {
                        _receiveNews = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cinemaSurface,
                        foregroundColor: cinemaFontWhite,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: _cancelChanges,
                      child: const Text('CANCEL'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      label: 'SAVE SETTINGS',
                      onPressed: _saveSettings,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    int maxLines = 1,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(
        color: cinemaFontWhite,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: cinemaSurface,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(16),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: cinemaSurface),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: cinemaBrand),
        ),
      ),
    );
  }
}
