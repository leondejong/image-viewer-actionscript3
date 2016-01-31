package com.leondejong.imageviewer.view
{
	import flash.display.*;
	import flash.events.*;
	import flash.system.*;
	
	import com.leondejong.imageviewer.utilities.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class Background extends Sprite
	{
		private var color:uint;
		private var imageURL:String;
		private var patternURL:String;
		private var target:Stage;
		
		private var imageAlpha:Number;
		private var patternAlpha:Number;
		private var fadeSpeed:Number;
		
		public var backDrop:Shape;
		public var image:Image;
		private var pattern:Image;
		private var overlay:Shape;
		
		public var imageRatio:Number;
		
		private var loading:Boolean = false;
		
		public function Background(color:uint = 0xDDDDDD, imageURL:String = null, patternURL:String = null, imageAlpha:Number = 1, patternAlpha:Number = 0.5, fadeSpeed:Number = 0.5, target:Stage = null)
		{
			this.color = color;
			this.imageURL = imageURL;
			this.patternURL = patternURL;
			this.target = target;
			
			this.imageAlpha = imageAlpha;
			this.patternAlpha = patternAlpha;
			this.fadeSpeed = fadeSpeed;
			
			create();
		}
		
		private function create():void
		{
			if(target != null)
			{
				backDrop = new Shape();
				backDrop.graphics.beginFill(color);
				backDrop.graphics.drawRect(0, 0, target.stageWidth, target.stageHeight);
			}
			else
			{
				backDrop = new Shape();
				backDrop.graphics.beginFill(color);
				backDrop.graphics.drawRect(0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			}
			
			addChild(backDrop);
			
			if(imageURL != null)
			{
				try
				{
					image = new Image(imageURL);
					image.alpha = 0;
					addChild(image);
					
					image.addEventListener(Event.COMPLETE, loadCompleteListener);
					image.addEventListener(ProgressEvent.PROGRESS, loadProgressListener);
					image.addEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
				}
				catch(e:Error)
				{
					catchLoadError(e);
				}
			}
			
			if(patternURL != null)
			{
				try
				{
					pattern = new Image(patternURL);
				
					pattern.addEventListener(Event.COMPLETE, patternCompleteListener);
					pattern.addEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
				}
				catch(e:Error)
				{
					catchLoadError(e);
				}
			}
		}
		
		private function createPattern():void
		{
			overlay = new Shape;
			overlay.graphics.beginBitmapFill(pattern.bitmapData);
			overlay.graphics.drawRect(0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			overlay.alpha = patternAlpha;
			addChild(overlay);
		}
		
		private function fadeImage():void
		{
			var imageAlpha:TweenLite = new TweenLite(image, fadeSpeed, {alpha:imageAlpha, ease:Linear.easeNone});
		}
		
		private function loadCompleteListener(e:Event):void
		{
			if(image != null)
			{
				e.currentTarget.removeEventListener(Event.COMPLETE, loadCompleteListener);
				e.currentTarget.removeEventListener(ProgressEvent.PROGRESS, loadProgressListener);
				e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
				imageRatio = image.width / image.height;
			}
			
			loading = false;
			
			dispatchEvent(new Event(Event.COMPLETE));
			
			fadeImage();
		}
		
		private function loadProgressListener(e:ProgressEvent):void
		{
			if(loading == false)
			{
				loading = true;
			}
		}
		
		private function patternCompleteListener(e:Event):void
		{
			if(pattern != null)
			{
				e.currentTarget.removeEventListener(Event.COMPLETE, loadCompleteListener);
				e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
			}
			
			createPattern();
		}
		
		private function loadErrorListener(e:IOErrorEvent):void
		{
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		
		private function catchLoadError(e:Error):void
		{
			throw new Error(Image.defaultLoadError);
		}
	}
}