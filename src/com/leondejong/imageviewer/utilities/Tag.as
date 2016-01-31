package com.leondejong.imageviewer.utilities
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	
	public class Tag extends SimpleButton
	{
		private var tagWidth:int;
		private var tagHeight:int;
		private var textFontFace:String;
		private var fontSize:int;
		private var tagText:String;
		private var tagURL:String;
		
		private var upContainer:Sprite;
		private var overContainer:Sprite;
		private var downContainer:Sprite;
		
		private var upBackground:Shape;
		private var overBackground:Shape;
		private var downBackground:Shape;
		
		private var upColor:uint;
		private var overColor:uint;
		private var downColor:uint;
		
		private var backgroundAlpha:Number;
		private var textAlpha:Number;
		
		private var upFormat:TextFormat;
		private var upText:TextField;
		private var upTextColor:uint;
		
		private var overFormat:TextFormat;
		private var overText:TextField;
		private var overTextColor:uint;
		
		private var downFormat:TextFormat;
		private var downText:TextField;
		private var downTextColor:uint;
		
		public function Tag(tagWidth:int = 85, tagHeight:int = 16, textFontFace:String = "Arial_10pt_st", fontSize:int = 10, tagText:String = "Imageviewer 1.2", tagURL:String = "http://leondejong.com", upColor:uint = 0xFFFFFF, overColor:uint = 0x000000, downColor:uint = 0x000000, upTextColor:uint = 0x000000, overTextColor:uint = 0xFFFFFF, downTextColor:uint = 0xFFFFFF, backgroundAlpha:Number = 0.5, textAlpha:Number = 1, rotation:int = -90)
		{
			this.tagWidth = tagWidth;
			this.tagHeight = tagHeight;
			this.textFontFace = textFontFace;
			this.fontSize = fontSize;
			this.tagText = tagText;
			this.tagURL = tagURL;
			
			this.upColor = upColor;
			this.overColor = overColor;
			this.downColor = downColor;
			
			this.upTextColor = upTextColor;
			this.overTextColor = overTextColor;
			this.downTextColor = downTextColor;
			
			this.backgroundAlpha = backgroundAlpha;
			this.textAlpha = textAlpha;
			
			this.rotation = rotation;
			
			create();
			
			addEventListener(MouseEvent.CLICK, buttonInputHandler);
		}
		
		private function create():void
		{
			upBackground = new Shape();
			upBackground.graphics.beginFill(upColor);
			upBackground.graphics.drawRect(0, 0, tagWidth, tagHeight);
			upBackground.alpha = backgroundAlpha;
				
			overBackground = new Shape();
			overBackground.graphics.beginFill(overColor);
			overBackground.graphics.drawRect(0, 0, tagWidth, tagHeight);
			overBackground.alpha = backgroundAlpha;
				
			downBackground = new Shape();
			downBackground.graphics.beginFill(downColor);
			downBackground.graphics.drawRect(0, 0, tagWidth, tagHeight);
			downBackground.alpha = backgroundAlpha;
			
			upFormat = new TextFormat();
			upFormat.font = textFontFace;
			upFormat.size = fontSize;
			upFormat.color = upTextColor;
			
			overFormat = new TextFormat();
			overFormat.font = textFontFace;
			overFormat.size = fontSize;
			overFormat.color = overTextColor;
			
			downFormat = new TextFormat();
			downFormat.font = textFontFace;
			downFormat.size = fontSize;
			downFormat.color = downTextColor;
			
			upText = new TextField();
			upText.embedFonts = true;
			upText.width = tagWidth;
			upText.height = tagHeight;
			upText.alpha = textAlpha;
			upText.text = tagText;
			upText.setTextFormat(upFormat);
			
			overText = new TextField();
			overText.embedFonts = true;
			overText.width = tagWidth;
			overText.height = tagHeight;
			overText.alpha = textAlpha;
			overText.text = tagText;
			overText.setTextFormat(overFormat);
			
			downText = new TextField();
			downText.embedFonts = true;
			downText.width = tagWidth;
			downText.height = tagHeight;
			downText.alpha = textAlpha;
			downText.text = tagText;
			downText.setTextFormat(downFormat);
			
			upContainer = new Sprite;
			upContainer.addChild(upBackground);
			upContainer.addChild(upText);
			
			overContainer = new Sprite;
			overContainer.addChild(overBackground);
			overContainer.addChild(overText);
			
			downContainer = new Sprite;
			downContainer.addChild(downBackground);
			downContainer.addChild(downText);
			
			this.upState = upContainer;
			this.overState = overContainer;
			this.downState = downContainer;
			this.hitTestState = upContainer;
		}
		
		private function buttonInputHandler(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(tagURL), "_blank");
		}
	}
}