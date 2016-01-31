package com.leondejong.imageviewer.controller
{
	import flash.events.*;
	
	public interface IController
	{
		function keyInputHandler(e:KeyboardEvent):void;
		function buttonInputHandler(e:MouseEvent):void;
	}
}