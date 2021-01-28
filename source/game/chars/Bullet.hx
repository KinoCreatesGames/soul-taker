package game.chars;

class Bullet extends FlxSprite {
	public function new() {
		super();
		create();
	}

	public function create() {
		makeGraphic(8, 8, KColor.SNOW);
	}

	public function fire(direction:FlxPoint) {}
}