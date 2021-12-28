install: ni
	@test -f /usr/bin/ni && sudo rm /usr/bin/ni || continue
	sudo cp -r ./ni /usr/bin/ni
	chmod +x /usr/bin/ni
	@echo "Done!"

uninstall:
	@test -f /usr/bin/ni && sudo rm /usr/bin/ni || echo "ni isn't installed"
	@echo "Done!"
