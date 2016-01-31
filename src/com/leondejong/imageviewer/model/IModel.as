package com.leondejong.imageviewer.model
{
	import flash.events.*;
	
	public interface IModel extends IEventDispatcher
	{
		function firstImage():void;
		function lastImage():void;
		function nextImage():void;
		function previousImage():void;
		
		function getCurrentURL():String;
		function getCurrentName():String;
		function getCurrentDescription():String;
		function getCurrentPosition():uint;
		function getTotalImages():uint;
	}
}