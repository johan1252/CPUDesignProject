onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mul_tb/MULsel_tb
add wave -noupdate /mul_tb/PCout_tb
add wave -noupdate /mul_tb/MDRout_tb
add wave -noupdate /mul_tb/read_tb
add wave -noupdate /mul_tb/Zhighout_tb
add wave -noupdate /mul_tb/Zlowout_tb
add wave -noupdate /mul_tb/IncPC_tb
add wave -noupdate /mul_tb/R5out_tb
add wave -noupdate /mul_tb/R7out_tb
add wave -noupdate /mul_tb/Yin_tb
add wave -noupdate /mul_tb/Zin_tb
add wave -noupdate /mul_tb/IRin_tb
add wave -noupdate /mul_tb/R5in_tb
add wave -noupdate /mul_tb/R7in_tb
add wave -noupdate /mul_tb/MDRin_tb
add wave -noupdate /mul_tb/MARin_tb
add wave -noupdate /mul_tb/Hiin_tb
add wave -noupdate /mul_tb/Loin_tb
add wave -noupdate /mul_tb/PCin_tb
add wave -noupdate /mul_tb/Mdatain_tb
add wave -noupdate /mul_tb/BusMuxOut
add wave -noupdate /mul_tb/MDRValue
add wave -noupdate /mul_tb/R5Value
add wave -noupdate /mul_tb/R7Value
add wave -noupdate /mul_tb/ZLoValue
add wave -noupdate /mul_tb/YValue
add wave -noupdate /mul_tb/PCValue
add wave -noupdate /mul_tb/IRValue
add wave -noupdate /mul_tb/HIValue
add wave -noupdate /mul_tb/LOValue
add wave -noupdate /mul_tb/ZHiValue
add wave -noupdate /mul_tb/Clock_tb
add wave -noupdate /mul_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {184003 ps} 0}
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
WaveRestoreZoom {0 ps} {555008 ps}
