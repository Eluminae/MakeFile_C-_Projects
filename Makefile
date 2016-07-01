# Declaration of variables
CC = g++
CC_FLAGS = -w

# File names
EXEC = run
SRC = ./src/
OBJ = ./o/
SOURCES = $(wildcard $(SRC)*.cpp)
OBJECTS = $(SOURCES:$(SRC)%.cpp=$(OBJ)%.o)

# Main target
$(EXEC): $(OBJECTS)
		$(CC) $(OBJECTS) -o $(EXEC)

# To obtain object files
$(OBJ)%.o: $(SRC)%.cpp
		$(CC) -c $(CC_FLAGS) $< -o $@

# To remove generated files
clean:
		rm -f $(EXEC) $(OBJECTS)
