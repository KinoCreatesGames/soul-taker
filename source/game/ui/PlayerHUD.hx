package game.ui;

class PlayerHUD extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var dayCounter:FlxText;
	public var days:Int;

	public static inline var WIDTH:Float = 864;
	public static inline var HEIGHT:Float = 150;

	public function new(x:Float, y:Float) {
		super();
		position = new FlxPoint(x, y);
		days = 0;
		create();
	}

	public function create() {
		createBackground(position);
		createDayCounter(position);
	}

	public function createBackground(position:FlxPoint) {}

	public function createDayCounter(position:FlxPoint) {
		var x = WIDTH - 300;
		var y = 0;
		dayCounter = new FlxText(x, y, 300, 'Days: ${days}',
			Globals.FONT_SUB_H);
		add(dayCounter);
	}

	public function setDays(days:Int) {
		dayCounter.text = 'Days: ${days}';
	}
}