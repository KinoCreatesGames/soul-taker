package game.chars;

import flixel.math.FlxVelocity;
import flixel.math.FlxVector;
import flixel.FlxObject;
import game.chars.Char;

class Gal extends Char {
	/**
	 * The current happiness Gal has when doing a task.
	 * Have Gal only walk in prescribed areas.
	 */
	public var happiness:Float;

	/**
	 * The amount of affection the Gal has for the MC.
	 */
	public var affection:Float;

	public var ai:State;
	public var stateTimer:Float;
	public var walkingPoint:FlxPoint;

	public static inline var STATE_TIME:Float = 10.5;
	public static inline var SPEED:Int = 75;

	public function new(x:Float, y:Float, data:Actor) {
		super(x, y, data);
		happiness = 75;
		ai = new State(idle);
		stateTimer = 0;
		walkingPoint = null;
		// Load Character Sprite
		loadGraphic(AssetPaths.martha_test__png, true, 32, 32);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		var fps = 6;
		animation.add('down', [0, 1, 2], fps, false);
		animation.add('right', [6, 7, 8], fps, false);
		animation.add('up', [18, 19, 20], fps, false);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		ai.update(elapsed);
	}

	public function idle(elapsed:Float) {
		if (walkingPoint != null && stateTimer < STATE_TIME) {
			var newPoint = walkingPoint.copyTo(new FlxPoint(0, 0));
			var walkVec:FlxVector = newPoint.subtractPoint(this.getPosition());
			var walkingDirection = walkVec.normalize();
			if (walkingDirection.y < 0) {
				animation.play('up');
			} else if (walkingDirection.y > 0) {
				animation.play('down');
			} else if (walkingDirection.x > 0) {
				facing = FlxObject.RIGHT;
				animation.play('right');
			} else if (walkingDirection.x < 0) {
				facing = FlxObject.LEFT;
				animation.play('right');
			}
			FlxVelocity.moveTowardsPoint(this, walkingPoint, SPEED);
			stateTimer += elapsed;
		} else if (stateTimer > STATE_TIME || walkingPoint == null) {
			// Reset Timer & Shift Walking Point
			stateTimer = 0;
			var signX = Math.random() < 0.5 ? -1 : 1;
			var signY = Math.random() < 0.5 ? -1 : 1;
			var xRange = Math.random() * 100 * signX;
			var yRange = Math.random() * 100 * signY;
			walkingPoint = this.getPosition().copyTo(new FlxPoint(0, 0));
			walkingPoint.x += xRange;
			walkingPoint.y += yRange;
			trace(walkingPoint);
		}
		// Add Bounds Check to prevent leaving screen
	}

	public function addToStat(stat:Stat) {
		switch (stat) {
			case Atk(value):
				this.atk += value;
			case Def(value):
				this.def += value;
			case Dex(value):
				this.dex += value;
			case Agi(value):
				this.agi += value;
			case Intl(value):
				this.intl += value;
		}
	}

	public function setToStat(stat:Stat) {
		switch (stat) {
			case Atk(value):
				this.atk = value;
			case Def(value):
				this.def = value;
			case Dex(value):
				this.dex = value;
			case Agi(value):
				this.agi = value;
			case Intl(value):
				this.intl = value;
		}
	}

	public function setHappiness(value:Float) {
		happiness = value;
	}

	public function addHappiness(value:Float) {
		happiness += value;
	}

	public function setAffection(value:Float) {
		affection = value;
	}

	public function addAffection(value:Float) {
		affection += value;
	}
}