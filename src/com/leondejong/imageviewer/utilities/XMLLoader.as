package com.leondejong.imageviewer.utilities
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	public class XMLLoader extends EventDispatcher
	{
		public static var defaultLoadError:String = "An error occured while loading XML";
		
		private var loader:URLLoader;
		private var loading:Boolean = false;
		private var xml:XML;
		
		public function XMLLoader(url:String = null)
		{
			if(url != null)
			{
				load(url);
			}
		}
		
		public function setXML(xml:XML):void
		{
			this.xml = new XML(xml);
		}
		
		public function getXML():XML
		{
			return xml;
		}
		
		public function load(url:String):void
		{
			loader = new URLLoader();
			addListeners(loader);
			try
			{
				loader.load(new URLRequest(url));
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
			removeListeners(URLLoader(e.currentTarget));
			setXML(new XML(e.target.data));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function loadProgressListener(e:ProgressEvent):void
		{
			var loadProgress:String = Math.round((e.bytesLoaded / e.bytesTotal) * 100) + "% loaded";
		}
		
		private function addListeners(target:URLLoader):void
		{
			target.addEventListener(Event.COMPLETE, loadCompleteListener);
			target.addEventListener(ProgressEvent.PROGRESS, loadProgressListener);
			target.addEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
		}
		
		private function removeListeners(target:URLLoader):void
		{
			target.removeEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
			target.removeEventListener(ProgressEvent.PROGRESS, loadProgressListener);
			target.removeEventListener(Event.COMPLETE, loadCompleteListener);
		}
		
		private function loadErrorListener(e:IOErrorEvent):void
		{
			trace("XMLLoader.loadErrorListener(): "+defaultLoadError);
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		
		private function catchLoadError(e:Error):void
		{
			trace("XMLLoader.catchLoadError(): "+defaultLoadError);
			throw new Error(defaultLoadError);
		}
	}
}