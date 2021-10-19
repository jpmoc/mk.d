_default_target:


push:
	cp ~/golden/* ./ 
	git add * 
	git commit -a -m "more"
	git push


pull:
	git pull
