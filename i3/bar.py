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
                format="%y-%m-%d %H:%M:%S%z",)


if hostname == "hydrogen.kyriasis.com":
    status.register("battery",
                    format="⚡0: {percentage:.2f}% {remaining:%E%hh:%Mm}{status}",
                    alert=True,
                    alert_percentage=5,
                    status={
                        "DIS": "↓",
                        "CHR": "↑",
                        "FULL": "=",
                    },
                    battery_ident="BAT0",)

    status.register("battery",
                    format="⚡1: {percentage:.2f}% {remaining:%E%hh:%Mm}{status}",
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
                    format="⚡:{percentage:.2f}% {remaining:%E%hh:%Mm}{status}",
                    alert=True,
                    alert_percentage=5,
                    status={
                        "DIS": "↓",
                        "CHR": "↑",
                        "FULL": "=",
                    },
                    battery_ident="BAT0",)


status.register("temp",
                format="{Package_id_0}°C {Core_0_bar}{Core_1_bar}",
                hints={"markup": "pango"},
                lm_sensors_enabled=True)


status.register("pulseaudio",
                format="♪:{volume}%",)


status.register("backlight",
                backlight="intel_backlight",
                format="🔆: {percentage}% ({brightness}/{max_brightness})")


if hostname == "zorg.kyriasis.com":
    status.register("network",
                    interface="wlp4s0",
                    format_up="{essid:.10s}: {v4cidr} {quality:3.0f}%",)

    status.register("network",
                    interface="enp0s25",
                    format_up="{interface}: {v4cidr}")

elif hostname == "tirxu.kyriasis.com":
    status.register("network",
                    interface="wlp4s0",
                    format_up="{essid:.10s}: {v4cidr} {quality:3.0f}%",)

    status.register("network",
                    interface="enp0s20u3u1u3",
                    format_up="{interface}: {v4cidr}")

elif hostname == "hydrogen.kyriasis.com":
    status.register("network",
                    interface="wlp4s0",
                    format_up="{essid:.10s}: {v4cidr} {quality:3.0f}%",)

    status.register("network",
                    interface="enp0s31f6",
                    format_up="{interface}: {v4cidr}")


status.register("disk",
                path="/boot",
                divisor=1024**2,
                format="/boot: {avail}M",)

status.register("disk",
                path="/",
                format="/: {avail}G",)


status.run()
