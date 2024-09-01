SRCS   = $(shell find src/ -type f -name *.s)
BINS   = $(patsubst src/%.s, bin/%.bin, $(SRCS))
TARGET = bin/sos.img

all: $(TARGET)

$(TARGET): $(BINS)
	mkdir -p bin/; cp $< $@
	truncate --size 1440k $@

bin/%.bin: src/%.s
	mkdir -p bin/; nasm -fbin -o $@ $<

run: $(TARGET)
	qemu-system-x86_64 -fda $(TARGET)

clean:
	rm -rf bin/

.PHONY: all run clean