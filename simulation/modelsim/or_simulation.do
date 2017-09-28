onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /or_tb/ORsel_tb
add wave -noupdate /or_tb/PCout_tb
add wave -noupdate /or_tb/MDRout_tb
add wave -noupdate /or_tb/read_tb
add wave -noupdate /or_tb/Zlowout_tb
add wave -noupdate /or_tb/IncPC_tb
add wave -noupdate /or_tb/R0out_tb
add wave -noupdate /or_tb/R1out_tb
add wave -noupdate /or_tb/R7out_tb
add wave -noupdate /or_tb/Yin_tb
add wave -noupdate /or_tb/Zin_tb
add wave -noupdate /or_tb/IRin_tb
add wave -noupdate /or_tb/R0in_tb
add wave -noupdate /or_tb/R1in_tb
add wave -noupdate /or_tb/R7in_tb
add wave -noupdate /or_tb/MDRin_tb
add wave -noupdate /or_tb/MARin_tb
add wave -noupdate /or_tb/PCin_tb
add wave -noupdate /or_tb/Mdatain_tb
add wave -noupdate /or_tb/BusMuxOut
add wave -noupdate /or_tb/MDRValue
add wave -noupdate /or_tb/R0Value
add wave -noupdate /or_tb/R1Value
add wave -noupdate /or_tb/R7Value
add wave -noupdate /or_tb/ZLoValue
add wave -noupdate /or_tb/YValue
add wave -noupdate /or_tb/PCValue
add wave -noupdate /or_tb/IRValue
add wave -noupdate /or_tb/ZHiValue
add wave -noupdate /or_tb/Clock_tb
add wave -noupdate /or_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {270056 ps} 0}
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
WaveRestoreZoom {0 ps} {580864 ps}
