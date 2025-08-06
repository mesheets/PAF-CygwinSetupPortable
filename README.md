PortableApps.com Format Packaging for Cygwin Setup
==================================================
A [PortableApps.com](https://portableapps.com/) package bundler
for [Cygwin](https://cygwin.com/) setup, installation, and updating.

The intent of this project is to provide a basic portable Cygwin environment.
Given the nature of a portable environment, more advanced capabilities that
have greater integration with the underlying Windows system might not be
handled automatically.

Making Cygwin Portable
----------------------
A good portable setup will—in keeping with PortableApps.com standards—prevent
leaving artifacts behind after removal.

### Installation
As a minium, two PortableApps.com format packages (`\*.paf.exe`) are required:
1. Cygwin Setup Portable (this project)
2. A corresponding portable Cygwin [Console](https://github.com/mesheets/PAF-CygwinConsolePortable) or Terminal

The installation steps are the same for each:
1. Download the `\*.paf.exe` file releases for the respective projects
2. Open the PortableApps.com menu
3. Along the menu’s right column, click “Apps”
4. From the pop-up context menu, select “Install a New App [paf.exe]”
5. Select one of the `\*.paf.exe` file releases downloaded in the earlier step

If wishing to make specific fonts available portably as well, those may be copied to the
`.\PortableApps\PortableApps.com\Data\Fonts` directory that can be found in a standard
PortableApps.com platform setup (c.f. [portable font support documentation](https://portableapps.com/support/platform#fonts)).
An example would be [Cascadia Code / Cascadia Mono](https://github.com/Microsoft/Cascadia-Code),
which is a default font in [Windows Terminal](https://github.com/Microsoft/Terminal).

### Usage
1. From the PortableApps.com menu, run “Cygwin Setup & Updater” to complete the initial Cygwin portable installation
   * Access the Cygwin Setup & Update for this portable installation **ONLY** through this PortableApps.com wrapper.
   * A `Cygwin` folder will be created within the root directory of the PortableApps.com installation, alongside `Start.exe` file and the `Documents` and `PortableApps` folders that are created by a PortableApps.com installation.
2. Access this portable installation **ONLY** through the corresponding Cygwin portable console or terminal to prevent unintended modifications to the local system environment
3. If multiple console or terminal sessions are needed, open a new tab within the Cygwin portable console app
4. To ensure that the registry of the host system can be properly restored to its original state, “Cygwin Setup & Updater” and “Cygwin Console” canNOT be running at the same time.

### Differences and Requirements when Running as Portable:
* Portability and preservation of the host environment are only maintained if using the corresponding portable console or terminal.
  + [Cygwin Console Portable packaged in the PortableApps.com format](https://github.com/mesheets/PAF-CygwinConsolePortable)
  + A similar portable package could likely be created based on Windows Terminal, but such a package does not yet exist.
* The `/etc/passwd` file under the portable installation is maintained so that the Cygwin user name (and home path) remain the same regardless of the changing hosts and their respective system environments.
* To avoid breaking or corrupting the local system environment:
  + Do _not_ run both Cygwin setup and a Cgywin console or terminal session at the same time.
    - The PortableApps.com Cgywin Setup and Console packages have been configured to enforce this on the portable side, but if executing directly outside of the portable wrappers, no protections are in place.
  + Do _not_ use both a local install of Cygwin and a portable Cygwin at the same time.

### Portability Considerations
The [Cygwin uninstall FAQ section](https://cygwin.com/faq.html#faq.setup.uninstall-all)
raises several considerations that must be taken into account for portability.

| Consideration | Measures Taken (if any) |
| ------------- | ----------------------- |
| Running Cygwin Services | Any Cygwin services that have been installed by the user must also be uninstalled by the user |
| Running an X11 Server | If an X11 server has been started by the user, it (and any other Cygwin programs must also be ended by the user |
| Configuring Windows to Use LSA Authentication | The Windows registry key changed by `cyglsa-config` will be automatically restored to its prior value upon exiting the portable console/terminal, but Windows will need to be rebooted for this change to take effect, and the user will _not_ be prompted to reboot. |
| The Cygwin Folder and Subfolders | The Cygwin folder is under the same root as PortableApps.com’s `Start.exe`, and the PortableApps.com app system manages the folder paths, so as long as this portable Cygwin environment is accessed via the PortableApps.com Platform, drives and/or folder can change without breaking the system. |
| Desktop and Start Menu Shortcuts | When executed via the menu options in the PortableApps.com Platform, creation of both Desktop and Start Menu shortcuts is disabled. |
| Adding Cygwin Paths to the System PATH | When executed via the menu options in the PortableApps.com Platform, Cygwin will be in the PATH for that runtime environment, but if the user makes any changes to environment variables, reverting of those changes will also need to be done by the user.  For a portable environment, such changes to environment variables are probably undesirable to begin with, so this is not anticipated to be a major issue. |
| Created Registry Keys | Similar to the how the registry key for authentication is handled, the `HKLM\SOFTWARE\Cygwin` and `HKCU\SOFTWARE\Cygwin` registry keys are preserved when running through the PortableApps.com Platform and then restored upon exit.  Thus, even if there is a locally-installed version of Cygwin (in addition to the portable version), the portable version should not break the configuration of the locally-installed version.  Impacts of running both the locally-installed version and the portable version concurrently are unknown at the present. |


PortableApps.com Format Packaging Steps
---------------------------------------
1. Copy icons and icon images to `.\App\AppInfo`
2. Create a .\Help.html file, with file dependencies under `.\Other\Help`
3. Copy the app distribution itself to `.\App\Cygwin`, plus the following Batch files:
   1. `CygwinSetupPortable.bat`
   2. `Cygwin-Portable.bat`
4. Create the following PortableApps.com configuration files:
   1. `.\App\AppInfo\AppInfo.ini`
   2. `.\App\AppInfo\Launcher\CygwinSetupPortable.ini`
5. Run the PortableApps.com Launcher to create the portable app launcher
6. Run the PortableApps.com Installer to create the portable app installer
