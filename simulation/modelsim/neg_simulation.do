onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /neg_tb/NEGsel_tb
add wave -noupdate /neg_tb/PCout_tb
add wave -noupdate /neg_tb/MDRout_tb
add wave -noupdate /neg_tb/read_tb
add wave -noupdate /neg_tb/Zlowout_tb
add wave -noupdate /neg_tb/IncPC_tb
add wave -noupdate /neg_tb/R1out_tb
add wave -noupdate /neg_tb/R2out_tb
add wave -noupdate /neg_tb/Yin_tb
add wave -noupdate /neg_tb/Zin_tb
add wave -noupdate /neg_tb/IRin_tb
add wave -noupdate /neg_tb/R1in_tb
add wave -noupdate /neg_tb/R2in_tb
add wave -noupdate /neg_tb/MDRin_tb
add wave -noupdate /neg_tb/MARin_tb
add wave -noupdate /neg_tb/PCin_tb
add wave -noupdate /neg_tb/Mdatain_tb
add wave -noupdate /neg_tb/BusMuxOut
add wave -noupdate /neg_tb/MDRValue
add wave -noupdate -radix decimal /neg_tb/R1Value
add wave -noupdate -radix decimal /neg_tb/R2Value
add wave -noupdate /neg_tb/ZLoValue
add wave -noupdate /neg_tb/YValue
add wave -noupdate /neg_tb/PCValue
add wave -noupdate /neg_tb/IRValue
add wave -noupdate /neg_tb/ZHiValue
add wave -noupdate /neg_tb/Clock_tb
add wave -noupdate /neg_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {403763 ps} 0}
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
WaveRestoreZoom {113997 ps} {415053 ps}
