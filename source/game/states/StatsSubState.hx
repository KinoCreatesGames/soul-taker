package game.states;

import game.chars.Gal;
import flixel.FlxCamera;
import flixel.util.FlxAxes;

class StatsSubState extends FlxSubState {
	public var background:FlxSprite;
	public var titleText:FlxText;
	public var player:Gal;
	public var playerSprite:FlxSprite;
	public var subStateCameras:Array<FlxCamera>;

	public function new(gal:Gal) {
		this.player = gal;
		super();
	}

	override public function create() {
		FlxG.mouse.visible = true;
		// Setup camera for containing game objects for blur filter when switching scenes
		// subStateCamera = new FlxCamera(0, 0, 300, 300);
		// FlxG.cameras.add(subStateCamera);
		subStateCameras = [];
		createBackground();
		createTitle();
		createButtons();
		createStatSheet();
		createCharacter();
		super.create();
	}

	public function createBackground() {
		// Based on Screen Ratio
		// 2: 1 Ratio for Screen Here
		var leftPortion = (FlxG.width / 3) * 2;
		var rightPortion = FlxG.width / 3;

		background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height,
			KColor.TRANSPARENT); // Draw Right
		background.drawRect(leftPortion, 0, rightPortion, FlxG.height,
			KColor.BURGUNDY);

		add(background);
	}

	public function createTitle() {
		titleText = new FlxText(0, 0, -1, Globals.TEXT_STATS, Globals.FONT_H);
		titleText.screenCenter(FlxAxes.X);
		titleText.y += 20;
		titleText.scrollFactor.set(0, 0);
		add(titleText);
	}

	public function createButtons() {
		var exitButton = new FlxButton(20, 20, Globals.TEXT_RETURN, resumeGame);
		add(exitButton);
	}

	public function createStatSheet() {
		var padding = 24;
		var textSize = Globals.FONT_L;
		var lineHeight = 12 + textSize;
		var leftPortion = (FlxG.width / 3) * 2;
		var rightPortion = FlxG.width / 3;
		var x = leftPortion + padding;
		var y = 100;

		var nameText = new FlxText(x, y, -1, Globals.PLAYER_GAL_NAME,
			cast textSize * 1.5);
		add(nameText);
		y += lineHeight + 12;
		background.drawRect(x, y, rightPortion - padding, 4);

		y += lineHeight;
		// Draw Stats
		var hpText = new FlxText(x, y, -1, 'HP: ${player.health}', textSize);
		add(hpText);
		y += lineHeight;
		var atkText = new FlxText(x, y, -1, 'Atk: ${player.atk}', textSize);
		add(atkText);
		y += lineHeight;
		var defText = new FlxText(x, y, -1, 'Def: ${player.def}', textSize);
		add(defText);
		y += lineHeight;
	}

	public function createCharacter() {
		var leftPortion = (FlxG.width / 3) * 2;
		var position = (leftPortion / 2) - 16;
		playerSprite = new FlxSprite(position, FlxG.height / 2);
		playerSprite.makeGraphic(32, 32, FlxColor.WHITE);
		playerSprite.x += 200;
		playerSprite.y -= 100;
		add(player);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function resumeGame() {
		// Clear Blur Filter from Main Hub State
		FlxG.cameras.list.iter((camera) -> camera.setFilters([]));
		// Remove newly created cameras
		subStateCameras.iter((subStateCamera) ->
			FlxG.cameras.remove(subStateCamera));
		close();
	}
}