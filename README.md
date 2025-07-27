PortableApps.com Packaging for Cygwin Setup
===========================================
A [PortableApps.com](https://portableapps.com/) package bundler for [Cygwin](https://cygwin.com/) setup, installation, and updating.

The intent of this project is to provide a basic portable Cygwin environment.
Given the nature of a portable environment, more advanced capabilities that
have greater integration with the underlying Windows system might not be
handled automatically.

Making Cygwin Portable
----------------------
A good portable setup will—in keeping with PortableApps.com standards—prevent
leaving artifacts behind after removal.  The [uninstall FAQ section](https://cygwin.com/faq.html#faq.setup.uninstall-all)
raises several considerations for portability.

### Important Notes:
* The HOME directory is set to `/home`, as the user name might be changing from one system to the next.

| Consideration | Measures Taken (if any) |
| ------------- | ----------------------- |
| Running Cygwin Services | Any Cygwin services that have been installed by the user must also be uninstalled by the user |
| Running an X11 Server | If an X11 server has been started by the user, it (and any other Cygwin programs must also be ended by the user |
| Configuring Windows to Use LSA Authentication | The Windows registry key changed by `cyglsa-config` will be automatically restored to its prior value, but Windows will need to be rebooted for this change to take effect, and the user will _not_ be prompted to reboot. |
| The Cygwin Folder and Subfolders | The Cygwin folder is under the same root as PortableApps.com’s `Start.exe`, and the PortableApps.com app system manages the folder paths, so as long as this portable Cygwin environment is accessed via the PortableApps.com Platform, drives and/or folder can change without breaking the system. |
| Desktop and Start Menu Shortcuts | When executed via the menu options in the PortableApps.com Platform, creation of both Desktop and Start Menu shortcuts is disabled. |
| Adding Cygwin Paths to the System PATH | When executed via the menu options in the PortableApps.com Platform, Cygwin will be in the PATH for that runtime environment, but if the user makes any changes to environment variables, reverting of those changes will also need to be done by the user.  For a portable environment, such changes to environment variables are probably undesirable to begin with, so this is not anticipated to be a major issue. |
| Created Registry Keys | Similar to the how the registry key for authentication is handled, the `HKLM\SOFTWARE\Cygwin` and `HKCU\SOFTWARE\Cygwin` registry keys are preserved when running through the PortableApps.com Platform and then restored upon exit.  Thus, even if there is a locally-installed version of Cygwin (in addition to the portable version), the portable version should not break the configuration of the locally-installed version.  Impacts of running both the locally-installed version and the portable version concurrently are unknown at the present. |


Packaging Steps
---------------
1. Copy icons and icon images to .\App\AppInfo
2. Create a .\Help.html file, with file dependencies under .\Other\Help
3. Copy the app distribution itself to .\App\Cygwin
4. Create the PortableApps.com configuration files
   1. .\App\AppInfo\AppInfo.ini
   2. .\App\AppInfo\Launcher\CygwinSetupPortable.ini
5. Run the PortableApps.com Launcher to create the portable app launcher
6. Run the PortableApps.com Installer to create the portable app installer
