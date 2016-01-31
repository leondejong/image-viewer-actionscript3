package com.leondejong.imageviewer.view
{
	import flash.events.Event;
	
	import com.leondejong.imageviewer.model.*;
	import com.leondejong.imageviewer.controller.*;
	
	// Abstract Class
	
	public class ACompositeView extends AComponentView
	{
		private var views:Array;
		
		public function ACompositeView(model:Object, controller:Object = null)
		{
			super(model, controller);
			this.views = new Array();
		}
		
		override public function add(c:AComponentView):void
		{
			views.push(c);
		}
		
		override public function remove(c:AComponentView):void
		{
			views.splice(views.indexOf(c), 1);
		}
		
		override public function getChild(n:int):AComponentView
		{
			return views[n];
		}
		
		override public function update(e:Event = null):void
		{
			for each (var c:AComponentView in views)
			{
				c.update(e);
			}
		}
	}
}