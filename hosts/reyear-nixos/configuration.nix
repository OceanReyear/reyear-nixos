{ config, lib, pkgs, ... }:                                                                                                                         
                                                                                                                                                      
  {                                                                                                                                                   
    imports = [ ./hardware-configuration.nix ];
                                                                                                                                                      
    # --- 引导 ---                                                                                                                                    
    boot.initrd.luks.devices."cryptroot" = {                                                                                                          
      device = "/dev/disk/by-uuid/bc7e434c-6d68-45de-ae74-9d0367aa6517";                                                                              
      allowDiscards = true;                                                                                                                           
    };                                                                                                                                                
                                                                                                                                                      
    boot.loader = {                                                                                                                                   
      efi = {                                                                                                                                         
        canTouchEfiVariables = true;                                                                                                                  
        efiSysMountPoint = "/boot";                                                                                                                   
      };
      grub = {                                                                                                                                        
        enable = true;                                                                                                                                
        device = "nodev";                                                                                                                             
        efiSupport = true;                                                                                                                            
        configurationLimit = 20;                                                                                                                      
        useOSProber = false;                                                                                                                          
        extraEntries = ''                                                                                                                             
          menuentry "Windows Boot Manager" {                                                                                                          
            search --set=root --fs-uuid F460-AA93                                                                                                     
            chainloader /efi/Microsoft/Boot/bootmgfw.efi                                                                                              
          }                                                                                                                                           
        '';                                                                                                                                           
      };                                                                                                                                              
    };                                                                                                                                                
                                                                                                                                                      
    boot.kernelPackages = pkgs.linuxPackages_latest;                                                                                                  
                                                                                                                                                      
    # --- 网络 ---                                                                                                                                    
    networking.hostName = "reyear-nixos";
    networking.networkmanager.enable = true;                                                                                                          
                                                                                                                                                      
    # --- 区域与语言 ---                                                                                                                              
    time.timeZone = "Asia/Shanghai";                                                                                                                  
    i18n.defaultLocale = "en_US.UTF-8";                                                                                                               
                                                                                                                                                      
    i18n.inputMethod = {                                                                                                                              
      type = "fcitx5";                                                                                                                                
      enable = true;                                                                                                                                  
      fcitx5.addons = with pkgs; [                                                                                                                    
        qt6Packages.fcitx5-chinese-addons                                                                                                             
        fcitx5-gtk                                                                                                                                    
      ];                                                                                                                                              
    };                                                                                                                                                
                                                                                                                                                      
    # --- 桌面环境 ---                                                                                                                                
    services.xserver = {                                                                                                                              
      enable = true;                                                                                                                                  
      videoDrivers = [ "modesetting" ];                                                                                                               
    };                                                                                                                                                
                                                                                                                                                      
    services.displayManager.sddm = {                                                                                                                  
      enable = true;                                                                                                                                  
      wayland.enable = true;                                                                                                                          
    };            
                                                                                                                                                      
    services.desktopManager.plasma6.enable = true;                                                                                                    
                                                                                                                                                      
    # --- 字体 ---                                                                                                                                    
    fonts.packages = with pkgs; [
      noto-fonts                                                                                                                                      
      noto-fonts-cjk-sans                                                                                                                             
      noto-fonts-color-emoji                                                                                                                          
      liberation_ttf                                                                                                                                  
      fira-code                                                                                                                                       
      fira-code-symbols                                                                                                                               
      mplus-outline-fonts.githubRelease                                                                                                               
      dina-font                                                                                                                                       
      jetbrains-mono                                                                                                                                  
      nerd-fonts.jetbrains-mono                                                                                                                       
      proggyfonts                                                                                                                                     
    ];                                                                                                                                                
                                                                                                                                                      
    # --- 用户 ---                                                                                                                                    
    users.users.reyear = {
      isNormalUser = true;                                                                                                                            
      extraGroups = [ "wheel" ];                                                                                                                      
      hashedPassword = "$6$IU4/Z3jWlSxOSOCu$8J2EiRmj/hUhwVzCUP/.DQQQx.NDH3qn2TIchEGl5IIamI10Zwg5mP4f5jak14AYjYhrqpFs.vTgWi6N0VaV7.";                  
    };                                                                                                                                                
                                                                                                                                                      
    # --- Nix 与包管理 ---                                                                                                                            
    nix.settings.extra-experimental-features = [ "nix-command" "flakes" ];                                                                            
    nixpkgs.config.allowUnfree = true;                                                                                                                
                                                                                                                                                      
    environment.systemPackages = with pkgs; [                                                                                                         
      vim                                                                                                                                             
      helix                                                                                                                                           
      wget                                                                                                                                            
      git                                                                                                                                             
      btop                                                                                                                                            
      firefox                                                                                                                                         
      vscode                                                                                                                                          
      claude-code                                                                                                                                     
      vlc                                                                                                                                             
      google-chrome                                                                                                                                   
      yazi                                                                                                                                            
      fastfetch                                                                                                                                       
    ];                                                                                                                                                
                                                                                                                                                      
    system.stateVersion = "25.11";                                                                                                                    
  }

