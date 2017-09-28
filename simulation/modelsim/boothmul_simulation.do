onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mulbooth_tb/BoothMULsel_tb
add wave -noupdate /mulbooth_tb/PCout_tb
add wave -noupdate /mulbooth_tb/MDRout_tb
add wave -noupdate /mulbooth_tb/read_tb
add wave -noupdate /mulbooth_tb/Zhighout_tb
add wave -noupdate /mulbooth_tb/Zlowout_tb
add wave -noupdate /mulbooth_tb/IncPC_tb
add wave -noupdate /mulbooth_tb/R5out_tb
add wave -noupdate /mulbooth_tb/R7out_tb
add wave -noupdate /mulbooth_tb/Yin_tb
add wave -noupdate /mulbooth_tb/Zin_tb
add wave -noupdate /mulbooth_tb/IRin_tb
add wave -noupdate /mulbooth_tb/R5in_tb
add wave -noupdate /mulbooth_tb/R7in_tb
add wave -noupdate /mulbooth_tb/MDRin_tb
add wave -noupdate /mulbooth_tb/MARin_tb
add wave -noupdate /mulbooth_tb/Hiin_tb
add wave -noupdate /mulbooth_tb/Loin_tb
add wave -noupdate /mulbooth_tb/PCin_tb
add wave -noupdate /mulbooth_tb/Mdatain_tb
add wave -noupdate /mulbooth_tb/BusMuxOut
add wave -noupdate /mulbooth_tb/MDRValue
add wave -noupdate /mulbooth_tb/R5Value
add wave -noupdate /mulbooth_tb/R7Value
add wave -noupdate /mulbooth_tb/ZLoValue
add wave -noupdate /mulbooth_tb/YValue
add wave -noupdate /mulbooth_tb/PCValue
add wave -noupdate /mulbooth_tb/IRValue
add wave -noupdate /mulbooth_tb/HIValue
add wave -noupdate /mulbooth_tb/LOValue
add wave -noupdate /mulbooth_tb/ZHiValue
add wave -noupdate /mulbooth_tb/Clock_tb
add wave -noupdate /mulbooth_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {399602 ps} 0}
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
WaveRestoreZoom {256998 ps} {407526 ps}
