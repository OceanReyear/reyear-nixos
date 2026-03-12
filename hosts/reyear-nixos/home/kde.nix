{ lib, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    # 面板配置
    panels = [
      {
        location = "bottom";
        floating = true;  # 悬浮效果
        height = 48;
        opacity = "adaptive";  # 自适应透明度

        widgets = [
          # 应用启动器
          {
            kickoff = {
              icon = "nix-snowflake-white";
            };
          }

          # 分隔符
          "org.kde.plasma.marginseparator"

          # 任务管理器
          "org.kde.plasma.icontasks"

          # 分隔符
          "org.kde.plasma.marginseparator"

          # CPU 使用率监控 - 使用 textOnlySensorIds
          {
            name = "org.kde.plasma.systemmonitor";
            config = {
              "Appearance/chartFace" = "org.kde.ksysguard.textonlychart";
              "Sensors/textOnlySensorIds" = [ "cpu/all/usage" ];
            };
          }

          # 内存使用率监控
          {
            name = "org.kde.plasma.systemmonitor";
            config = {
              "Appearance/chartFace" = "org.kde.ksysguard.textonlychart";
              "Sensors/textOnlySensorIds" = [ "memory/physical/usedPercent" ];
            };
          }

          # 网络速度监控
          {
            name = "org.kde.plasma.systemmonitor";
            config = {
              "Appearance/chartFace" = "org.kde.ksysguard.textonlychart";
              "Sensors/textOnlySensorIds" = [
                "network/all/download"
                "network/all/upload"
              ];
            };
          }

          # 记事贴 - 点击打开记事贴
          {
            name = "org.kde.plasma.notes";
            config = {
              General = {
                noteId = "quick-note";
              };
            };
          }

          # 系统托盘
          {
            systemTray = {
              items = {
                shown = [
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.battery"
                ];
                hidden = [
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                ];
              };
            };
          }

          # 数字时钟
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
            };
          }
        ];
      }
    ];
  };
}