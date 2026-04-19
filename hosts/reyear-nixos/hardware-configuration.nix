# 由 nixos-generate-config 生成，已手动调整 btrfs 子卷布局                                                                                          
  { config, lib, pkgs, modulesPath, ... }:                                                                                                            
                                                                                                                                                      
  {                                                                                                                                                   
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];                                                                                 
                                                                                                                                                      
    boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];                             
    boot.initrd.kernelModules = [ ];                                                                                                                  
    boot.kernelModules = [ "kvm-intel" ];                                                                                                             
    boot.extraModulePackages = [ ];                                                                                                                   
                                                                                                                                                      
    # --- LUKS 加密 ---                                                                                                                               
    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/bc7e434c-6d68-45de-ae74-9d0367aa6517";                                           
                                                                                                                                                      
    # --- Btrfs 子卷挂载 ---                                                                                                                          
    fileSystems."/" = {                                                                                                                               
      device = "/dev/mapper/cryptroot";                                                                                                               
      fsType = "btrfs";                                                                                                                               
      options = [ "subvol=@root" ];                                                                                                                   
    };                                                                                                                                                
                                                                                                                                                      
    fileSystems."/home" = {                                                                                                                           
      device = "/dev/mapper/cryptroot";                                                                                                               
      fsType = "btrfs";                                                                                                                               
      options = [ "subvol=@home" ];                                                                                                                   
    };                                                                                                                                                
                                                                                                                                                      
    fileSystems."/nix" = {                                                                                                                            
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";                                                                                                                               
      options = [ "subvol=/@nix" ];                                                                                                                   
    };                                                                                                                                                
                                                                                                                                                      
    fileSystems."/var/log" = {                                                                                                                        
      device = "/dev/mapper/cryptroot";                                                                                                               
      fsType = "btrfs";                                                                                                                               
      options = [ "subvol=/@log" ];
    };                                                                                                                                                
                                                                                                                                                      
    # 用于存放 Docker/容器等持久化数据                                                                                                                
    fileSystems."/var/lib" = {                                                                                                                        
      device = "/dev/mapper/cryptroot";                                                                                                               
      fsType = "btrfs";                                                                                                                               
      options = [ "subvol=/@data" ];                                                                                                                  
    };                                                                                                                                                
                                                                                                                                                      
    fileSystems."/swap" = {                                                                                                                           
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";                                                                                                                               
      options = [ "subvol=/@swap" ];                                                                                                                  
    };                                                                                                                                                
                                                                                                                                                      
    # --- EFI 引导分区 ---                                                                                                                            
    fileSystems."/boot" = {                                                                                                                           
      device = "/dev/disk/by-uuid/DA44-A6BA";                                                                                                         
      fsType = "vfat";                                                                                                                                
      options = [ "fmask=0022" "dmask=0022" ];                                                                                                        
    };                                                                                                                                                
                  
    # --- Swap ---                                                                                                                                    
    swapDevices = [ { device = "/swap/swapfile"; } ];
                                                                                                                                                      
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";                                                                                              
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;                                                 
  } 
