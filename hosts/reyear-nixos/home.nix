{ config, pkgs, ... }:

{
  imports = [
    ./home/packages.nix
    ./home/direnv.nix
    ./home/git.nix
    ./home/shell.nix
    ./home/editors.nix
    ./home/ssh.nix
    ./home/zsh.nix
    ./home/devtools.nix
  ];

  home.username = "reyear";
  home.homeDirectory = "/home/reyear";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # ============================================
  # Plasma Manager 配置
  # ============================================
  programs.plasma = {
    enable = true;

    # KWin 窗口特效配置
    kwin.effects = {
      magiclamp.enable = true;
      wobblyWindows.enable = true;
      desktopgrid.enable = true;
      presentWindows.enable = true;

      # 最小化动画配置
      minimization = {
        animation = "magiclamp";
        duration = 400;
      };
    };
  };

  # ============================================
  # 手动 KDE 配置（仅保留非动效配置）
  # ============================================
  xdg.configFile = {
    # KWin 窗口行为配置
    "kwinrc" = {
      text = ''
        [Windows]
        BorderSnapZone=10
        CenterSnapZone=0
        SnapOnlyWhenClose=false
        ActiveMouseScreen=true
      '';
    };

    # Plasma 面板配置
    "plasmashellrc" = {
      text = ''
        [PlasmaViews][Panel 2]
        floating=1

        [PlasmaViews][Panel 2][Defaults]
        thickness=44
      '';
    };
  };

  # 添加系统监视器小组件到包列表
  home.packages = with pkgs; [
    kdePackages.plasma-systemmonitor
    kdePackages.plasma-workspace
    kdePackages.ksystemstats
    kdePackages.plasma-nm
  ];
}
