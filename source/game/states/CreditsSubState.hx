package game.states;

import game.ui.Underline;
import flixel.util.FlxAxes;

class CreditsSubState extends FlxSubState {
	public var titleText:FlxText;
	public var underline:Underline;
	public var backButton:FlxButton;

	/**
	 * Individuals to credit
	 */
	public var credits:Array<String>;

	public function new() {
		super(KColor.RICH_BLACK_FORGRA);
	}

	override public function create() {
		// credits = DepotData.Credits.lines;
		credits = DepotData.Credits.lines.map((line) ->
			'${line.title} ${line.name}');
		createTitle();
		createCredits();
		createBack();
	}

	public function createTitle() {
		titleText = new FlxText(0, 120, -1, Globals.TEXT_CREDITS,
			Globals.FONT_H);
		titleText.screenCenter(FlxAxes.X);
		underline = new Underline(0, titleText.y + titleText.height + 8,
			titleText.width * 1.5, 6, KColor.SNOW);
		underline.screenCenter(FlxAxes.X);
		underline.setupFade(2.25, true);

		add(titleText);
		add(underline);
	}

	public function createCredits() {
		var padding = 24;
		var x = titleText.x;
		var y = underline.y + padding;
		var lineSpacing = 12;
		for (credit in credits) {
			var text = new FlxText(x, y, -1, credit, Globals.FONT_L);
			text.screenCenter(FlxAxes.X);
			add(text);
			y += text.height + lineSpacing;
		}
	}

	public function createBack() {
		var padding = 24;
		backButton = new FlxButton(padding, padding, '', clickBack);
		add(backButton);
	}

	public function clickBack() {
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			FlxG.camera.fade(KColor.BLACK, 1, true);
		});
	}
}