.PHONY: build run release app clean

build:
	swift build

run:
	swift run KEFControl

release:
	swift build -c release

app: release
	rm -rf KEFControl.app
	mkdir -p KEFControl.app/Contents/MacOS
	cp Sources/KEFControl/Info.plist KEFControl.app/Contents/
	cp "$$(swift build -c release --show-bin-path)/KEFControl" KEFControl.app/Contents/MacOS/
	codesign --force --sign - --deep KEFControl.app
	@echo "Built KEFControl.app"

clean:
	swift package clean
	rm -rf KEFControl.app
