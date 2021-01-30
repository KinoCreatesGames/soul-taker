package game.ui;

class Star extends FlxSprite {
	// Add particles later
	public function new(?x:Int, ?y:Int) {
		super(x, y);
		// TODO: Replace with star sprite
		makeGraphic(32, 32, KColor.SNOW);
	}
}