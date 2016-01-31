package com.leondejong.imageviewer.view
{
	import flash.events.*;
	import flash.display.*;
	
	import com.leondejong.imageviewer.model.*;
	import com.leondejong.imageviewer.controller.*;
	
	public class RootView extends ACompositeView
	{
		public function RootView (model:IModel, controller:Object, target:Stage)
		{
			super(model, controller);
			target.addEventListener(KeyboardEvent.KEY_DOWN, keyInputHandler);
			target.frameRate = 60;
		}
		
		private function keyInputHandler(e:KeyboardEvent):void
		{
			(controller as IController).keyInputHandler(e);
		}
	}
}