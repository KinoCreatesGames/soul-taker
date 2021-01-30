package game.states;

import flixel.util.FlxAxes;
import game.chars.Gal;

class TrainingSubState extends FlxSubState {
	public var player:Gal;
	public var playerSprite:FlxSprite;
	public var background:FlxSprite;
	public var powerButton:FlxButton; // Returns to previous scene
	public var leftButton:FlxButton; // Change Channels Left
	public var rightButton:FlxButton; // Change Channels Right
	public var playButton:FlxButton; // Plays the current mini game.
	public var titleText:FlxText; // Title Text For the TV
	public var channelIndex:Int;

	public static inline var WIDTH:Int = 640;
	public static inline var HEIGHT:Int = 356;
	public static inline var CHANNEL_MAX:Int = 6;

	public function new(gal:Gal) {
		player = gal;
		channelIndex = 0;
		super(KColor.RICH_BLACK_FORGRA_LOW);
	}

	override public function create() {
		createBackground();
		createTrainingText();
		createTrainingButtons();
		super.create();
	}

	public function createBackground() {
		background = new FlxSprite(0, 0);
		var padding = 24;
		var innerTvStart = 4;
		background.makeGraphic(WIDTH, HEIGHT, KColor.BURGUNDY);
		background.drawRect(padding, padding, WIDTH - padding * 2,
			HEIGHT - padding * 2, KColor.SNOW);
		background.drawRect(padding
			+ innerTvStart, padding
			+ innerTvStart,
			(WIDTH - padding * 2)
			- (innerTvStart * 2),
			(HEIGHT - padding * 2)
			- (innerTvStart * 2),
			KColor.RICH_BLACK_FORGRA);
		background.screenCenter();
		add(background);
	}

	public function createTrainingText() {
		titleText = new FlxText(0, 0, -1, 'Training', Globals.FONT_L);
		titleText.y = background.y + 30;
		titleText.alignment = CENTER;
		titleText.screenCenter(FlxAxes.X);
		updateTVScreen();
		add(titleText);
	}

	public function createTrainingButtons() {
		var padding = 24;
		var x = background.x + padding;
		var y = background.y + (HEIGHT - padding);
		powerButton = new FlxButton(x, background.y, 'O', clickPower);
		add(powerButton);
		leftButton = new FlxButton(x, y, '<--', clickLeft);
		add(leftButton);
		playButton = new FlxButton(x, y, 'Play', clickPlay);
		playButton.screenCenter(FlxAxes.X);
		add(playButton);
		rightButton = new FlxButton((background.x + WIDTH) - padding * 4, y,
			'-->', clickRight);
		add(rightButton);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function clickLeft() {
		channelIndex = (channelIndex - 1) % CHANNEL_MAX;
		if (channelIndex == -1) {
			channelIndex = 5;
		}
		updateTVScreen();
	}

	public function clickPlay() {
		var padding = 24;
		var innerTvStart = 4;
		var x = background.x + padding + innerTvStart;
		var y = background.y + padding + innerTvStart;
		var width = (WIDTH - padding * 2) - (innerTvStart * 2);
		var height = (HEIGHT - padding * 2) - (innerTvStart * 2);
		// Remove Happiness From Bar

		switch (channelIndex) {
			case 0: // Atk
				openSubState(new MiniGameSubState(cast x, cast y, width,
					height, player));
			case 1: // Def
			case 2: // Agi - Dodge Things
				openSubState(new AgiGameSubState(cast x, cast y, width,
					height, player));
			case 3: // Dex - SHMUP
			case 4: // Int - Matching Game
			case 5: //
			case _: //
		}
	}

	public function clickRight() {
		channelIndex = (channelIndex + 1) % CHANNEL_MAX;
		updateTVScreen();
	}

	public function updateTVScreen() {
		switch (channelIndex) {
			case 0: // Atk
				titleText.text = 'Crush! Crush! Crush!';
			case 1: // Def
				titleText.text = 'Tought It Out';
			case 2: // Agi - Dodge Things
				titleText.text = 'Escape Your Fate';
			case 3: // Dex - SHMUP
				titleText.text = 'Blitzel';
			case 4: // Int - Matching Game
				titleText.text = 'Memory Management';
			case 5: //
			case _: //
		}
		titleText.screenCenter(FlxAxes.X);
	}

	public function clickPower() {
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			FlxG.camera.fade(KColor.BLACK, 1, true);
		});
	}
}