package ui;

import flixel.addons.text.FlxTypeText;

class MsgWindow extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var text:FlxTypeText;

	public static inline var WIDTH:Int = 400;
	public static inline var HEIGHT:Int = 200;
	public static inline var BGCOLOR:Int = KColor.RICH_BLACK;
	public static inline var FONTSIZE:Int = 12;

	public function new(x:Float, y:Float) {
		super();
		position = new FlxPoint(x, y);
		create();
	}

	public function create() {
		createBackground(position);
		createText(position);
	}

	public function createBackground(positioin:FlxPoint) {
		background = new FlxSprite(position.x,
			position.y).makeGraphic(WIDTH, HEIGHT, BGCOLOR);
		add(background);
	}

	public function createText(position:FlxPoint) {
		var x = position.x + 12;
		var y = position.y + 12;
		text = new FlxTypeText(x, y, WIDTH - 12, 'Test Text', FONTSIZE);
		text.wordWrap = true;
		add(text);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function sendMessage(text:String, ?speakerName:String) {
		if (speakerName != null) {
			this.text.resetText('${speakerName}: ${text}');
		} else {
			this.text.resetText('${text}');
		}
		this.text.start(0.05);
	}

	public function show() {
		visible = true;
	}

	public function hide() {
		visible = false;
	}
}