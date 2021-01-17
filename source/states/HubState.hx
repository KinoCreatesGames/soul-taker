package states;

import ui.PlayerHUD;
import js.html.Console;
import ui.MsgWindow;
import chars.*;

class HubState extends FlxState {
	public var charSprite:FlxSprite;

	public var statsButton:FlxButton;
	public var saveButton:FlxButton;
	public var optionsButton:FlxButton;
	public var playerHUD:PlayerHUD;
	public var msgWindow:MsgWindow;

	override public function create() {
		FlxG.mouse.visible = true;
		createBackground();
		createButtons();
		createPlayerHUD();
		createCharacter();
		createMsgWindow();
	}

	public function createBackground() {
		// Background for character as a pixel art room
	}

	public function createButtons() {
		// Add Buttons
		var x = FlxG.width - 120;
		var y = 20;
		var spacing = 40;
		statsButton = new FlxButton(x, y, '', clickStats);
		statsButton.loadGraphic(AssetPaths.statbutton__png, true, 32, 32);
		x += spacing;
		saveButton = new FlxButton(x, y, 'Save', clickSave);
		x += spacing;
		optionsButton = new FlxButton(x, y, 'Options', clickOptions);

		// Add Buttons to  screen
		add(statsButton);
		add(saveButton);
		add(optionsButton);
	}

	public function createPlayerHUD() {
		playerHUD = new PlayerHUD(0, 0);
		add(playerHUD);
	}

	public function createCharacter() {
		charSprite = new Gal(0, 0);
		charSprite.screenCenter();
		add(charSprite);
	}

	public function createMsgWindow() {
		var x = (FlxG.width / 2) - (MsgWindow.WIDTH / 2);
		var y = FlxG.height - MsgWindow.HEIGHT;
		msgWindow = new MsgWindow(x, y);
		add(msgWindow);
		msgWindow.sendMessage('Hello Honey', 'Koyuki');
		Console.log(msgWindow);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePause();
	}

	public function updatePause() {
		if (FlxG.keys.anyPressed([ESCAPE])) {
			openSubState(new PauseSubState());
		}
	}

	// Buttons

	public function clickStats() {
		openSubState(new StatsSubState());
	}

	public function clickSave() {
		openSubState(new SaveSubState());
	}

	public function clickOptions() {
		openSubState(new OptionsSubState());
	}
}