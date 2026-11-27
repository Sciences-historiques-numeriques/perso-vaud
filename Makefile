SQLITE := sqlite/persovd.db
ERD    := $(SQLITE:.db=.png)
OBJS   := $(SQLITE) $(ERD)

all: $(OBJS)

# We use SQLite3 for a temporary database.
$(SQLITE): $(wildcard sqlite/create/*.sql)
	rm -f $@
	cat $^ | sqlite3 -bail -batch -nofollow $@

# Generate diagram from database schema.
# TODO: pick a tool that generate many-to-many relations.
%.png: %.db
	eralchemy -i sqlite:///$< -o $@ | dot -Png > $@

# Force the re-creation of the database.
sqlite:
	rm -f $(SQLITE)
	$(MAKE) $(SQLITE)
	$(MAKE) $(ERD)
	xdg-open $(ERD) &

# Generate image from drawio diagram.
%.png %.jpg %.jpeg: %.drawio
	drawio -x -f png --scale 2.5 -o $@ $<
%.png %.jpg %.jpeg: %.svg
	drawio -x -f png --scale 2.5 -o $@ $<
%.png: %.dot
	dot -Tpng $< > $@

.PHONY: all sqlite install uninstall clean
