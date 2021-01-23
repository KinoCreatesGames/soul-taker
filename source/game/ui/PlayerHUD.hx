package game.ui;

import game.chars.Gal;

/**
 * Contains all UI elements for player Information
 */
class PlayerHUD extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var dayCounter:FlxText;
	public var days:Int;
	public var happinessBar:FlxBar; // Add Sprite near end
	public var happinessIcon:FlxSprite;
	public var affectionSprite:FlxSprite;
	public var player:Gal;

	public static inline var WIDTH:Float = 864;
	public static inline var HEIGHT:Float = 150;

	public function new(x:Float, y:Float, gal:Gal) {
		super();
		player = gal;
		position = new FlxPoint(x, y);
		days = 0;
		create();
	}

	public function create() {
		createBackground(position);
		createDayCounter(position);
		createHappiness(position);
		createAffection(position);
	}

	public function createBackground(position:FlxPoint) {}

	public function createDayCounter(position:FlxPoint) {
		var x = WIDTH - 300;
		var y = 0;
		dayCounter = new FlxText(x, y, 300, 'Days: ${days}',
			Globals.FONT_SUB_H);
		add(dayCounter);
	}

	public function createHappiness(position:FlxPoint) {
		var padding = 48;
		var x = position.x + padding;
		var y = position.y + padding;
		var barWidth = 150;
		happinessBar = new FlxBar(x, y, LEFT_TO_RIGHT, barWidth, 25, player,
			'happiness', 0, 100, true);
		happinessBar.createColoredFilledBar(KColor.BURGUNDY, true, KColor.SNOW);

		happinessIcon = new FlxSprite(x + barWidth - 16, y);
		happinessIcon.makeGraphic(32, 32, KColor.PINK);

		add(happinessBar);
		add(happinessIcon);
	}

	public function createAffection(position:FlxPoint) {
		var padding = 48;
		var x = position.x + padding;
		var y = position.y
			+ padding
			+ happinessBar.y
			+ happinessBar.height
			+ 24;
		affectionSprite = new FlxSprite(x, y);
		affectionSprite.makeGraphic(32, 32, KColor.PINK);
		add(affectionSprite);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateHappiness();
		updateAffection();
	}

	public function updateHappiness() {}

	public function updateAffection() {
		// Update color of heart based on affection
	}

	public function setDays(days:Int) {
		dayCounter.text = 'Days: ${days}';
	}
}