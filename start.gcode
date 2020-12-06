M104 S[first_layer_temperature] ; set extruder temp
M140 S[first_layer_bed_temperature] ; set bed temp
M190 S[first_layer_bed_temperature] ; wait for bed temp
M109 S[first_layer_temperature] ; wait for extruder temp
G28; home all after heating up
G29; auto bed leveling
; WIPE NOZZLE ;
G1 X28 Y3.0 F4000 ; move to corner of bed
G1 Z0.3
G92 E0 ;zero the extruded length
G1 X68.0 E12.5 F500.0; purge line
G1 X108 E7.5 F500.0; purge line 2
G1 E-1.6 F1800; retract 0.8 at 30mms
G1 X160 F4000; Quickly wipe away from filament line
G1 E1.8 F1800; deretract
G92 E0 ;zero the extruded length



;G1 Z0.15; move to print position
;G92 E0 ;zero the extruded length
;G1 X90 E15 F500 ;move x 40mm
;G1 E-0.03 F500 ; Retract a little
;G1 X110 F4000; Quickly wipe away from filament line
;G92 E0 ;zero the extruded length
;G1 Z3.4
