package {
  import flash.geom.Point;
  import starling.display.Sprite;
  import starling.display.Quad;
  import starling.display.DisplayObject;
  import starling.text.TextField;
  import starling.events.Event;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.core.Starling;
  import mx.controls.Alert;
  import utils.half;
  import utils.color;


  public class Game extends Sprite {
    public var isHW:Boolean = false;
    public var driver:String = "";
    private var __mouse:Array = [0,0];
    private var __c:Cube;

    public function Game() {
      super();
      var s:Starling = Starling.current;
      this.driver = s.context.driverInfo;
      this.isHW = (this.driver.toLowerCase().indexOf("software") == -1);
      this.addEventListener( Event.ADDED_TO_STAGE, __onAddedToStage );
    }

    private function __center(obj:DisplayObject):void {
      obj.x = half( stage.stageWidth - obj.width) + half(obj.width);
      obj.y = half( stage.stageHeight - obj.height) + half(obj.height);
    }

    private function __onAddedToStage(event:Event):void {
      trace("starling framework initialized!");

      __c = new Cube(300, 300);

      __center(__c);
      addChild( __c );

      stage.addEventListener(TouchEvent.TOUCH, __onTouch);
      stage.addEventListener(Event.ENTER_FRAME, __onFrame);
      __c.addEventListener(TouchEvent.TOUCH, __onTouched);
    }

    private function __onFrame(event:Event):void {
      // __c.x -= ( __c.x - __mouse[0] ) * .1;
      // __c.y -= ( __c.y - __mouse[1] ) * .1;
      __c.update();
    }

    private function __onTouch(event:TouchEvent):void {
      var touch:Touch = event.getTouch(stage);
      var pos:Point = touch.getLocation(stage);
      __mouse[0] = pos.x;
      __mouse[1] = pos.y;
    }

    private function __onTouched(event:TouchEvent):void {
      // var touch:Touch = event.getTouch(stage);
      // var clicked:DisplayObject = event.currentTarget as DisplayObject;
      /*
      if ( touch.phase == TouchPhase.ENDED ) {
        removeChild(clicked,true);
      }
      */
      var touches:Vector.<Touch> = event.touches;
      if( touches.length == 1 ) {
        __c.label(touches.length.toString());
      }
      if( touches.length == 2 ) {
        var finger1:Touch = touches[0];
        var finger2:Touch = touches[1];
        var distance:int;
        var dx:int;
        var dy:int;

        __c.label(touches.length.toString() + " "  
                  + finger1.phase.toString() + " "
                  + finger2.phase.toString() );
        // if both fingers moving (dragging)
        if ( finger1.phase == TouchPhase.MOVED && 
             finger2.phase == TouchPhase.MOVED ) {
          // calculate the distance between each axes
          dx = Math.abs ( finger1.globalX - finger2.globalX );
          dy = Math.abs ( finger1.globalY - finger2.globalY );
          distance = Math.sqrt(dx*dx+dy*dy);
          __c.label(distance.toString());
        }
      }
    }
  } // end class

} // end package
