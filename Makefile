help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

generate-theme: 
	pnpm -C ./lib/theme/theme_generator run start

run:
	fvm flutter run -d chrome

build-runner:
	fvm flutter packages pub run build_runner build