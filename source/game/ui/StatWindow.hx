package game.ui;

import game.chars.Gal;

class StatWindow extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var player:Gal;
	public var nameText:FlxText;
	public var hpText:FlxText;
	public var atkText:FlxText;
	public var defText:FlxText;
	public var agiText:FlxText;

	public static inline var BORDERSIZE:Int = 2;
	public static inline var BGCOLOR:Int = KColor.RICH_BLACK_FORGRA;
	public static inline var HEIGHT = 250;
	public static inline var WIDTH = 150;
	public static inline var MARGIN = 24;
	public static inline var SPACING:String = '                   ';

	public function new(x:Float, y:Float, gal:Gal) {
		super();
		player = gal;
		position = new FlxPoint(x, y);
		create();
	}

	public function create() {
		createBackground(position);
		createText(position);
	}

	public function createBackground(position:FlxPoint) {
		var x = position.x;
		var y = position.y;
		background = new FlxSprite(x, y);
		background.makeGraphic(WIDTH, HEIGHT, KColor.TRANSPARENT);
		background.drawRect(0, 0, WIDTH, HEIGHT, KColor.SNOW);
		background.drawRect(BORDERSIZE, BORDERSIZE, WIDTH - BORDERSIZE * 2,
			HEIGHT - BORDERSIZE * 2, BGCOLOR);
		add(background);
	}

	public function createText(position:FlxPoint) {
		var padding = 12;
		var x = position.x + padding;
		var y = position.y + padding;
		var lineHeight = 12;
		var createFlxText = (text:String) -> {
			var txt = new FlxText(x, y, WIDTH, text, Globals.FONT_N);
			y += (lineHeight * 2);
			return txt;
		}

		nameText = createFlxText(player.name);
		hpText = createFlxText('HP');
		atkText = createFlxText('Atk');
		defText = createFlxText('Def');
		agiText = createFlxText('Agi');

		add(nameText);
		add(hpText);
		add(atkText);
		add(defText);
		add(agiText);
	}

	public function updateStats() {
		nameText.text = player.name;
		hpText.text = 'HP${SPACING}${player.health}';
		atkText.text = 'Atk${SPACING}${player.atk}';
		defText.text = 'Def${SPACING}${player.def}';
		agiText.text = 'Agi${SPACING}${player.agi}';
	}

	public function hide() {
		visible = false;
		// members.iter((member) -> member.visible = false);
	}

	public function show() {
		visible = true;
		// members.iter((member) -> member.visible = true);
	}

	public function move(x:Float, y:Float) {
		members.iter((member) -> {
			var currentPosition = member.getPosition();
			var newPosition = new FlxPoint(x, y);
			newPosition.putWeak();
			var diffPosition = newPosition.subtractPoint(currentPosition);
			var relativeX = currentPosition.x - x;
			var relativeY = currentPosition.y - y;
			member.x += diffPosition.x + relativeX;
			member.y += diffPosition.y + relativeY;
		});
	}
}