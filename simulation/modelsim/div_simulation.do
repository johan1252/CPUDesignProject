onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /div_tb/DIVsel_tb
add wave -noupdate /div_tb/PCout_tb
add wave -noupdate /div_tb/MDRout_tb
add wave -noupdate /div_tb/read_tb
add wave -noupdate /div_tb/Zhighout_tb
add wave -noupdate /div_tb/Zlowout_tb
add wave -noupdate /div_tb/IncPC_tb
add wave -noupdate /div_tb/R1out_tb
add wave -noupdate /div_tb/R3out_tb
add wave -noupdate /div_tb/Yin_tb
add wave -noupdate /div_tb/Zin_tb
add wave -noupdate /div_tb/IRin_tb
add wave -noupdate /div_tb/R1in_tb
add wave -noupdate /div_tb/R3in_tb
add wave -noupdate /div_tb/MDRin_tb
add wave -noupdate /div_tb/MARin_tb
add wave -noupdate /div_tb/Hiin_tb
add wave -noupdate /div_tb/Loin_tb
add wave -noupdate /div_tb/PCin_tb
add wave -noupdate -radix decimal /div_tb/Mdatain_tb
add wave -noupdate -radix decimal /div_tb/BusMuxOut
add wave -noupdate -radix decimal /div_tb/MDRValue
add wave -noupdate -radix decimal /div_tb/R1Value
add wave -noupdate -radix decimal /div_tb/R3Value
add wave -noupdate -radix decimal /div_tb/ZLoValue
add wave -noupdate -radix decimal /div_tb/YValue
add wave -noupdate -radix decimal /div_tb/PCValue
add wave -noupdate -radix decimal /div_tb/IRValue
add wave -noupdate -radix decimal /div_tb/HIValue
add wave -noupdate -radix decimal /div_tb/LOValue
add wave -noupdate -radix decimal /div_tb/ZHiValue
add wave -noupdate /div_tb/Clock_tb
add wave -noupdate /div_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {267187 ps} 0}
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
WaveRestoreZoom {145216 ps} {435648 ps}
