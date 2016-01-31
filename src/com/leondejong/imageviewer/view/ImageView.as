package com.leondejong.imageviewer.view
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	import com.leondejong.imageviewer.model.*;
	import com.leondejong.imageviewer.controller.*;
	import com.leondejong.imageviewer.utilities.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class ImageView extends AComponentView
	{
		private var image:Image;
		private var imageRatio:Number;
		
		private var background:Background;
		private var backgroundRatio:Number;
		
		private var frame:Shape;
		
		private var textBars:Sprite;
		private var topBar:TextBar;
		private var bottomBar:TextBar;
		private var positionText:TextField;
		
		private var nextButton:BrowseButton;
		private var previousButton:BrowseButton;
		
		private var preloader:Preloader;
		
		private var settings:Settings;
		private var target:Stage;
		private var stageRatio:Number;
		private var fieldRatio:Number;
		private var tag:Tag;
		private var loading:Boolean;
		private var initialized:Boolean;
		
		public function ImageView(model:IModel, controller:Object, target:Stage, url:String = "settings.xml")
		{
			super(model, controller);
			
			this.target = target;
			target.scaleMode = StageScaleMode.NO_SCALE;
			target.align = StageAlign.TOP_LEFT;
			target.addEventListener(Event.RESIZE, stageResizeListener);
			
			loading = false;
			initialized = false;
			
			loadSettings(url);
		}
		
		private function loadSettings(url:String):void
		{
			settings = new Settings(url);
			settings.addEventListener(Event.COMPLETE, settingsCompleteListener);
		}
		
		private function initializeObjects():void
		{
			createBackground();
			addBackground();
			//removeBackground();
			
			createFrame();
			addFrame();
			//removeFrame();
			
			createTextBars();
			addTextBars();
			//removeTextBars();
			
			createPreloader();
			addPreloader();
			//removePreloader();
			
			createButtons();
			addButtons();
			//removeButtons();
			
			createTag();
			addTag();
			//removeTag();
			
			initialized = true;
			
			model.firstImage();
		}
		
		override public function update(event:Event = null):void
		{
			if(initialized)
			{
				updateImage();
				updateText();
				updateButtons();
			}
		}
		
		private function updateImage():void
		{
			if(model != null)
			{
				createImage(model.getCurrentURL());
				addImage();
				//removeImage();
			}
		}
		
		private function updateText():void
		{
			if(model != null && textBars != null)
			{
				topBar.textField.replaceText(0, topBar.textField.length, model.getCurrentName());
				bottomBar.textField.replaceText(0, bottomBar.textField.length, model.getCurrentDescription());
				positionText.replaceText(0, positionText.length, model.getCurrentPosition() + " / " + model.getTotalImages());
			}
		}
		
		private function updateButtons():void
		{
			if(model != null && !model.getLoop())
			{
				if(model.getCurrentPosition() == 1)
				{
					disablePreviousButton();
				}
				else if(model.getCurrentPosition() == model.getTotalImages())
				{
					disableNextButton();
				}
				else
				{
					enableButtons();
				}
			}
		}
		
		private function createImage(imageURL:String = null):void
		{
			try
			{
				removeImage();
				image = new Image(imageURL);
				image.alpha = 0;
				image.addEventListener(Event.COMPLETE, loadCompleteListener);
				image.addEventListener(ProgressEvent.PROGRESS, loadProgressListener);
				image.addEventListener(IOErrorEvent.IO_ERROR, errorListener);
			}
			catch(e:Error)
			{
				catchError(e);
			}
		}
		
		private function addImage():void
		{
			if(image != null && !this.contains(image))
			{
				addChild(image);
			}
		}
		
		private function removeImage():void
		{
			if(image != null && this.contains(image))
			{
				if(loading)
				{
					image.close();
					loading = false;
				}
				removeChild(image);
				image = null;
			}
		}
		
		private function animateObjects():void
		{
			if(image != null && frame != null)
			{
				var imageWidth:int = int(image.width + (settings.imageBorder * 2));
				var imageHeight:int = int(image.height + (settings.imageBorder * 2));
				
				if(frame.width != imageWidth || frame.height != imageHeight)
				{
					var frameSize:TweenLite = new TweenLite(frame, settings.frameAnimationSpeed, {width:imageWidth, height:imageHeight, ease:Expo.easeOut, onComplete:tweenImage});
				}
				else
				{
					tweenImage();
				}
				
				function tweenImage():void
				{
					var imageAlpha:TweenLite = new TweenLite(image, settings.fadeSpeed, {alpha:settings.imageAlpha, ease:Linear.easeNone});
				}
			}
		}
		
		private function createBackground():void
		{
			if(target != null)
			{
				try
				{
					background = new Background(settings.backgroundColor, settings.backgroundImageURL, settings.backgroundPatternURL, settings.backgroundImageAlpha, settings.backgroundPatternAlpha, settings.backgroundImageFadeSpeed, target);
					background.addEventListener(Event.COMPLETE, backgroundCompleteListener);
					background.addEventListener(IOErrorEvent.IO_ERROR, errorListener);
					addChild(background);
				}
				catch(e:Error)
				{
					catchError(e);
				}
			}
		}
		
		private function addBackground():void
		{
			if(background != null && !this.contains(background))
			{
				addChild(background);
			}
		}
		
		private function removeBackground():void
		{
			if(background != null && this.contains(background))
			{
				removeChild(background);
			}
		}
		
		private function createPreloader():void
		{
			if(target != null)
			{
				var preloaderY:int = int(target.stage.stageHeight/2);
				var preloaderWidth:int = int(target.stage.stageWidth - (settings.buttonSize * 2));
				
				preloader = new Preloader(settings.buttonSize, preloaderY, preloaderWidth, 1, settings.preloaderBackgroundColor, settings.preloaderLoadbarColor);
				preloader.resetProgress();
				preloader.alpha = settings.preloaderAlpha;
			}
		}
		
		private function addPreloader():void
		{
			if(preloader != null && !this.contains(preloader) && loading)
			{
				preloader.resetProgress();
				addChild(preloader);
			}
		}
		
		private function removePreloader():void
		{
			if(preloader != null && this.contains(preloader) && !loading)
			{
				removeChild(preloader);
			}
		}
		
		private function createFrame():void
		{
			if(target != null)
			{
				var frameX:int = int(-target.stageWidth / 2);
				var frameY:int = int(-target.stageHeight / 2);
				
				var frameWidth:int = int(target.stageWidth);
				var frameHeight:int = int(target.stageHeight);
				
				frame = new Shape();
				frame.graphics.beginFill(settings.frameColor);
				frame.graphics.drawRect(frameX, frameY, frameWidth, frameHeight);
				frame.x = target.stageWidth / 2;
				frame.y = target.stageHeight / 2;
				frame.alpha = settings.frameAlpha;
			}
		}
		
		private function addFrame():void
		{
			if(frame != null && !this.contains(frame))
			{
				addChild(frame);
			}
		}
		
		private function removeFrame():void
		{
			if(frame != null && this.contains(frame))
			{
				removeChild(frame);
			}
		}
		
		private function createTextBars():void
		{
			if(target != null)
			{
				topBar = new TextBar(target.stageWidth, settings.barHeight, settings.topBarColor, settings.topBarAlpha, settings.topBarShadeAlpha, settings.textTypeFace, settings.textMargin, settings.nameSize, settings.nameColor, settings.nameAlign, Model.defaultName);
				bottomBar = new TextBar(target.stageWidth, settings.barHeight, settings.bottomBarColor, settings.bottomBarAlpha, settings.bottomBarShadeAlpha, settings.textTypeFace, settings.textMargin, settings.descriptionSize, settings.descriptionColor, settings.descriptionAlign, Model.defaultDescription);
				bottomBar.y = target.stageHeight - settings.barHeight;
				
				var positionFormat = new TextFormat();
				positionFormat.font = settings.textTypeFace;
				positionFormat.size = settings.positionSize;
				positionFormat.align = settings.positionAlign;
				positionFormat.color = settings.positionColor;
				
				positionText = new TextField();
				positionText.embedFonts = true;
				positionText.antiAliasType = flash.text.AntiAliasType.ADVANCED;
				positionText.x = settings.textMargin;
				positionText.width = target.stageWidth - (settings.textMargin * 2);
				positionText.height = settings.barHeight;
				positionText.selectable = false;
				positionText.text = Model.defaultPosition;
				positionText.setTextFormat(positionFormat);
				positionText.defaultTextFormat = positionFormat;
				
				textBars = new Sprite();
				textBars.addChild(topBar);
				textBars.addChild(bottomBar);
				textBars.addChild(positionText);
			}
		}
		
		private function addTextBars():void
		{
			if(textBars != null && target != null)
			{
				addChild(textBars);
			}
		}
		
		private function removeTextBars():void
		{
			if(textBars != null && target != null)
			{
				removeChild(textBars);
			}
		}
		
		private function createButtons():void
		{
			if(target != null)
			{
				nextButton = new BrowseButton(Controller.NEXT_BUTTON, settings.buttonSize, settings.nextButtonAlpha, settings.nextButtonShadeAlpha, settings.nextButtonUpBackgroundColor, settings.nextButtonOverBackgroundColor, settings.nextButtonDownBackgroundColor, settings.nextButtonUpArrowColor, settings.nextButtonOverArrowColor, settings.nextButtonDownArrowColor);
				
				var nextButtonX:int = int(target.stageWidth - nextButton.width);
				var nextButtonY:int = int((target.stageHeight / 2) - (nextButton.width /2));
				
				nextButton.x = nextButtonX;
				nextButton.y = nextButtonY;
				
				previousButton = new BrowseButton(Controller.PREVIOUS_BUTTON, settings.buttonSize, settings.previousButtonAlpha, settings.previousButtonShadeAlpha, settings.previousButtonUpBackgroundColor, settings.previousButtonOverBackgroundColor, settings.previousButtonDownBackgroundColor, settings.previousButtonUpArrowColor, settings.previousButtonOverArrowColor, settings.previousButtonDownArrowColor);
				
				var previousButtonX:int = 0;
				var previousButtonY:int = int((target.stageHeight / 2) - (previousButton.width /2));
				
				previousButton.x = previousButtonX;
				previousButton.y = previousButtonY;
			}
		}
		
		private function addButtons():void
		{
			if(nextButton != null && previousButton != null && !this.contains(nextButton) && !this.contains(previousButton))
			{
				addChild(nextButton);
				nextButton.addEventListener(MouseEvent.CLICK, buttonInputHandler);
				addChild(previousButton);
				previousButton.addEventListener(MouseEvent.CLICK, buttonInputHandler);
			}
		}
		
		private function removeButtons():void
		{
			if(nextButton != null && previousButton != null && this.contains(nextButton) && this.contains(previousButton))
			{
				removeChild(nextButton);
				nextButton.removeEventListener(MouseEvent.CLICK, buttonInputHandler);
				removeChild(previousButton);
				previousButton.removeEventListener(MouseEvent.CLICK, buttonInputHandler);
			}
		}
		
		private function disableNextButton():void
		{
			if(nextButton != null && nextButton.enabled)
			{
				nextButton.alpha = settings.disabledNextButtonAlpha;
				nextButton.enabled = false;
				nextButton.removeEventListener(MouseEvent.CLICK, buttonInputHandler);
			}
		}
		
		private function disablePreviousButton():void
		{
			if(previousButton != null && previousButton.enabled)
			{
				previousButton.alpha = settings.disabledPreviousButtonAlpha;
				previousButton.enabled = false;
				previousButton.removeEventListener(MouseEvent.CLICK, buttonInputHandler);
			}
		}
		
		private function enableButtons():void
		{
			if(nextButton != null && !nextButton.enabled)
			{
				nextButton.alpha = settings.nextButtonAlpha;
				nextButton.enabled = true;
				nextButton.addEventListener(MouseEvent.CLICK, buttonInputHandler);
			}
			
			if(previousButton != null && !previousButton.enabled)
			{
				previousButton.alpha = settings.previousButtonAlpha;
				previousButton.enabled = true;
				previousButton.addEventListener(MouseEvent.CLICK, buttonInputHandler);
			}
		}
		
		private function positionComponents():void
		{
			positionBackground();
			positionImage();
			positionFrame();
			positionTextBars();
			positionButtons();
			positionPreloader();
			positionTag();
		}
		
		private function positionBackground():void
		{
			background.backDrop.width = int(target.stageWidth);
			background.backDrop.height = int(target.stageHeight);
			
			if(background != null && background.image != null && background.image.bitmapData != null && target != null)
			{
				var backgroundHeight:int;
				var backgroundWidth:int;
				
				stageRatio = target.stageWidth / target.stageHeight;
				
				if(background.imageRatio > stageRatio)
				{
					backgroundHeight = int(target.stageHeight);
					backgroundWidth = int(backgroundHeight * background.imageRatio);
				}
				else
				{
					backgroundWidth = int(target.stageWidth);
					backgroundHeight = int(backgroundWidth / background.imageRatio);
				}
				
				var backgroundX:int = int((target.stageWidth / 2) - (backgroundWidth / 2));
				var backgroundY:int = int((target.stageHeight / 2) - (backgroundHeight / 2));
				
				background.image.width = backgroundWidth;
				background.image.height = backgroundHeight;
				
				background.image.x = backgroundX;
				background.image.y = backgroundY;
			}
		}
		
		private function positionFrame():void
		{
			if(frame != null && image != null  && frame.width != 0 && image.width != 0)
			{
				var frameX:int = int(target.stageWidth / 2);
				var frameY:int = int(target.stageHeight / 2);
				var frameWidth:int = int(image.width + (settings.imageBorder * 2));
				var frameHeight:int = int(image.height + (settings.imageBorder * 2));
				
				frame.x = frameX;
				frame.y = frameY;
				frame.width = frameWidth;
				frame.height = frameHeight;
			}
		}
		
		private function positionImage():void
		{
			if(image != null && target != null)
			{
				var imageWidth:int;
				var imageHeight:int;
				
				fieldRatio = (target.stageWidth - (settings.buttonSize * 2)) / (target.stageHeight - (settings.barHeight * 2));
				
				if(image.bitmapData.width <= target.stageWidth - (settings.imageMargin * 2) - (settings.buttonSize * 2) && image.bitmapData.height <= target.stageHeight - (settings.imageMargin * 2) - (settings.barHeight * 2))
				{
					imageWidth = image.bitmapData.width;
					imageHeight = image.bitmapData.height;
				}
				else
				{
					if(imageRatio > fieldRatio)
					{
						imageWidth = int(target.stageWidth - (settings.imageMargin * 2) - (settings.buttonSize * 2));
						imageHeight = int(imageWidth / imageRatio);
					}
					else
					{
						imageHeight = int(target.stageHeight - (settings.imageMargin * 2) - (settings.barHeight * 2));
						imageWidth = int(imageHeight * imageRatio);
					}
				}
				
				var imageX:int = int((target.stageWidth / 2) - (imageWidth / 2));
				var imageY:int = int((target.stageHeight / 2) - (imageHeight / 2));
				
				image.width = imageWidth;
				image.height = imageHeight;
				
				image.x = imageX;
				image.y = imageY;
			}
		}
		
		private function positionTextBars():void
		{
			if(textBars != null && target != null)
			{
				topBar.bar.width = target.stageWidth;
				topBar.textField.width = target.stageWidth;
				
				bottomBar.y = target.stageHeight - settings.barHeight;
				bottomBar.bar.width = target.stageWidth;
				bottomBar.textField.width = target.stageWidth;
				
				positionText.width = target.stageWidth - (settings.textMargin * 2);
			}
		}
		
		private function positionButtons():void
		{
			if(nextButton != null && previousButton != null && target != null)
			{
				nextButton.x = target.stageWidth - nextButton.width;
				nextButton.y = (target.stageHeight / 2) - (nextButton.width /2);
				previousButton.x = 0;
				previousButton.y = (target.stageHeight / 2) - (nextButton.width /2);
			}
		}
		
		private function positionPreloader():void
		{
			if(preloader != null && image != null && preloader.width != 0 && image.width != 0)
			{
				var preloaderX:int = int(image.x - settings.imageBorder);
				var preloaderY:int = int(image.y + (image.height / 2));
				var preloaderWidth:int = int(image.width + (settings.imageBorder * 2));
				
				preloader.x = preloaderX;
				preloader.y = preloaderY;
				preloader.width = preloaderWidth;
			}
		}
		
		private function loadCompleteListener(e:Event):void
		{
			if(image != null)
			{
				e.currentTarget.removeEventListener(Event.COMPLETE, loadCompleteListener);
				e.currentTarget.removeEventListener(ProgressEvent.PROGRESS, loadProgressListener);
				e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, errorListener);
				imageRatio = image.width / image.height;
			}
			
			loading = false;
			
			removePreloader();
			
			positionBackground();
			positionImage();
			//positionFrame();
			positionTextBars();
			positionButtons();
			positionPreloader();
			positionTag();
			
			animateObjects();
		}
		
		private function settingsCompleteListener(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, settingsCompleteListener);
			
			initializeObjects();
		}
		
		private function backgroundCompleteListener(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, backgroundCompleteListener);
			e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, errorListener);
			
			positionBackground();
		}
		
		private function loadProgressListener(e:ProgressEvent):void
		{
			if(loading == false)
			{
				loading = true;
				addPreloader();
			}
			else if(preloader != null)
			{
				preloader.updateProgress(e.currentTarget.getLoadProgress());
			}
		}
		
		private function errorListener(e:IOErrorEvent):void
		{
			// handle error
		}
		
		private function catchError(e:Error):void
		{
			// handle error
		}
		
		private function buttonInputHandler(e:MouseEvent):void
		{
			(controller as IController).buttonInputHandler(e);
		}
		
		private function stageResizeListener(e:Event):void
		{
			positionComponents();
		}
		
		private function createTag():void
		{
			tag = new Tag();
			positionTag();
		}
		
		private function addTag():void
		{
			if(tag != null && !this.contains(tag))
			{
				addChild(tag);
			}
		}
		
		private function removeTag():void
		{
			if(tag != null && this.contains(tag))
			{
				removeChild(tag);
			}
		}
		
		private function positionTag():void
		{
			if(tag != null && this.contains(tag))
			{
				tag.x = Math.round(this.stage.stageWidth - tag.width);
				tag.y = Math.round((this.stage.stageHeight * .75) + (tag.height / 2));
			}
		}
	}
}