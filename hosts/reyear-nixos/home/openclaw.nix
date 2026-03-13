{ config, pkgs, ... }:

{
  programs.openclaw = {
    # 文档目录（可选）- 放置 AGENTS.md, SOUL.md, TOOLS.md 等
    # documents = ./documents;

    # OpenClaw 配置
    config = {
      gateway = {
        mode = "local";
        auth = {
          # 设置网关认证 token，或通过 OPENCLAW_GATEWAY_TOKEN 环境变量
          token = ""; # 留空时使用 OPENCLAW_GATEWAY_TOKEN 环境变量
        };
      };

      channels.telegram = {
        # Telegram bot token 文件路径
        tokenFile = "/home/reyear/.secrets/telegram-bot-token";
        # 允许响应的用户 ID 列表（通过 @userinfobot 获取）
        allowFrom = [
          # 123456789 # 替换为你的 Telegram 用户 ID
        ];
        # 群组配置
        groups = {
          "*" = {
            requireMention = true; # 需要 @mention 才响应
          };
        };
      };
    };

    # 环境变量 - 在这里设置阿里云 API key
    config.env = {
      vars = {
        # 阿里云百炼 API key
        OPENAI_API_KEY = ""; # 替换为你的阿里云 API key
        # 阿里云百炼 API 端点
        OPENAI_BASE_URL = "https://dashscope.aliyuncs.com/compatible-mode/v1";
      };
    };

    # 启用默认实例
    instances.default = {
      enable = true;
      # 可选：添加插件
      plugins = [
        # { source = "github:owner/plugin-name"; }
      ];
    };
  };
}
