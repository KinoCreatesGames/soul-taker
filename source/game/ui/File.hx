package game.ui;

class File extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var saveID:Int;
	public var gameTime:Int;
	public var realTime:Int;
	public var saveIDText:FlxText;
	public var gameTimeText:FlxText;
	public var realTimeText:FlxText;

	public static inline var WIDTH:Int = 400;
	public static inline var HEIGHT:Int = 75;
	public static inline var BGCOLOR:Int = KColor.RICH_BLACK_FORGRA;
	public static inline var BORDERSIZE:Int = 4;

	public function new(id:Int, x:Float, y:Float) {
		super();
		saveID = id;
		position = new FlxPoint(x, y);
		create();
	}

	public function create() {
		createBackground(position);
		createText(position);
	}

	public function createBackground(position:FlxPoint) {
		background = new FlxSprite(position.x, position.y);
		background.makeGraphic(WIDTH, HEIGHT, BGCOLOR);

		background.drawRect(0, 0, WIDTH, HEIGHT, KColor.SNOW);
		background.drawRect(BORDERSIZE, BORDERSIZE, WIDTH - BORDERSIZE * 2,
			HEIGHT - BORDERSIZE * 2, BGCOLOR);
		add(background);
	}

	public function createText(position:FlxPoint) {
		// Create Text Options
		var x = position.x;
		var y = position.y;
		var padding = 12;
		// Save ID
		saveIDText = new FlxText(x + padding, y + padding, 50, '${saveID}',
			Globals.FONT_N);

		add(saveIDText);
		// Game Time
		gameTimeText = new FlxText(x + padding,
			(y + HEIGHT) - (padding + Globals.FONT_N), WIDTH / 3,
			gameFormatTime(), Globals.FONT_N);

		add(gameTimeText);

		var realTimeWidth = WIDTH / 3;
		// Real Time
		realTimeText = new FlxText((x + WIDTH) - realTimeWidth, y + padding,
			realTimeWidth, realFormatTime(), Globals.FONT_N);
		add(realTimeText);
	}

	public function gameFormatTime():String {
		return 'Play Time: ${gameTime}';
	}

	public function realFormatTime():String {
		return 'Time ${realTime}';
	}

	public function setId(id:Int) {
		saveID = id;
		updateSaveText();
	}

	public function updateSaveText() {
		gameTimeText.text = gameFormatTime();
		realTimeText.text = realFormatTime();
	}
}