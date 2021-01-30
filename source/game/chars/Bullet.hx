package game.chars;

class Bullet extends FlxSprite {
	public function new() {
		super();
		create();
	}

	public function create() {
		makeGraphic(16, 16, KColor.SNOW);
	}

	public function fire(direction:FlxPoint) {}
}