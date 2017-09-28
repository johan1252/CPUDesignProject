onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /rol_tb/ROLsel_tb
add wave -noupdate /rol_tb/PCout_tb
add wave -noupdate /rol_tb/MDRout_tb
add wave -noupdate /rol_tb/read_tb
add wave -noupdate /rol_tb/Zlowout_tb
add wave -noupdate /rol_tb/IncPC_tb
add wave -noupdate /rol_tb/R0out_tb
add wave -noupdate /rol_tb/R1out_tb
add wave -noupdate /rol_tb/R4out_tb
add wave -noupdate /rol_tb/Yin_tb
add wave -noupdate /rol_tb/Zin_tb
add wave -noupdate /rol_tb/IRin_tb
add wave -noupdate /rol_tb/R0in_tb
add wave -noupdate /rol_tb/R1in_tb
add wave -noupdate /rol_tb/R4in_tb
add wave -noupdate /rol_tb/MDRin_tb
add wave -noupdate /rol_tb/MARin_tb
add wave -noupdate /rol_tb/PCin_tb
add wave -noupdate /rol_tb/Mdatain_tb
add wave -noupdate /rol_tb/BusMuxOut
add wave -noupdate /rol_tb/MDRValue
add wave -noupdate /rol_tb/R0Value
add wave -noupdate /rol_tb/R4Value
add wave -noupdate /rol_tb/ZLoValue
add wave -noupdate /rol_tb/YValue
add wave -noupdate /rol_tb/PCValue
add wave -noupdate /rol_tb/IRValue
add wave -noupdate /rol_tb/ZHiValue
add wave -noupdate /rol_tb/Clock_tb
add wave -noupdate /rol_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {398101 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {124090 ps} {414522 ps}
