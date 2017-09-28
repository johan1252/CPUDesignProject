onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /and_tb/ANDsel_tb
add wave -noupdate /and_tb/PCout_tb
add wave -noupdate /and_tb/MDRout_tb
add wave -noupdate /and_tb/read_tb
add wave -noupdate /and_tb/Zlowout_tb
add wave -noupdate /and_tb/IncPC_tb
add wave -noupdate /and_tb/R2out_tb
add wave -noupdate /and_tb/R3out_tb
add wave -noupdate /and_tb/R6out_tb
add wave -noupdate /and_tb/Yin_tb
add wave -noupdate /and_tb/Zin_tb
add wave -noupdate /and_tb/IRin_tb
add wave -noupdate /and_tb/R2in_tb
add wave -noupdate /and_tb/R3in_tb
add wave -noupdate /and_tb/R6in_tb
add wave -noupdate /and_tb/MDRin_tb
add wave -noupdate /and_tb/MARin_tb
add wave -noupdate /and_tb/PCin_tb
add wave -noupdate /and_tb/Mdatain_tb
add wave -noupdate /and_tb/BusMuxOut
add wave -noupdate /and_tb/MDRValue
add wave -noupdate /and_tb/R2Value
add wave -noupdate /and_tb/R3Value
add wave -noupdate /and_tb/R6Value
add wave -noupdate /and_tb/ZLoValue
add wave -noupdate /and_tb/YValue
add wave -noupdate -radix decimal /and_tb/PCValue
add wave -noupdate /and_tb/IRValue
add wave -noupdate /and_tb/ZHiValue
add wave -noupdate /and_tb/Clock_tb
add wave -noupdate /and_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {400227 ps} 0}
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
