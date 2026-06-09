
#
set part	"XC2V3000"
set speed_grade	"4"
set package	"FG676"

set entity	xc_led_ila

exec ngdbuild -p $part-$speed_grade-$package -uc xc_led.ucf $entity.ngo
exec map $entity
exec par -ol 5 -w $entity $entity
exec bitgen -m -w -g StartupClk:Jtagclk $entity $entity

