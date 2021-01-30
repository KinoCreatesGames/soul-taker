package game.states;

import game.ui.Star;
import flixel.FlxCamera;
import game.chars.Gal;
import flixel.util.FlxArrayUtil;

/**
 * Substate for giving out rewards this will update player stats.
 */
class RewardSubState extends FlxSubState {
	public var rating:Rating;
	public var player:Gal;
	public var upgradeStat:Stat;

	public var gratsText:FlxText;
	public var statText:FlxText;
	public var stars:FlxTypedGroup<Star>;
	public var starDelay:Float;
	public var statBg:FlxSprite;

	// Pulling in MiniGame camera so that all elements stay
	// within the TV Screen.
	public var mgCamera:FlxCamera;
	// Width / height because screen centering won't work due to camera.
	public var width:Int;
	public var height:Int;

	public static inline var STAR_DELAY:Float = 0.50;

	public static inline var REWARD_GOOD:Int = 2;
	public static inline var REWARD_GREAT:Int = 4;
	public static inline var REWARD_AMAZING:Int = 6;
	public static inline var REWARD_AFFECTION:Int = 1;

	public function new(camera:FlxCamera, player:Gal, stat:Stat,
			rating:Rating) {
		mgCamera = camera;
		width = camera.width;
		height = camera.height;
		this.player = player;
		this.rating = rating;
		upgradeStat = stat;
		starDelay = 0;
		super();
	}

	override public function create() {
		createStatBackground();
		createRating();
		createCongratulationsText();
		createStatText();
		addMembersToCamera();
	}

	public function createStatBackground() {
		// TODO: Replace with real art
		statBg = new FlxSprite(0, 0);
		statBg.makeGraphic(width, height, KColor.RICH_BLACK_FORGRA);
		add(statBg);
	}

	public function createRating() {
		var padding = 48;
		stars = new FlxTypedGroup<Star>(3);
		// Stars added in the update loop after brief delay
		add(stars);
	}

	public function createCongratulationsText() {
		gratsText = new FlxText(0, 0, -1, 'Congratulations', Globals.FONT_L);
		gratsText.x = (width / 2) - (gratsText.width / 2);
		add(gratsText);
	}

	// Sits within the background image in the center
	public function createStatText() {
		var y = (statBg.height / 2);
		var x = (statBg.width / 2);
		// Player stat passed in from minigame and set to value
		var statValue:Int = upgradeStat.getParameters()[0];
		statText = new FlxText(0, 0, -1, '${statValue}', Globals.FONT_L);
		statText.y = y - (statText.height / 2);
		statText.x = x - (statText.width / 2);
		add(statText);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		processRewardSequence(elapsed);
	}

	public function processRewardSequence(elapsed:Float) {
		// Skip on button press or mouse click
		if (FlxG.mouse.justPressed || FlxG.keys.anyJustPressed([Z])) {
			endState();
		} else {
			// Start Sequence
			// Cycle In Stars One after another
			starDelay += elapsed;
			if (starDelay > STAR_DELAY && stars.length < 3) {
				// Add Star + reset timer
				starDelay = 0;
				var padding = 48;
				var spacing = 12;
				var y = padding;
				if (stars.length < 1) {
					var newStar = new Star(0, y);
					stars.add(newStar);
					newStar.camera = mgCamera;
				} else {
					// Use previous star position
					var lastStar = FlxArrayUtil.last(stars.members);
					var newStar = new Star(cast lastStar.x
						+ lastStar.width
						+ spacing, y);
					stars.add(newStar);
					newStar.camera = mgCamera;
				}
			}
		}
	}

	public function updatePlayerStats() {
		var reward = ratingReward(rating);
		switch (upgradeStat) {
			case Atk(_):
				player.addToStat(Atk(reward));
			case Def(_):
				player.addToStat(Def(reward));
			case Dex(_):
				player.addToStat(Dex(reward));
			case Agi(_):
				player.addToStat(Agi(reward));
			case Intl(_):
				player.addToStat(Intl(reward));
		}
	}

	public function ratingReward(rating:Rating):Int {
		return switch (rating) {
			case Good:
				REWARD_GOOD;
			case Great:
				REWARD_GREAT;
			case Amazing:
				REWARD_AMAZING;
		}
	}

	public function affectionReward():Int {
		return REWARD_AFFECTION;
	}

	public function addMembersToCamera() {
		members.iter((member) -> {
			member.camera = mgCamera;
		});
	}

	public function endState() {
		close();
	}
}