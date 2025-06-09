# nix-config/modules/waybar/waybar.nix
{ config, pkgs, ... }:

{
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      margin = "7 7 0";
      mod = "dock";

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "custom/nowplaying" ];
      modules-right = [ "tray" "network" "bluetooth" "battery" "pulseaudio" "clock" ];

      "hyprland/workspaces" = {
        format = "{name}";
	on-click = "activate";
	all-outputs = true;
	disable-scroll = false;
	sort-by-number = true;
      };
      "tray" = {
        icon-size = 18;
	spacing = 20;
      };
      "network" = {
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
	format-wifi = "{icon}";
	format-ethernet = "";
	format-linked = "󰄡";
	format-disconnected = "";
	tooltip-format = "{essid} ({signalStrength}%) - {gwaddr}";
	tooltip-format-ethernet = "{ifname} - {gwaddr}";
	tooltip-format-disconnected = "Disconnected";
      };
      "bluetooth" = {
		format = "󰂯";
		format-disabled = "󰂲";
		format-connected = "󰂱 {num_connections}";
		tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
		tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
		tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
		on-click = "bluetooth toggle";
	};
	"battery" = {
		full-at = 95;
		states = {
			warning = 35;
			critical = 10;
		};
		format = "{icon} {capacity}%";
		format-plugged = "";
		format-charging = "󰂄";
		format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
	};
	"pulseaudio" = {
		format = "{icon}  {volume}%";
		format-muted = "󰝟 0%";
		on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
		on-click-right = "pavucontrol";
		on-scroll-up = "wpctl set-volume -l 1.3 @DEFAULT_SINK@ 5%+";
		on-scroll-down = "wpctl set-volume @DEFAULT_SINK@ 5%-";
		scroll-step = 5;
		format-icons = {
			headphone = "󱡏";
			hands-free = "󱡏";
			headset = "󱡏";
			default = [ "" "" ];
		};
	};
	"clock" = {
		format = "{:%H:%M %a}";
		tooltip-format = "{calendar}";
		calendar = {
			format = {
				months = "<span color='#D3D04F'><b>{}</b></span>";
				days = "<span color='#93B1A6'><b>{}</b></span>";
				weekdays = "<span color='#8EAC50'><b>{}</b></span>";
				today = "<span color='#8EAC50'><b><u>{}</u></b></span>";
			};
		};
	};
	"backlight" = {
		device = "intel_backlight";
		format = "{icon} {percent}%";
		format-icons = [ "󰃞" "󰃟" "󰃠" ];
		on-scroll-up = "brightnessctl set 10%+";
		on-scroll-down = "brightnessctl set 10%-";
		min-length = 6;
	};
	"pulseaudio#microphone" = {
		format = "{format_source}";
		format-source = " {volume}%";
		format-source-muted = " Muted";
		on-click = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
		on-click-right = "pavucontrol";
		on-scroll-up = "wpctl set-volume -l 1.3 @DEFAULT_SOURCE@ 5%+";
		on-scroll-down = "wpctl set-volume -l 1.3 @DEFAULT_SOURCE@ 5%-";
		scroll-step = 5;
	};
	"custom/nowplaying" = {
		format = "{}";
		exec = "~/nix-config/modules/waybar/scripts/nowplaying.sh";
		interval = 2;
	};
    };
  };

  programs.waybar.style = ''
    * {
        font-family: "JetBrainsMono Nerd Font, monospace, sans-serif";
        font-weight: bold;
        font-size: 16px;
    }
    
    window#waybar {
        border-radius: 10px;
        background: #151515;
        color: #A09294;
    }
    
    tooltip {
        background: #151515;
        border-radius: 8px;
    }
    
    tooltip label {
        color: #818086;
    }
    
    #workspaces {
        border-radius: 16px 24px 24px 16px;
        margin: 0;
        color: #C6BEBF;
        padding: 0px 14px;
    }
    
    #workspaces button {
        min-width: 28px;
        border-radius: 20px;
        margin: 8px 0;
    }
    
    #workspaces button:not(:last-child) {
        margin-right: 4px;
    }
    
    #workspaces button:hover {
    	box-shadow: none;
    	background: #80281B;
    	border: none;
    	color: #C6BEBF;
    }
    
    #workspaces button.active {
        background: #D57C39;
        color: #C6BEBF;
    }
    
    #clock,
    #battery,
    #pulseaudio,
    #network,
    #bluetooth,
    #temperature,
    #backlight {
        padding: 0px 14px;
        color: #6F6F78;
    }
    
    #tray {
        padding: 0px 16px;
    }
    
    #network {
        border-radius: 24px 0 0 24px;
        padding-left: 24px;
    }
    
    #battery.warning {
        color: orange;
    }
    
    #battery.critical {
        color: red;
    }
    
    #temperature.critical {
        color: red;
    }
    
    #clock {
        padding-right: 16px;
        border-radius: 0 16px 16px 0;
    }
  '';
}
