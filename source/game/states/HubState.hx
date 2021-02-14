package game.states;

import game.ui.StatWindow;
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
	public var trainingButton:FlxButton;
	public var saveButton:FlxButton;
	public var optionsButton:FlxButton;
	public var exitButton:FlxButton;
	public var playerHUD:PlayerHUD;
	public var statWindow:StatWindow;
	public var msgWindow:MsgWindow;

	public static inline var BUTTON_WIDTH:Int = 32;
	public static inline var BUTTON_HEIGHT:Int = 32;

	override public function create() {
		FlxG.mouse.visible = true;
		FlxG.game.filtersEnabled = false;
		// Required for blur effect - flash only
		FlxG.camera.useBgAlphaBlending = true;
		createBackground();
		createButtons();
		createCharacter();
		createPlayerHUD();
		createStatWindow();
		createMsgWindow();
		// Captures Data For Saving
		captureData();
	}

	public function createBackground() {
		// Background for character as a pixel art room
	}

	public function createButtons() {
		// Add Buttons
		var x = FlxG.width - 120;
		var y = 20;
		var spacing = 40;
		exitButton = new FlxButton(x, y, '', clickExit);
		exitButton.loadGraphic(AssetPaths.exit_door__png, true, 32, 32);
		x += spacing;
		optionsButton = new FlxButton(x, y, '', clickOptions);
		optionsButton.loadGraphic(AssetPaths.cog_two__png, true, 32, 32);
		x -= spacing;
		y += spacing;
		trainingButton = new FlxButton(x, y, 'Training', clickTraining);
		y += spacing;
		statsButton = new FlxButton(x, y, '', clickStats);
		statsButton.loadGraphic(AssetPaths.statbutton__png, true,
			BUTTON_WIDTH, BUTTON_HEIGHT);
		y += spacing;
		saveButton = new FlxButton(x, y, 'Save', clickSave);
		y += spacing;

		// Add Buttons to  screen
		add(trainingButton);
		add(statsButton);
		add(saveButton);
		add(optionsButton);
		add(exitButton);
	}

	public function createPlayerHUD() {
		playerHUD = new PlayerHUD(0, 0, player);
		add(playerHUD);
	}

	public function createCharacter() {
		var playerData = DepotData.Actors.lines.getByFn((el) ->
			el.name == 'Koyuki');
		var gameData = SaveLoad.Save.gameData;
		if (gameData.player != null) {
			player = gameData.player;
		} else {
			player = new Gal(0, 0, playerData);
		}
		player.screenCenter();
		add(player);
	}

	public function createStatWindow() {
		var spacing = 24;
		var y = player.y - (StatWindow.HEIGHT + StatWindow.MARGIN);
		statWindow = new StatWindow(player.x, y, player);
		statWindow.hide();
		add(statWindow);
	}

	public function createMsgWindow() {
		var x = (FlxG.width / 2) - (MsgWindow.WIDTH / 2);
		var y = FlxG.height - MsgWindow.HEIGHT;
		msgWindow = new MsgWindow(x, y);
		add(msgWindow);
		Console.log(msgWindow);
	}

	public function captureData() {
		SaveLoad.Save.gameData.player = player;
		SaveLoad.Save.gameData.days = playerHUD.days;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePause();
		updateMouseOverPlayer();
		updateClickPlayer(elapsed);
		updateGameTime(elapsed);
	}

	public function updatePause() {
		if (FlxG.keys.anyPressed([ESCAPE])) {
			openSubState(new PauseSubState());
		}
	}

	public function updateMouseOverPlayer() {
		// On Mouse Over Show Stat Window
		if (FlxG.mouse.overlaps(player)) {
			if (statWindow.visible == false) {
				statWindow.move(player.x,
					player.y - (StatWindow.HEIGHT + StatWindow.MARGIN));

				statWindow.show();
				statWindow.updateStats();
			}
		}

		if (!FlxG.mouse.overlaps(player)) {
			if (statWindow.visible == true) {
				statWindow.hide();
			}
		}
	}

	public function updateClickPlayer(elapsed:Float) {
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(player)) {
			var randomIndex = Math.round((Math.random() * (DepotData.Barks.lines.length
				- 1)));
			var randomLine = DepotData.Barks.lines[randomIndex];
			msgWindow.sendMessage(randomLine.message, randomLine.name);
		}
	}

	public function updateGameTime(elapsed:Float) {
		if (SaveLoad.Save.gameData.gameTime == null) {
			SaveLoad.Save.gameData.gameTime = 0;
		}
		SaveLoad.Save.gameData.gameTime += elapsed;
	}

	// Buttons

	public function clickTraining() {
		openSubState(new TrainingSubState(player));
	}

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

	public function clickExit() {
		// Return to title state
		// TODO: Add Confirmation box as a UI element
		FlxG.switchState(new TitleState());
	}
}