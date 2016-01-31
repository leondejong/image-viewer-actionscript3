package com.leondejong.imageviewer.view
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.display.Sprite;
	
	import com.leondejong.imageviewer.model.*;
	import com.leondejong.imageviewer.controller.*;
	
	// Abstract Class

	public class AComponentView extends Sprite
	{
		protected var model:Object;
		protected var controller:Object;
		
		public function AComponentView(model:Object, controller:Object = null)
		{
			this.model = model;
			this.controller = controller;
		}
		
		public function add(c:AComponentView):void
		{
			throw new IllegalOperationError("add operation not supported");
		}
		
		public function remove(c:AComponentView):void
		{
			throw new IllegalOperationError("remove operation not supported");
		}
		
		public function getChild(n:int):AComponentView
		{
			throw new IllegalOperationError("getChild operation not supported");
			return null;
		}
		
		public function update(e:Event = null):void {}
	}
}