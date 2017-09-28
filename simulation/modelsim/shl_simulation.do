onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /shl_tb/SHLsel_tb
add wave -noupdate /shl_tb/PCout_tb
add wave -noupdate /shl_tb/MDRout_tb
add wave -noupdate /shl_tb/read_tb
add wave -noupdate /shl_tb/Zlowout_tb
add wave -noupdate /shl_tb/IncPC_tb
add wave -noupdate /shl_tb/R0out_tb
add wave -noupdate /shl_tb/R3out_tb
add wave -noupdate /shl_tb/R5out_tb
add wave -noupdate /shl_tb/Yin_tb
add wave -noupdate /shl_tb/Zin_tb
add wave -noupdate /shl_tb/IRin_tb
add wave -noupdate /shl_tb/R0in_tb
add wave -noupdate /shl_tb/R3in_tb
add wave -noupdate /shl_tb/R5in_tb
add wave -noupdate /shl_tb/MDRin_tb
add wave -noupdate /shl_tb/MARin_tb
add wave -noupdate /shl_tb/PCin_tb
add wave -noupdate /shl_tb/Mdatain_tb
add wave -noupdate /shl_tb/BusMuxOut
add wave -noupdate /shl_tb/MDRValue
add wave -noupdate /shl_tb/R0Value
add wave -noupdate /shl_tb/R3Value
add wave -noupdate /shl_tb/R5Value
add wave -noupdate /shl_tb/ZLoValue
add wave -noupdate /shl_tb/YValue
add wave -noupdate /shl_tb/PCValue
add wave -noupdate /shl_tb/IRValue
add wave -noupdate /shl_tb/ZHiValue
add wave -noupdate /shl_tb/Clock_tb
add wave -noupdate /shl_tb/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {399855 ps} 0}
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
