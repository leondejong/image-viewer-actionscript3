package com.leondejong.imageviewer.utilities
{
	import flash.display.*;
	import flash.text.*;
	
	public class Preloader extends Sprite
	{
		private var preloader:Sprite;
		private var background:Shape;
		private var loadbar:Shape;
		private var backgroundColor:uint;
		private var loadbarColor:uint;
		private var preloaderWidth:int;
		private var preloaderHeight:int;
		private var textFormat:TextFormat;
		private var textField:TextField;
		private var textTypeFace:String;
		private var textSize:int;
		private var textColor:uint;
		
		public function Preloader(x:int = 0, y:int = 0, width:int = 200, height:int = 2, backgroundColor:uint = 0x444444, loadbarColor:uint = 0x4FF0000, textTypeFace:String = "Myriad Pro", textSize:int = 10, textColor:uint = 0x000000)
		{
			this.backgroundColor = backgroundColor;
			this.loadbarColor = loadbarColor;
			
			preloaderWidth = width;
			preloaderHeight = height;
			this.x = x;
			this.y = y;
			
			this.textTypeFace = textTypeFace;
			this.textSize = textSize;
			this.textColor = textColor;
			
			drawGraphics();
			//createTextfield();
		}
		
		override public function set width(width:Number):void
		{
			//super.width = width;
			
			if(background != null)
			{
				background.width = width;
			}
			
			if(loadbar != null)
			{
				loadbar.width = width;
			}
			
			if(textField != null)
			{
				textField.x = int(loadbar.x + loadbar.width - textField.width);
			}
		}
		
		override public function set height(height:Number):void
		{
			//super.height = height;
			
			if(background != null)
			{
				background.height = height;
			}
			
			if(loadbar != null)
			{
				loadbar.width = height;
			}
			
			if(textField != null)
			{
				textField.y = int(loadbar.y + loadbar.height);
			}
		}
		
		public function drawGraphics():void
		{
			if(preloaderWidth != 0 && preloaderHeight != 0)
			{
				background = new Shape();
				background.graphics.beginFill(backgroundColor, 1);
				background.graphics.drawRect(0, 0, preloaderWidth, preloaderHeight);
				
				loadbar = new Shape();
				loadbar.graphics.beginFill(loadbarColor, 1);
				loadbar.graphics.drawRect(0, 0, preloaderWidth, preloaderHeight);
				
				preloader = new Sprite();
				preloader.addChild(background);
				preloader.addChild(loadbar);
				
				addChild(preloader);
			}
		}
		
		private function createTextfield():void
		{
			textFormat = new TextFormat();
			textFormat.font = textTypeFace;
			textFormat.size = textSize;
			textFormat.align = TextFormatAlign.LEFT;
			textFormat.color = textColor;
			
			textField = new TextField();
			textField.embedFonts = true;
			textField.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			textField.selectable = false;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.setTextFormat(textFormat);
			textField.defaultTextFormat = textFormat;
			textField.text = "bla";
			textField.x = int(loadbar.x + loadbar.width - textField.width);
			textField.y = int(loadbar.y + loadbar.height);
			
			addChild(textField);
		}
		
		public function updateProgress(progress:Number):void
		{
			if(loadbar != null && background != null)
			{
				loadbar.width = progress * background.width;
			}
			
			if(textField != null)
			{
				textField.text = String(Math.round(progress * 100) + "%");
				textField.x = int(loadbar.x + loadbar.width - textField.width);
				textField.y = int(loadbar.y + loadbar.height);
			}
		}
		
		public function resetProgress():void
		{
			if(loadbar != null)
			{
				loadbar.width = 0;
			}
			
			if(textField != null)
			{
				textField.text = "";
				textField.x = int(loadbar.x + loadbar.width - textField.width);
				textField.y = int(loadbar.y + loadbar.height);
			}
		}
	}
}