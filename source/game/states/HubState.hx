package game.states;

import openfl.geom.Point;
import flixel.FlxCamera;
import openfl.filters.BlurFilter;
import game.ui.PlayerHUD;
import js.html.Console;
import game.ui.MsgWindow;
import game.chars.*;

class HubState extends FlxState {
	public var player:Gal;

	public var statsButton:FlxButton;
	public var saveButton:FlxButton;
	public var optionsButton:FlxButton;
	public var playerHUD:PlayerHUD;
	public var msgWindow:MsgWindow;

	override public function create() {
		FlxG.mouse.visible = true;
		FlxG.game.filtersEnabled = false;
		// Required for blur effect - flash only
		FlxG.camera.useBgAlphaBlending = true;
		createBackground();
		createButtons();
		createCharacter();
		createPlayerHUD();
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
		playerHUD = new PlayerHUD(0, 0, player);
		add(playerHUD);
	}

	public function createCharacter() {
		var playerData = DepotData.Actors.lines.getByFn((el) ->
			el.name == 'Koyuki');
		player = new Gal(0, 0, playerData);
		player.screenCenter();
		add(player);
	}

	public function createMsgWindow() {
		var x = (FlxG.width / 2) - (MsgWindow.WIDTH / 2);
		var y = FlxG.height - MsgWindow.HEIGHT;
		msgWindow = new MsgWindow(x, y);
		add(msgWindow);
		Console.log(msgWindow);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePause();
		updateClickPlayer(elapsed);
	}

	public function updateClickPlayer(elapsed:Float) {
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(player)) {
			var randomIndex = Math.round((Math.random() * (DepotData.Barks.lines.length
				- 1)));
			var randomLine = DepotData.Barks.lines[randomIndex];
			msgWindow.sendMessage(randomLine.message, randomLine.name);
		}
	}

	public function updatePause() {
		if (FlxG.keys.anyPressed([ESCAPE])) {
			openSubState(new PauseSubState());
		}
	}

	// Buttons

	public function clickStats() {
		var blur = new BlurFilter();
		// FlxG.camera.setFilters([blur]);
		// var tempData = player.pixels.clone();
		// var realData = player.pixels;
		// realData.applyFilter(tempData, tempData.rect, new Point(0, 0), blur);
		openSubState(new StatsSubState(player));
	}

	public function clickSave() {
		openSubState(new SaveSubState());
	}

	public function clickOptions() {
		openSubState(new OptionsSubState());
	}
}