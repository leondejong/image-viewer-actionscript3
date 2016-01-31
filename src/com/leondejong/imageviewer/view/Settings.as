package com.leondejong.imageviewer.view
{
	import flash.events.*;
	import flash.text.*;
	
	import com.leondejong.imageviewer.utilities.*;
	
	public class Settings extends EventDispatcher
	{
		public static var defaultLoadError:String = "Switching to default settings";
		
		public var xml:XML;
		
		public var imageAlpha:Number;
		public var imageMargin:int;
		public var imageBorder:int;
		public var fadeSpeed:Number;
		public var shadeAlpha:Number = 0.3;
		public var disabledAlpha:Number = 0;
		
		public var backgroundColor:uint;
		public var backgroundImageURL:String;
		public var backgroundPatternURL:String;
		public var backgroundImageAlpha:Number;
		public var backgroundPatternAlpha:Number;
		public var backgroundImageFadeSpeed:Number;
		
		public var frameColor:uint;
		public var frameAlpha:Number;
		public var frameAnimationSpeed:Number;
		
		public var barHeight:int;
		
		public var topBarColor:uint;
		public var topBarAlpha:Number;
		public var topBarShadeAlpha:Number;
		
		public var bottomBarColor:uint;
		public var bottomBarAlpha:Number;
		public var bottomBarShadeAlpha:Number;
		
		public var textTypeFace:String;
		public var textMargin:int;
		
		public var nameSize:int;
		public var nameColor:uint;
		public var nameAlign:String;
		
		public var descriptionSize:int;
		public var descriptionColor:uint;
		public var descriptionAlign:String;
		
		public var positionSize:int;
		public var positionColor:uint;
		public var positionAlign:String;
		
		public var buttonSize:int;
		
		public var nextButtonUpBackgroundColor:uint;
		public var nextButtonOverBackgroundColor:uint;
		public var nextButtonDownBackgroundColor:uint;
		
		public var nextButtonUpArrowColor:uint;
		public var nextButtonOverArrowColor:uint;
		public var nextButtonDownArrowColor:uint;
		
		public var nextButtonAlpha:Number;
		public var disabledNextButtonAlpha:Number;
		public var nextButtonShadeAlpha:Number;
		
		public var previousButtonUpBackgroundColor:uint;
		public var previousButtonOverBackgroundColor:uint;
		public var previousButtonDownBackgroundColor:uint;
		
		public var previousButtonUpArrowColor:uint;
		public var previousButtonOverArrowColor:uint;
		public var previousButtonDownArrowColor:uint;
		
		public var previousButtonAlpha:Number;
		public var disabledPreviousButtonAlpha:Number;
		public var previousButtonShadeAlpha:Number;
		
		public var preloaderBackgroundColor:uint;
		public var preloaderLoadbarColor:uint;
		public var preloaderAlpha:Number;
		
		public function Settings(url:String = "settings.xml")
		{
			loadXML(url);
		}
		
		private function initializeDefaultSettings():void
		{
			imageAlpha = 1;
			imageMargin = 20;
			imageBorder = 10;
			fadeSpeed = 0.5;
			
			backgroundColor = 0xDDDDDD;
			backgroundImageURL = null;
			backgroundPatternURL = null;
			backgroundImageAlpha = 1;
			backgroundPatternAlpha = 0.3;
			backgroundImageFadeSpeed = 0.5;
			
			frameColor = 0x444444;
			frameAlpha = 1;
			frameAnimationSpeed = 0.7;
			
			barHeight = 32;
			
			topBarColor = 0xFFFFFF;
			topBarAlpha = 1;
			topBarShadeAlpha = 0.3;
			
			bottomBarColor = 0xFFFFFF;
			bottomBarAlpha = 1;
			bottomBarShadeAlpha = 0.3;
			
			textMargin = 10;
			textTypeFace = "Myriad Pro";
			
			nameSize = 20;
			nameColor = 0x444444;
			nameAlign = TextFormatAlign.LEFT;
			
			descriptionSize = 20;
			descriptionColor = 0x444444;
			descriptionAlign = TextFormatAlign.LEFT;
			
			positionSize = 20;
			positionColor = 0x444444;
			positionAlign = TextFormatAlign.RIGHT;
			
			buttonSize = 50;
			
			nextButtonUpBackgroundColor = 0xFFFFFFF;
			nextButtonOverBackgroundColor = 0xDDDDDD;
			nextButtonDownBackgroundColor = 0xBBBBBB;
			
			nextButtonUpArrowColor = 0x444444;
			nextButtonOverArrowColor = 0x444444;
			nextButtonDownArrowColor = 0x444444;
			
			nextButtonAlpha = 1;
			disabledNextButtonAlpha = 0.3;
			nextButtonShadeAlpha = 0.3;
			
			previousButtonUpBackgroundColor = 0xFFFFFF;
			previousButtonOverBackgroundColor = 0xDDDDDD;
			previousButtonDownBackgroundColor = 0xBBBBBB;
			
			previousButtonUpArrowColor = 0x444444;
			previousButtonOverArrowColor = 0x444444;
			previousButtonDownArrowColor = 0x444444;
			
			previousButtonAlpha = 1;
			disabledPreviousButtonAlpha = 0.3;
			previousButtonShadeAlpha = 0.3;
			
			preloaderBackgroundColor = 0xFFFFFF;
			preloaderLoadbarColor = 0xFF0000;
			preloaderAlpha = 1;
		}
		
		private function initializeXMLSettings():void
		{
			imageAlpha = xml.image.alpha;
			imageMargin = xml.image.margin;
			imageBorder = xml.image.border;
			fadeSpeed = xml.image.fadespeed;
			
			backgroundColor = xml.background.@color;
			if(xml.background.image.url != null && xml.background.image.url != "")
			{
				backgroundImageURL = xml.background.image.url;
			}
			if(xml.background.pattern.url != null && xml.background.pattern.url != "")
			{
				backgroundPatternURL = xml.background.pattern.url;
			}
			backgroundImageAlpha = xml.background.image.alpha;
			backgroundPatternAlpha = xml.background.pattern.alpha;
			backgroundImageFadeSpeed = xml.background.image.fadespeed;
			
			frameColor = xml.frame.color;
			frameAlpha = xml.frame.alpha;
			frameAnimationSpeed = xml.frame.animationspeed;
			
			barHeight = xml.bars.@height;
			
			topBarColor = xml.bars.top.color;
			topBarAlpha = xml.bars.top.alpha;
			if(xml.bars.top.shade == true)
			{
				topBarShadeAlpha = shadeAlpha;
			}
			else
			{
				topBarShadeAlpha = 0;
			}
			
			bottomBarColor = xml.bars.bottom.color;
			bottomBarAlpha = xml.bars.bottom.alpha;
			if(xml.bars.bottom.shade == true)
			{
				bottomBarShadeAlpha = shadeAlpha;
			}
			else
			{
				bottomBarShadeAlpha = 0;
			}
			
			textMargin = xml.text.@sidemargin;
			textTypeFace = "Myriad Pro";
			
			nameSize = xml.text.name.size;
			nameColor = xml.text.name.color;
			nameAlign = xml.text.name.align;
			
			descriptionSize = xml.text.description.size;
			descriptionColor = xml.text.description.color;
			descriptionAlign = xml.text.description.align;
			
			positionSize = xml.text.position.size;
			positionColor = xml.text.position.color;
			positionAlign = xml.text.position.align;
			
			buttonSize = xml.buttons.@size;
			
			nextButtonUpBackgroundColor = xml.buttons.next.upbackgroundcolor;
			nextButtonOverBackgroundColor = xml.buttons.next.overbackgroundcolor;
			nextButtonDownBackgroundColor = xml.buttons.next.downbackgroundcolor;
			
			nextButtonUpArrowColor = xml.buttons.next.uparrowcolor;
			nextButtonOverArrowColor = xml.buttons.next.overarrowcolor;
			nextButtonDownArrowColor = xml.buttons.next.downarrowcolor;
			
			nextButtonAlpha = xml.buttons.next.alpha;
			disabledNextButtonAlpha = disabledAlpha;
			if(xml.buttons.next.shade == true)
			{
				nextButtonShadeAlpha = shadeAlpha;
			}
			else
			{
				nextButtonShadeAlpha = 0;
			}
			
			previousButtonUpBackgroundColor = xml.buttons.previous.upbackgroundcolor;
			previousButtonOverBackgroundColor = xml.buttons.previous.overbackgroundcolor;
			previousButtonDownBackgroundColor = xml.buttons.previous.downbackgroundcolor;
			
			previousButtonUpArrowColor = xml.buttons.previous.uparrowcolor;
			previousButtonOverArrowColor = xml.buttons.previous.overarrowcolor;
			previousButtonDownArrowColor = xml.buttons.previous.downarrowcolor;
			
			previousButtonAlpha = xml.buttons.previous.alpha;
			disabledPreviousButtonAlpha = disabledAlpha;
			if(xml.buttons.previous.shade == true)
			{
				previousButtonShadeAlpha = shadeAlpha;
			}
			else
			{
				previousButtonShadeAlpha = 0;
			}
			
			preloaderBackgroundColor = xml.preloader.backgroundcolor;
			preloaderLoadbarColor = xml.preloader.loadbarcolor;
			preloaderAlpha = xml.preloader.alpha;
		}
		
		public function loadXML(url:String):void
		{
			try
			{
				var xmlloader:EventDispatcher = new XMLLoader(url);
				xmlloader.addEventListener(Event.COMPLETE, XMLCompleteListener);
				xmlloader.addEventListener(IOErrorEvent.IO_ERROR, XMLErrorListener);
			}
			catch(e:Error)
			{
				catchLoadError(e);
			}
		}
		
		private function XMLCompleteListener(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, XMLCompleteListener);
			e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, XMLErrorListener);
			
			xml = e.currentTarget.getXML();
			
			initializeXMLSettings();
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function XMLErrorListener(e:IOErrorEvent):void
		{
			trace("Settings.XMLErrorListener(): "+defaultLoadError);
			
			initializeDefaultSettings();
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function catchLoadError(e:Error):void
		{
			throw new Error(XMLLoader.defaultLoadError);
		}
	}
}