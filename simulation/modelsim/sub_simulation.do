onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sub_tb/SUBsel_tb
add wave -noupdate /sub_tb/PCout_tb
add wave -noupdate /sub_tb/MDRout_tb
add wave -noupdate /sub_tb/read_tb
add wave -noupdate /sub_tb/Zlowout_tb
add wave -noupdate /sub_tb/IncPC_tb
add wave -noupdate /sub_tb/R0out_tb
add wave -noupdate /sub_tb/R4out_tb
add wave -noupdate /sub_tb/R5out_tb
add wave -noupdate /sub_tb/Yin_tb
add wave -noupdate /sub_tb/Zin_tb
add wave -noupdate /sub_tb/IRin_tb
add wave -noupdate /sub_tb/R0in_tb
add wave -noupdate /sub_tb/R4in_tb
add wave -noupdate /sub_tb/R5in_tb
add wave -noupdate /sub_tb/MDRin_tb
add wave -noupdate /sub_tb/MARin_tb
add wave -noupdate /sub_tb/PCin_tb
add wave -noupdate -radix decimal /sub_tb/Mdatain_tb
add wave -noupdate -radix decimal /sub_tb/BusMuxOut
add wave -noupdate -radix decimal /sub_tb/MDRValue
add wave -noupdate -radix decimal /sub_tb/R0Value
add wave -noupdate -radix decimal /sub_tb/R4Value
add wave -noupdate -radix decimal /sub_tb/R5Value
add wave -noupdate -radix decimal /sub_tb/ZLoValue
add wave -noupdate -radix decimal /sub_tb/YValue
add wave -noupdate -radix decimal /sub_tb/PCValue
add wave -noupdate -radix decimal /sub_tb/IRValue
add wave -noupdate -radix decimal /sub_tb/ZHiValue
add wave -noupdate /sub_tb/Clock_tb
add wave -noupdate /sub_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {166002 ps} 0}
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
