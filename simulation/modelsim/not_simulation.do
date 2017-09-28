onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /not_tb/NOTsel_tb
add wave -noupdate /not_tb/PCout_tb
add wave -noupdate /not_tb/MDRout_tb
add wave -noupdate /not_tb/read_tb
add wave -noupdate /not_tb/Zlowout_tb
add wave -noupdate /not_tb/IncPC_tb
add wave -noupdate /not_tb/R1out_tb
add wave -noupdate /not_tb/R2out_tb
add wave -noupdate /not_tb/Yin_tb
add wave -noupdate /not_tb/Zin_tb
add wave -noupdate /not_tb/IRin_tb
add wave -noupdate /not_tb/R1in_tb
add wave -noupdate /not_tb/R2in_tb
add wave -noupdate /not_tb/MDRin_tb
add wave -noupdate /not_tb/MARin_tb
add wave -noupdate /not_tb/PCin_tb
add wave -noupdate /not_tb/Mdatain_tb
add wave -noupdate /not_tb/BusMuxOut
add wave -noupdate /not_tb/MDRValue
add wave -noupdate /not_tb/R1Value
add wave -noupdate /not_tb/R2Value
add wave -noupdate /not_tb/ZLoValue
add wave -noupdate /not_tb/YValue
add wave -noupdate /not_tb/PCValue
add wave -noupdate /not_tb/IRValue
add wave -noupdate /not_tb/ZHiValue
add wave -noupdate /not_tb/Clock_tb
add wave -noupdate /not_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {381022 ps} 0}
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
WaveRestoreZoom {0 ps} {301056 ps}
