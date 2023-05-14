# Dotfiles

### Might be a lightweight version of vim, install full
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
    
### Chromium backups
  - the chromium folder in files contains def_chromium which is used to make fresh anon instances 
  by copying it in a temp folder and making an instance on that config and the chromium which is 
  the main chromium config
  - also the chromium dir in files contains the ch and ch0 scripts 

  - delete all user data in chrome for each profile than you can compress and save the profile folder
  ``` 
    cd ~/.config/
    tar -czvf ~/dotfiles/chromium/chromium.tar.gz chromium/
  ```
  

