package {
  import starling.display.Sprite;
  import starling.display.Quad;
  import starling.display.DisplayObject;
  import starling.text.TextField;
  import starling.events.Event;
  import starling.core.Starling;

  import utils.half;

  public class Game extends Sprite {
    public var isHW:Boolean = false;

    public function Game() {
      super();
      this.addEventListener( Event.ADDED_TO_STAGE, __onAddedToStage );
    }

    private function __isHW():void {
      var __s:Starling = Starling.current
      this.isHW = (__s.context.driverInfo.toLowerCase().indexOf("software") == -1);
    }

    private function __center(obj:DisplayObject):void {
      // divide by 2
      // obj.x = stage.stageWidth - obj.width >> 1;
      // obj.y = stage.stageHeight - obj.height >> 1;

      obj.x = half( stage.stageWidth - obj.width);
      obj.y = half( stage.stageHeight - obj.height);
    }

    private function __onAddedToStage(event:Event):void {
      trace("starling framework initialized!");

      var t:TextField = new TextField(200, 200, "Welcome to Starling!");
      __center(t);

      var q:Quad = new Quad(200, 200);
      q.setVertexColor(0, 0x000000);
      q.setVertexColor(1, 0xAA0000);
      q.setVertexColor(2, 0x00FF00);
      q.setVertexColor(3, 0x0000FF);
      __center(q);
      addChild( q );
      addChild( t );
    }
  }
}
