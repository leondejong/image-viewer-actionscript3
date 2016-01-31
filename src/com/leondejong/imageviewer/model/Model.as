package com.leondejong.imageviewer.model
{
	import flash.events.*;
	import flash.net.*;
	
	import com.leondejong.imageviewer.utilities.*;
	
	public class Model extends EventDispatcher implements IModel
	{
		public static var defaultURL:String = "images/image.jpg";
		public static var defaultName:String = "Unnamed Image";
		public static var defaultDescription:String = "No Description Supplied";
		public static var defaultPosition:String = "0 / 0";
		private static var initialPosition:uint = 1;
		
		private var xml:XML;
		private var imageList:Array;
		private var currentURL:String;
		private var currentName:String;
		private var currentDescription:String;
		private var currentPosition:uint;
		private var totalImages:uint;
		private var loop:Boolean;
		
		public function Model(url:String = null)
		{
			setLoop(true);
			
			if(url != null)
			{
				loadXML(url);
			}
		}
		
		private function setXML(xml:XML):void
		{
			this.xml = xml;
		}
		
		public function getXML():XML
		{
			return xml;
		}
		
		private function setCurrentURL(currentURL:String):void
		{
			this.currentURL = currentURL;
		}
		
		public function getCurrentURL():String
		{
			if(currentURL == null)
			{
				return Model.defaultURL;
			}
			else
			{
				return currentURL;
			}
		}
		
		private function setCurrentName(currentName:String):void
		{
			this.currentName = currentName;
		}
		
		public function getCurrentName():String
		{
			if(currentName == null)
			{
				return Model.defaultName;
			}
			else
			{
				return currentName;
			}
		}
		
		private function setCurrentDescription(currentDescription:String):void
		{
			this.currentDescription = currentDescription;
		}
		
		public function getCurrentDescription():String
		{
			if(currentDescription == null)
			{
				return Model.defaultDescription;
			}
			else
			{
				return currentDescription;
			}
		}
		
		private function setCurrentPosition(currentPosition:uint):void
		{
			this.currentPosition = currentPosition;
		}
		
		public function getCurrentPosition():uint
		{
			if(currentPosition == 0)
			{
				return Model.initialPosition;
			}
			else
			{
				return currentPosition;
			}
		}
		
		private function setTotalImages(totalImages:uint):void
		{
			this.totalImages = totalImages;
		}
		
		public function getTotalImages():uint
		{
			return totalImages;
		}
		
		public function setLoop(loop:Boolean):void
		{
			this.loop = loop;
		}
		
		public function getLoop():Boolean
		{
			return loop;
		}
		
		public function firstImage():void
		{	
			if(getXML() != null)
			{
				setTotalImages(getXML().image.length());
				setCurrentPosition(1);
				setCurrentURL(getXML().image[0].url);
				setCurrentName(getXML().image[0].name);
				setCurrentDescription(getXML().image[0].description);
				
				dispatchEvent(new Event(Event.CHANGE));
			}
			else
			{
				trace("Model.firstImage(): xml == null");
			}
		}
		
		public function lastImage():void
		{	
			if(getXML() != null)
			{
				setTotalImages(getXML().image.length());
				setCurrentPosition(getTotalImages());
				setCurrentURL(getXML().image[getTotalImages()-1].url);
				setCurrentName(getXML().image[getTotalImages()-1].name);
				setCurrentDescription(getXML().image[getTotalImages()-1].description);
				
				dispatchEvent(new Event(Event.CHANGE));
			}
			else
			{
				trace("Model.lastImage(): xml == null");
			}
		}
		
		public function nextImage():void
		{
			if(getXML() != null)
				{
				if(getCurrentPosition() < getTotalImages())
				{
					setCurrentPosition(getCurrentPosition()+1);
					setCurrentURL(getXML().image[getCurrentPosition()-1].url);
					setCurrentName(getXML().image[getCurrentPosition()-1].name);
					setCurrentDescription(getXML().image[getCurrentPosition()-1].description);
					
					dispatchEvent(new Event(Event.CHANGE));
				}
				else if(loop && getCurrentPosition() == getTotalImages())
				{
					firstImage();
				}
				else
				{
					trace("Model.nextImage(): Last Image");
				}
			}
			else
			{
				trace("Model.nextImage(): xml == null");
			}
		}
		
		public function previousImage():void
		{
			if(getXML() != null)
			{
				if(getCurrentPosition() > 1)
				{
					setCurrentPosition(getCurrentPosition()-1);
					setCurrentURL(getXML().image[getCurrentPosition()-1].url);
					setCurrentName(getXML().image[getCurrentPosition()-1].name);
					setCurrentDescription(getXML().image[getCurrentPosition()-1].description);
					
					dispatchEvent(new Event(Event.CHANGE));
				}
				else if(loop && getCurrentPosition() == 1)
				{
					lastImage();
				}
				else
				{
					trace("Model.previousImage(): First Image");
				}
			}
			else
			{
				trace("Model.previousImage(): xml == null");
			}
		}
		
		public function loadXML(url:String):void
		{
			try
			{
				var xmlloader:XMLLoader = new XMLLoader(url);
				xmlloader.addEventListener(Event.COMPLETE, loadCompleteListener);
				xmlloader.addEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
			}
			catch(e:Error)
			{
				catchLoadError(e);
			}
		}
		
		private function loadCompleteListener(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, loadCompleteListener);
			e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, loadErrorListener);
			setXML(e.currentTarget.getXML());
			firstImage();
		}
		
		private function loadErrorListener(e:IOErrorEvent):void
		{
			dispatchEvent(new Event(IOErrorEvent.IO_ERROR));
		}
		
		private function catchLoadError(e:Error):void
		{
			throw new Error(XMLLoader.defaultLoadError);
		}
	}
}