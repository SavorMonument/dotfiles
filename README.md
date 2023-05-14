# Dotfiles

### Full version of vim
    ```
    sudo apt-get install vim-gui-common
    sudo apt-get install vim-runtime
    ```

### Sesors support for Prime-B450 Plus
    ```
    git clone https://github.com/a1wong/it87.git
    cd it87/
    make clean
    make
    make install
    modprobe it87
    ```
    - create the file `/etc/modules-load.d/it87.conf` with `it87` to load it at startup
    

### Password store
    ```
    sudo apt install pass
    pass git init
    pass git remote add origin [repo]
    pass git pull
    sudo apt install webext-browserpass
    ```
