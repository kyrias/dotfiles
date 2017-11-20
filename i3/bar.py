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
status = Status(standalone=True)


status.register("clock",
                color="#CDC0B0",
                format="%y-%m-%d %H:%M:%S%z")


if hostname == "hydrogen.kyriasis.com":
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
                format="{Package_id_0}°C {Core_0_bar}{Core_1_bar}",
                hints={"markup": "pango"},
                lm_sensors_enabled=True)


status.register("pulseaudio",
                color_unmuted="#CDC0B0",
                color_muted="#EE4000",
                format="♪ {volume}%",)


status.register("backlight",
                color="#CDC0B0",
                backlight="intel_backlight",
                format="🔆 {percentage}% ({brightness}/{max_brightness})")


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
                    interface="wlp4s0",
                    format_up="{essid:.10s}: {v4cidr} {quality:3.0f}%",)

    status.register("network",
                    color_up="#7CFC00",
                    color_down="#EE4000",
                    interface="enp0s31f6",
                    format_up="{interface}: {v4cidr}")

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
                format="/boot {avail}M",)

status.register("disk",
                color="#CDC0B0",
                path="/",
                format="/ {avail}G",)


status.run()
