# winape_load

This repository contains a set of useful scripts for **Windows** that simplify the process of running .dsk with [**CPCTelera**](https://github.com/lronaldo/cpctelera), a game engine from **Amstrad CPC**. These scripts were developed to address problems with running WinAPE in Wine on Linux [**(WSL on Windows)**](https://learn.microsoft.com/en-us/windows/wsl/install), providing a solution for Windows users by separating the compile and build on linux (wsl on windows) while running on the system. host (Windows).

**`Note:`** The scripts provided in this repository were created to work around the problem of running WinAPE in Wine on Linux (WSL on Windows), so they were designed specifically for Windows operating systems.

### **How to use**


- **`Required!`** **Install winape_load scripts:** Run the install script to automatically install the scripts on your Windows system. **Run as administrator in your terminal (cmd or powershell), to avoid permission issues for installation.** 

```bat
.\install.bat
```

- **Install WinAPE:** Run the installation script to automatically download and configure WinAPE on your Windows system.

```bat
winape_install
```

- **Run CPCTelera project:** Run the project run script to start WinAPE and load your .dsk and .noi file automatically at every file change.

 1. Access the project folder to run from terminal **cmd** or **powershell**
 2. Run command inside project folder
```bat
winape_load
```

### **For WSL or (Windows Subsystem Linux)**

If you use wsl you can run winape_load directly from the linux terminal bash or others and it will automatically run the \*.dsk and obj/\*.noi files of the cpctelera project. For that we create, we execute the following command in the wsl terminal:

#### For bash interpreters

```bash
echo "alias winape_load='cmd.exe /C winape_load --auto-load'" >> ~/.bashrc && source ~/.bashrc
```

#### For zsh interpreters

```bash
echo "alias winape_load='cmd.exe /C winape_load --auto-load'" >> ~/.zshrc && source ~/.zshrc
```

**`Note:`** There are other shells that almost always change the name of the configuration file. In this case, edit the following at the end of the interpreter configuration file:

```bash
alias winape_load='cmd.exe /C winape_load --auto-load'
```

With this, what we achieve is that from a linux terminal, execute our script that is in the host system and be able to do, for example, in a project:

```bat
make && winape_load
```


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.