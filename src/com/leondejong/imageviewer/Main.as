package com.leondejong.imageviewer
{
	import flash.display.*;
	import flash.events.*;
	
	import com.leondejong.imageviewer.model.*
	import com.leondejong.imageviewer.view.*
	import com.leondejong.imageviewer.controller.*
	
	public class Main extends Sprite
	{
		
		public function Main()
		{
			trace("ImageViewer by Léon de Jong");
			
			var model:IModel = new Model("images.xml");
			var controller:IController = new Controller(model);
			var rootview:ACompositeView = new RootView(model, controller, this.stage);
			var imageview:ImageView = new ImageView(model, controller, this.stage, "settings.xml");
			
			rootview.add(imageview);
			
			addChild(imageview);
			
			model.addEventListener(Event.CHANGE, rootview.update);
		}
	}
}