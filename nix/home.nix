{ lib, pkgs, ... }:

{
  home = {
    stateVersion = "25.05";

    homeDirectory = lib.mkForce "/Users/cosmin";
    username = "cosmin";

    # https://github.com/zupo/dotfiles/blob/main/flake.nix
    file.".hushlogin" = {
      text = "";
    };

    packages = with pkgs; [
      zellij
      starship
      uv
      ruff
      gh
      eza
      httpie
      
      helix
      nil
      rustup
      bacon
      codecrafters-cli

      go
      delve
      gopls
      golangci-lint
      golangci-lint-langserver
    ];
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "tatucosmin";
    userEmail = "cosminsebastian2004@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "tokyo-night-dark";
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "github_dark";
      editor = {
        end-of-line-diagnostics = "hint";
      };
    };
    languages = {
      language-server.golangci-lint-lsp = {
        command = "golangci-lint-langserver";
      };
      language-server.golangci-lint-lsp.config = {
        command = ["golangci-lint" "run" "--output.json.path=stdout" "--show-stats=false" "--issues-exit-code=1"];
      };
      language-server.rust-analyzer.config.check = {
        command = "clippy";
      };
      language-server.rust-analyzer.config.cargo = {
        features = "all";
      };
      language = [{
        name = "nix";
        auto-format = true;
      }
      {
        name = "rust";
        auto-format = true;
      }];
    };
  };
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
      zj = "zellij";
      vim = "hx";
      nvim = "hx";
      ls = "eza";
      ll = "eza -1";
    };
  };
  
  programs.starship = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "ZedMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "ZedMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "ZedMono Nerd Font";
          style = "Italic";
        };
        size = 14;
      };
    };
  };
}
