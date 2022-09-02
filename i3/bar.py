# -*- coding: utf-8 -*-

###
# Dependencies:
#
# i3pystatus
# netifaces
# colour

import socket

from i3pystatus import Status

hostname = socket.gethostname()
status = Status(standalone=True, logfile='/home/kyrias/.cache/i3pystatus.log')

font_feature_template='''<span font_features="zero, ss01, tnum">{}</span>'''

status.register("clock",
                color="#CDC0B0",
                format=font_feature_template.format('%Y-%m-%d %H:%M:%S%z'),
                hints={"markup": "pango"})


if hostname == "hydrogen.kyriasis.com":
    status.register("battery",
                    color="#CDC0B0",
                    full_color="#7CFC00",
                    charging_color="#7CFC00",
                    critical_color="#EE4000",
                    format=font_feature_template.format('⚡0 {percentage:.2f}% {remaining:%E%hh:%Mm}{status}'),
                    alert=True,
                    alert_percentage=5,
                    status={
                        "DIS": "↓",
                        "CHR": "↑",
                        "FULL": "=",
                    },
                    battery_ident="BAT0",
                    hints={"markup": "pango"})

    status.register("battery",
                    color="#CDC0B0",
                    full_color="#7CFC00",
                    charging_color="#7CFC00",
                    critical_color="#EE4000",
                    format=font_feature_template.format('⚡1 {percentage:.2f}% {remaining:%E%hh:%Mm}{status}'),
                    alert=True,
                    alert_percentage=5,
                    status={
                        "DIS": "↓",
                        "CHR": "↑",
                        "FULL": "=",
                    },
                    battery_ident="BAT1",
                    hints={"markup": "pango"})

elif hostname.startswith("lithium"):
    status.register("battery",
                    color="#CDC0B0",
                    full_color="#7CFC00",
                    charging_color="#7CFC00",
                    critical_color="#EE4000",
                    format="⚡0 {percentage:.2f}% {remaining:%E%hh:%Mm}{status}",
                    alert=True,
                    alert_percentage=5,
                    status={
                        "DIS": "↓",
                        "CHR": "↑",
                        "FULL": "=",
                    },
                    battery_ident="BAT0",)

    status.register("battery",
                    color="#CDC0B0",
                    full_color="#7CFC00",
                    charging_color="#7CFC00",
                    critical_color="#EE4000",
                    format="⚡1 {percentage:.2f}% {remaining:%E%hh:%Mm}{status}",
                    alert=True,
                    alert_percentage=5,
                    status={
                        "DIS": "↓",
                        "CHR": "↑",
                        "FULL": "=",
                    },
                    battery_ident="BAT1",)

else:
    status.register("battery",
                    color="#CDC0B0",
                    full_color="#7CFC00",
                    charging_color="#7CFC00",
                    critical_color="#EE4000",
                    format="⚡ {percentage:.2f}% {remaining:%E%hh:%Mm}{status}",
                    alert=True,
                    alert_percentage=5,
                    status={
                        "DIS": "↓",
                        "CHR": "↑",
                        "FULL": "=",
                    },
                    battery_ident="BAT0",)


status.register("temp",
                color="#CDC0B0",
                format=font_feature_template.format("{Package_id_0}°C {Core_0_bar}{Core_1_bar}"),
                hints={"markup": "pango"},
                lm_sensors_enabled=True)


status.register("pulseaudio",
                color_unmuted="#CDC0B0",
                color_muted="#EE4000",
                format=font_feature_template.format("♪ {volume}%"),
                hints={"markup": "pango"})


status.register("backlight",
                color="#CDC0B0",
                backlight="intel_backlight",
                format=font_feature_template.format("🔆 {percentage}%"),
                hints={"markup": "pango"})


if hostname == "zorg.kyriasis.com":
    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="wlp4s0",
                    format_up="{essid:.10s}: {v4cidr} {quality:3.0f}%",)

    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="enp0s25",
                    format_up="{interface}: {v4cidr}")

elif hostname == "tirxu.kyriasis.com":
    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="wlp4s0",
                    format_up="{essid:.10s}: {v4cidr} {quality:3.0f}%",)

    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="enp0s20u3u1u3",
                    format_up="{interface}: {v4cidr}")

elif hostname == "hydrogen.kyriasis.com":
    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="wlan0",
                    format_up=font_feature_template.format("{essid:.10s}: {v4cidr} {quality:3.0f}%"),
                    format_down=font_feature_template.format("{interface}: DOWN"),
                    hints={"markup": "pango"})

    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="enp0s31f6",
                    format_up=font_feature_template.format("{interface}: {v4cidr}"),
                    format_down=font_feature_template.format("{interface}: DOWN"),
                    hints={"markup": "pango"})

elif hostname.startswith('lithium'):
    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="wlp3s0",
                    format_up="{essid:.10s}: {v4cidr} {quality:3.0f}%",)

    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="enp0s31f6",
                    format_up="{interface}: {v4cidr}")


status.register("disk",
                color="#CDC0B0",
                path="/boot",
                divisor=1024**2,
                format=font_feature_template.format("/boot {avail}M"),
                hints={"markup": "pango"})

status.register("disk",
                color="#CDC0B0",
                path="/",
                format=font_feature_template.format("/ {avail}G"),
                hints={"markup": "pango"})


status.run()
