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
