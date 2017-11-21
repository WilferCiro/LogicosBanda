transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/usart_t.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/suma.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/usart_pkg.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/repartidor.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/reg1bit.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/habilitador.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/guarda_reparticion.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/contadorUSART.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/PWM.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/Maquina.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/contador.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/componentes_pkg.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/preescalar_reloj.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/USART.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/corrimiento_registros.vhd}
vcom -93 -work work {/home/ciro/Documents/universidad/semestre5/logicos/Laboratorios/ProyectoFinalCasiquenoEsteSi/ProyectoFinalCasiquenoEsteSi.vhd}



vsim -t ns ProyectoFinalCasiquenoEsteSi

add wave not_s1
add wave not_s2
add wave s3
add wave s5
add wave x
add wave motor_banda
add wave motor_brazo
add wave motor_garra
add wave motor_giro
add wave actual_estado
add wave cuanto_cuenta
add wave nuevo_x
add wave salida_usb
add wave ENVIO_B1
add wave ENVIO_B2
add wave ENVIO_B3
add wave B4
add wave entrada_usb

property wave -radix unsigned actual_estado
property wave -radix unsigned motor_brazo
property wave -radix unsigned motor_garra
property wave -radix unsigned motor_giro
property wave -radix unsigned cuanto_cuenta
property wave -radix unsigned ENVIO_B1
property wave -radix unsigned ENVIO_B2
property wave -radix unsigned ENVIO_B3
property wave -radix unsigned B4

force reset_n 0

force not_s1 1
force not_s2 1
force s3 1
force s5 0
force x 0
force SC 10
force entrada_usb 1
run 1us
force reset_n 1
force -freeze sim:/ProyectoFinalCasiquenoEsteSi/clk 1 0, 0 {10 ns} -r 20


run 10ms
force not_s1 0
run 20ms
force x 1
run 1ms
force x 0
run 1ms
force x 1
run 1ms
force x 0
run 1ms
force x 1
run 1ms
force x 0
run 1ms
force not_s1 1
run 10ms


force not_s2 0
run 10ms
force s3 0
run 5ms
force s5 1
run 100us
force s5 0
force not_s2 1
run 10ms
force s3 1
run 10ms
run 168us
run 100 us
run 10ms




force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms


force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 10ms




force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms


force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms




run 10ms
force not_s1 0
run 20ms
force not_s1 1
run 10ms
force not_s2 0
run 10ms
force s3 0
run 5ms
force s5 1
run 100us
force s5 0
force not_s2 1
run 10ms
force s3 1
run 10ms
run 168us
run 100 us
run 10ms




force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 1ms


force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 1ms




run 10ms
force not_s1 0
run 20ms
force not_s1 1
run 10ms
force not_s2 0
run 10ms
force s3 0
run 5ms
force s5 1
run 100us
force s5 0
force not_s2 1
run 10ms
force s3 1
run 10ms
run 168us
run 100 us
run 10ms





force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 1ms


force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 1
run 1ms



force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 0
run 104us
force entrada_usb 1
run 1ms

run 10ms
force not_s1 0
run 20ms
force not_s1 1
run 10ms
force not_s2 0
run 10ms
force s3 0
run 5ms
force s5 1
run 100us
force s5 0
force not_s2 1
run 10ms
force s3 1
run 10ms
run 168us
run 100 us
run 10ms

