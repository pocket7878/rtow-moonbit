build:
	moon build
run:
	moon run --target native ./src/main > ./image.ppm
view:
	open ./image.ppm
