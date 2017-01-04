CC = g++

SRCDIR = src
OBJDIR = o

SRCFILES = $(shell find $(SRCDIR) -name "*.cpp")
OBJFILES = $(SRCFILES:$(SRCDIR)%.cpp=$(OBJDIR)%.o)

EXEC = run
BINDIR = bin

$(shell mkdir -p $(BINDIR) `dirname $(OBJFILES)` >> /dev/null)

# Linker
$(EXEC): $(OBJFILES)
	$(CC) $? -o $(BINDIR)/$@

# Advanced dependencies building
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	$(CC) -MD -c -o $@ $<
	@cp $(OBJDIR)/$*.d $(OBJDIR)/$*.P; \
		sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(OBJDIR)/$*.d >> $(OBJDIR)/$*.P; \
		rm -f $(OBJDIR)/$*.d

-include $(shell find $(OBJDIR) -name "*.P")

print-%:
	@echo '$*=$($*)'
