PFX=ip/oled
SRC=spi.sv delayTimer.sv spi_controller.sv interpreter.sv oledDriver.sv
TEST=spi_listener.sv 


all: oled_demo_test

oledDriver_test: $(PFX)/tests/oledDriver_test.sv $(patsubst %, $(PFX)/src/%, $(SRC)) $(patsubst %, $(PFX)/tests/%, $(TEST)) 
	xvlog --sv $^
	xelab -debug typical $@ -s sim 
	xsim --R $(ARGS) sim

oled_demo_test: src/oled_demo.sv tests/oled_demo_test.sv $(patsubst %, $(PFX)/src/%, $(SRC)) $(patsubst %, $(PFX)/tests/%, $(TEST)) 
	xvlog --sv $^
	xelab -debug typical $@ -s sim 
	xsim --R $(ARGS) sim


implement:
	vivado -mode batch -source build.tcl


readme.html: readme.md
	pandoc $^ -s -o readme.html


.PHONY: oled_demo_test oledDriver_test implement

clean:
	rm -f *~
	rm -f webtalk*
	rm -f *.log
	rm -f post_*
	rm -f *.jou
