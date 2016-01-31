package com.leondejong.imageviewer.view
{
	import flash.display.*;
	import flash.geom.*;
	
	import com.leondejong.imageviewer.controller.*;
	
	public class BrowseButton extends SimpleButton
	{
		private var type:String;
		private var size:int;
		private var shadeAlpha:Number;
		private var matrix:Matrix;
		
		private var up:Sprite;
		private var over:Sprite;
		private var down:Sprite;
		
		private var upBackground:Shape;
		private var overBackground:Shape;
		private var downBackground:Shape;
		
		private var upBackgroundColor:uint;
		private var overBackgroundColor:uint;
		private var downBackgroundColor:uint;
		
		private var upArrow:Shape;
		private var overArrow:Shape;
		private var downArrow:Shape;
		
		private var upArrowColor:uint;
		private var overArrowColor:uint;
		private var downArrowColor:uint;
		
		private var upShade:Shape;
		private var overShade:Shape;
		private var downShade:Shape;
		
		public function BrowseButton(type:String, size:int = 50, alpha:Number = 1, shadeAlpha:Number = 0.2, upBackgroundColor:uint = 0xFFFFFF, overBackgroundColor:uint = 0xDDDDDD, downBackgroundColor:uint = 0xBBBBBB, upArrowColor:uint = 0x444444, overArrowColor:uint = 0x444444, downArrowColor:uint = 0x444444)
		{
			setType(type);
			
			this.size = size;
			this.alpha = alpha
			this.shadeAlpha = shadeAlpha;
			this.upBackgroundColor = upBackgroundColor;
			this.overBackgroundColor = overBackgroundColor;
			this.downBackgroundColor = downBackgroundColor;
			this.upArrowColor = upArrowColor;
			this.overArrowColor = overArrowColor;
			this.downArrowColor = downArrowColor;
			
			createButton();
		}
		
		private function setType(type:String):void
		{
			this.type = type;
		}
		
		public function getType():String
		{
			return type;
		}
		
		public function createButton():void
		{
				var matrix:Matrix = new Matrix();
   				matrix.createGradientBox(50, 50, Math.PI / 2);
				
				upShade = new Shape();
				upShade.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0x000000], [1, 1], [0, 255], matrix);
				upShade.graphics.drawRect(0, 0, 50, 50);
				upShade.x = 0;
				upShade.y = 0;
				upShade.alpha = shadeAlpha;
				
				overShade = new Shape();
				overShade.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0x000000], [1, 1], [0, 255], matrix);
				overShade.graphics.drawRect(0, 0, 50, 50);
				overShade.x = 0;
				overShade.y = 0;
				overShade.alpha = shadeAlpha;
				
				downShade = new Shape();
				downShade.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0x000000], [1, 1], [0, 255], matrix);
				downShade.graphics.drawRect(0, 0, 50, 50);
				downShade.x = 0;
				downShade.y = 0;
				downShade.alpha = shadeAlpha;
				
				upBackground = new Shape();
				upBackground.graphics.beginFill(upBackgroundColor);
				upBackground.graphics.drawRect(0, 0, 50, 50);
				
				overBackground = new Shape();
				overBackground.graphics.beginFill(overBackgroundColor);
				overBackground.graphics.drawRect(0, 0, 50, 50);
				
				downBackground = new Shape();
				downBackground.graphics.beginFill(downBackgroundColor);
				downBackground.graphics.drawRect(0, 0, 50, 50);
				
				if(type == Controller.NEXT_BUTTON)
				{
					upArrow = new Shape();
					upArrow.graphics.beginFill(upArrowColor);
					upArrow.graphics.moveTo(10, 10);
					upArrow.graphics.lineTo(40, 25);
					upArrow.graphics.lineTo(10, 40);
					upArrow.graphics.lineTo(10, 10);
					upArrow.graphics.endFill();
					
					overArrow = new Shape();
					overArrow.graphics.beginFill(overArrowColor);
					overArrow.graphics.moveTo(10, 10);
					overArrow.graphics.lineTo(40, 25);
					overArrow.graphics.lineTo(10, 40);
					overArrow.graphics.lineTo(10, 10);
					overArrow.graphics.endFill();
					
					downArrow = new Shape();
					downArrow.graphics.beginFill(downArrowColor);
					downArrow.graphics.moveTo(10, 10);
					downArrow.graphics.lineTo(40, 25);
					downArrow.graphics.lineTo(10, 40);
					downArrow.graphics.lineTo(10, 10);
					downArrow.graphics.endFill();
				}
				else if(type == Controller.PREVIOUS_BUTTON)
				{
					upArrow = new Shape();
					upArrow.graphics.beginFill(upArrowColor);
					upArrow.graphics.moveTo(40, 40);
					upArrow.graphics.lineTo(40, 10);
					upArrow.graphics.lineTo(10, 25);
					upArrow.graphics.lineTo(40, 40);
					upArrow.graphics.endFill();
					
					overArrow = new Shape();
					overArrow.graphics.beginFill(overArrowColor);
					overArrow.graphics.moveTo(40, 40);
					overArrow.graphics.lineTo(40, 10);
					overArrow.graphics.lineTo(10, 25);
					overArrow.graphics.lineTo(40, 40);
					overArrow.graphics.endFill();
					
					downArrow = new Shape();
					downArrow.graphics.beginFill(downArrowColor);
					downArrow.graphics.moveTo(40, 40);
					downArrow.graphics.lineTo(40, 10);
					downArrow.graphics.lineTo(10, 25);
					downArrow.graphics.lineTo(40, 40);
					downArrow.graphics.endFill();
				}
				
				up = new Sprite();
				up.addChild(upBackground);
				up.addChild(upArrow);
				up.addChild(upShade);
				
				over = new Sprite();
				over.addChild(overBackground);
				over.addChild(overArrow);
				over.addChild(overShade);
				
				down = new Sprite();
				down.addChild(downBackground);
				down.addChild(downArrow);
				down.addChild(downShade);
				
				this.upState = up;
				this.overState = over;
				this.downState = down;
				this.hitTestState = up;
				
				this.width = this.height = size;
		}
	}
}