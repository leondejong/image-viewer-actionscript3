package com.leondejong.imageviewer.utilities
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	public class Image extends Bitmap
	{
		
		public static var defaultURL:String = "images/image.jpg";
		public static var defaultLoadError:String = "An error occured while loading image";
		
		private var url:String;
		private var imageName:String;
		private var description:String;
		private var position:String;
		private var progress:Number;
		private var loader:Loader;
		private var loading:Boolean = false;
		
		public function Image(url:String = null)
		{
			setURL(url);
			load();
		}
		
		public function setURL(url:String):void
		{
			this.url = url;
		}
		
		public function getURL():String
		{
			if(url == null)
			{
				return Image.defaultURL;
			}
			else
			{
				return url;
			}
		}
		
		public function setLoadProgress(progress:Number):void
		{
			this.progress = progress;
		}
		
		public function getLoadProgress():Number
		{
			return progress;
		}
		
		public function load():void
		{
			loader = new Loader();
			addListeners(loader);
			
			try
			{
				loader.load(new URLRequest(getURL()));
				loading = true;
			}
			catch(e:Error)
			{
				catchLoadError(e);
			}
		}
		
		public function close():void
		{
			if(loader != null && loading)
			{
				loader.close();
			}
		}
		
		private function loadCompleteListener(e:Event):void
		{
			loading = false;
			removeListeners(loader);
			
			this.bitmapData = e.target.content.bitmapData;
			this.smoothing = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function progressListener(e:ProgressEvent):void
		{
			var loadPercentage:String = Math.round((e.bytesLoaded / e.bytesTotal) * 100) + "% loaded";
			setLoadProgress(e.bytesLoaded / e.bytesTotal);
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		private function addListeners(target:Loader):void
		{
			target.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteListener);
			target.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressListener);
			target.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
		}
		
		private function removeListeners(target:Loader):void
		{
			target.removeEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
			target.removeEventListener(ProgressEvent.PROGRESS, progressListener);
			target.removeEventListener(Event.COMPLETE, loadCompleteListener);
		}
		
		private function loadErrorListener(e:IOErrorEvent):void
		{
			trace("Image.loadErrorListener(): "+defaultLoadError);
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		
		private function catchLoadError(e:Error):void
		{
			trace("Image.catchLoadError(): "+defaultLoadError);
			throw new Error(defaultLoadError);
		}
	}
}