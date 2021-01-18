package game.states;

class MultiSplashState extends FlxState {
	public var splashScreens:Array<Splash>;
	public var delayTime:Float;
	public var screenIndex:Int;
	public var splashScreenSprite:FlxSprite;

	public function new(screens:Array<Splash>) {
		splashScreens = screens;
		screenIndex = 0;
		super();
	}

	override public function create() {
		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateSplashScreen(elapsed);
	}

	public function updateSplashScreen(elapsed:Float) {
		var currentScreen = splashScreens[screenIndex];
		if (currentScreen != null) {
			switch (currentScreen) {
				case Delay(_, seconds):
					delayTime += elapsed;
					if (delayTime >= seconds) {
						transitionScreen();
					}
				case Click(_):
					if (FlxG.mouse.justPressed) {
						transitionScreen();
					}
				case ClickDelay(_, seconds):
					delayTime += elapsed;
					if (FlxG.mouse.justPressed || delayTime >= seconds) {
						transitionScreen();
					}
			}
		}
	}

	public function transitionScreen() {
		screenIndex++;
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			FlxG.camera.fade(KColor.BLACK, 1, true);
			// Change Screen at this point
			var currentScreen = splashScreens[screenIndex];
			loadGraphic(currentScreen);
			if (screenIndex == splashScreens.length) {
				// GoTo Title Screen once splashes are done
				FlxG.switchState(new TitleState());
			}
		});
	}

	public function loadGraphic(screen:Splash) {
		switch (screen) {
			case Delay(imageName, seconds):
				splashScreenSprite.loadGraphic(imageName, false, FlxG.width,
					FlxG.height);
			case Click(imageName):
				splashScreenSprite.loadGraphic(imageName, false, FlxG.width,
					FlxG.height);
			case ClickDelay(imageName, seconds):
				splashScreenSprite.loadGraphic(imageName, false, FlxG.width,
					FlxG.height);
		}
	}
}