#!/bin/sh
sleep 1
ac=0
for p in /sys/class/power_supply/*; do
  [ "$(cat $p/type 2>/dev/null)" = "Mains" ] && [ "$(cat $p/online 2>/dev/null)" = "1" ] && ac=1
done
if [ "$ac" = "1" ]; then
  for c in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo performance > "$c"; done
  asusctl profile set Performance >/dev/null 2>&1
  mode="TURBO (charging)"
else
  for c in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo powersave > "$c"; done
  for e in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do echo balance_performance > "$e"; done
  asusctl profile set Balanced >/dev/null 2>&1
  mode="BALANCED (battery)"
fi
[ -w /sys/devices/system/cpu/intel_pstate/no_turbo ] && echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo
logger -t power-mode "$mode"
exit 0
