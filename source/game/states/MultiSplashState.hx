package game.states;

class MultiSplashState extends FlxState {
	public var splashScreens:Array<Splash>;

	public function new(screens:Array<Splash>) {
		splashScreens = screens;
		super();
	}

	override public function create() {
		super.create();
	}
}