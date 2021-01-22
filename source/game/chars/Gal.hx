package game.chars;

import game.chars.Char;

class Gal extends Char {
	public var happiness:Float;

	public function new(x:Float, y:Float, data:Actor) {
		super(x, y, data);
		happiness = 75;
		makeGraphic(64, 64, KColor.SNOW);
	}
}