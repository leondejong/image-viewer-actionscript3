package com.leondejong.imageviewer.controller
{
	import flash.events.*;
	import flash.ui.*;
	
	import com.leondejong.imageviewer.model.*;
	
	public class Controller implements IController
	{
		public static const NEXT_BUTTON:String = "nextButton";
		public static const PREVIOUS_BUTTON:String = "previousButton";
		
		private var model:Object;
		
		public function Controller(model:IModel)
		{
			this.model = model;
		}
		
		public function keyInputHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.RIGHT :
				{
					(model as IModel).nextImage();
					break;
				}
				case Keyboard.LEFT :
				{
					(model as IModel).previousImage();
					break;
				}
			}
		}
		
		public function buttonInputHandler(e:MouseEvent):void
		{
			switch (e.currentTarget.getType())
			{
				case Controller.NEXT_BUTTON :
				{
					(model as IModel).nextImage();
					break;
				}
				case Controller.PREVIOUS_BUTTON :
				{
					(model as IModel).previousImage();
					break;
				}
			}
		}
	}
}