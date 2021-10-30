_default_target:


push:
	rm *mk
	cp ~/golden/* ./ 
	git add * 
	git commit -a -m "more"
	git push


pull:
	git pull
