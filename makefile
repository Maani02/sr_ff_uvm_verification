compile:
	vlib work;
	vlog -sv \
	+acc \
	+cover \
	+fcover \
	-l covtest.log \
	-f compile.f

simulate:
	vsim \
	work.top \
	-voptargs=+acc=npr \
	-assertdebug \
	-sva \
	-coverage \
	-c -do "log -r /*; coverage save -onexit -assert -directive -cvg -codeAll sr_ff_uvm_verification.ucdb; run -all;  exit" \
	-wlf waveform.wlf
	wlf2vcd -o waveform.vcd waveform.wlf
	vcover report -html sr_ff_uvm_verification.ucdb -htmldir html_cov_report -details
