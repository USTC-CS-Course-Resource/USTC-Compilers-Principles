# Usage:
# `gcc`, 32位: `make -B CC=gcc FLAGS=-m32`
# `gcc`, 64位: `make -B CC=gcc FLAGS=-m64`
# `clang`, 32位: `make -B CC=clang FLAGS=-m32`
# `clang`, 64位: `make -B CC=clang FLAGS=-m64`

CC=gcc
TARGET=sort
FLAGS=-m64

# Link
$(TARGET): $(TARGET).s
	$(CC) $(FLAGS) $^ -o $@
	
# Compile
$(TARGET).s: $(TARGET).i
	$(CC) $(FLAGS) -S $^

# Preprocess
$(TARGET).i: $(TARGET).c
	$(CC) $(FLAGS) -E $^ -o $@

.PHONY:clean
clean: 
	rm -f $(TARGET).s $(TARGET).i $(TARGET).o $(TARGET)
