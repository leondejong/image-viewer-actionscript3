package com.leondejong.imageviewer.view
{
	import flash.display.*;
	import flash.text.*;
	import flash.geom.*;
	
	public class TextBar extends Sprite
	{
		public var bar:Sprite;
		private var barWidth:int;
		private var barHeight:int;
		private var barColor:uint;
		private var barAlpha:Number;
		private var barShadeAlpha:Number;
		
		public var textField:TextField;
		private var textFormat:TextFormat;
		private var textTypeFace:String;
		private var textMargin:int;
		private var textSize:int;
		private var textColor:uint;
		private var textAlign:String;
		private var defaultText:String;
		
		public function TextBar(barWidth:int = 480, barHeight:int = 32, barColor:uint = 0xFFFFFF, barAlpha:Number = 1, barShadeAlpha:Number = 0.3, textTypeFace:String = "Arial", textMargin:int = 10, textSize:int = 20, textColor:uint = 0x444444, textAlign:String = TextFormatAlign.LEFT, defaultText:String = "")
		{
			this.barWidth = barWidth;
			this.barHeight = barHeight;
			this.barColor = barColor;
			this.barAlpha = barAlpha;
			this.barShadeAlpha = barShadeAlpha;
			
			this.textMargin = textMargin;
			this.textTypeFace = textTypeFace;
			this.textSize = textSize;
			this.textColor = textColor;
			this.textAlign = textAlign;
			this.defaultText = defaultText;
			
			create();
		}
		
		private function create():void
		{
			var barMatrix:Matrix = new Matrix();
			barMatrix.createGradientBox(barWidth, barHeight, Math.PI / 2);
			
			var barShade:Shape = new Shape();
			barShade.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0x000000], [1, 1], [0, 255], barMatrix);
			barShade.graphics.drawRect(0, 0, barWidth, barHeight);
			barShade.alpha = barShadeAlpha;
			
			bar = new Sprite();
			bar.graphics.beginFill(barColor);
			bar.graphics.drawRect(0, 0, barWidth, barHeight);
			bar.alpha = barAlpha;
			bar.addChild(barShade);
			
			textFormat = new TextFormat();
			textFormat.font = textTypeFace;
			textFormat.size = textSize;
			textFormat.align = textAlign;
			textFormat.color = textColor;
			
			textField = new TextField();
			textField.embedFonts = true;
			textField.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			textField.x = textMargin;
			textField.width = barWidth - (textMargin * 2);
			textField.height = barHeight;
			textField.selectable = false;
			textField.text = defaultText;
			textField.setTextFormat(textFormat);
			textField.defaultTextFormat = textFormat;
			
			addChild(bar);
			addChild(textField);
		}
	}
}