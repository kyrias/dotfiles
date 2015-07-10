# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

status = Status(standalone=True)

status.register("clock",
    format="%y-%m-%d %H:%M:%S%z",)

status.register("battery",
    format="⚡:{percentage:.2f}% {remaining:%E%hh:%Mm}{status}",
    alert=True,
    alert_percentage=5,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    },
    battery_ident="BAT1",)


status.register("temp",
    format="{temp:.0f}°C",)

status.register("pulseaudio",
    format="♪:{volume}%",)

#status.register("mpd",
#    format="{status} {artist} > {title}",
#    status={
#        "pause": "✧",
#        "play": "▶",
#        "stop": "◾",
#    },)

status.register("network",
    interface="wlp3s0",
    format_up="{essid:.10s}: {v4cidr} {quality:3.0f}%",)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
    path="/media",
    format="{avail}G",)

status.register("disk",
    path="/",
    format="{avail}G",)



status.run()
