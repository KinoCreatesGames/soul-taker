package game.states;

import flixel.util.FlxAxes;

class TitleState extends FlxState {
	override public function create() {
		FlxG.mouse.visible = true;
		// Create Title Text
		var text = new FlxText(0, 0, 300, Globals.GAME_TITLE, 32);
		add(text);
		text.screenCenter();
		createButtons();
		createControls();
		createCredits();
		createVersion();
		super.create();
	}

	public function createButtons() {
		// Create Buttons
		var y = 40;
		var playButton = new FlxButton(0, 0, Globals.TEXT_START, clickStart);
		playButton.screenCenter();
		playButton.y += y;
		y += 40;
		var continueButton = new FlxButton(0, 0, Globals.TEXT_CONTINUE,
			clickContinue);
		continueButton.screenCenter();
		continueButton.y += y;
		y += 40;
		var optionsButton = new FlxButton(0, 0, Globals.TEXT_OPTIONS,
			clickOptions);
		optionsButton.screenCenter();
		optionsButton.y += y;
		y += 40;
		#if desktop
		var exitButton = new FlxButton(0, 0, Globals.TEXT_EXIT, clickExit);
		exitButton.screenCenter();
		exitButton.y += y;
		#end
		// Add Buttons

		add(playButton);
		add(continueButton);
		add(optionsButton);
		#if desktop
		add(exitButton);
		#end
	}

	public function clickStart() {
		var introText = DepotData.Cutscene.lines.getByFn((el) ->
			el.name == 'Intro');
		FlxG.switchState(new CutsceneState(new HubState(),
			introText.cutsceneText));
	}

	public function clickContinue() {
		openSubState(new LoadSubState());
	}

	public function clickOptions() {
		openSubState(new OptionsSubState());
	}

	#if desktop
	public function clickExit() {
		Sys.exit(0);
	}
	#end

	public function createControls() {
		var textWidth = 200;
		var textSize = 12;
		var controlsText = new FlxText(20, FlxG.height - 100, textWidth,
			'How To Move:
UP: W/UP
Left/Right: A/Left, S/Right', textSize);
		add(controlsText);
	}

	public function createCredits() {
		var textWidth = 200;
		var textSize = 12;
		var creditsText = new FlxText(FlxG.width - textWidth,
			FlxG.height - 100, textWidth, 'Created by KinoCreates', textSize);
		add(creditsText);
	}

	public function createVersion() {
		var textWidth = 200;
		var textSize = 12;
		var versionText = new FlxText(FlxG.width - textWidth,
			FlxG.height - 100, textWidth, Globals.TEXT_VERSION, textSize);
		versionText.screenCenter(FlxAxes.X);
		add(versionText);
	}
}