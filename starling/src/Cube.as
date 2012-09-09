package {
  import starling.display.Sprite;
  import starling.display.Quad;
  import starling.display.DisplayObject;
  import starling.text.TextField;
  import starling.events.Event;
  import starling.core.Starling;
  import mx.controls.Alert;
  import utils.half;
  import utils.color;


  public class Cube extends Sprite {
    private var __rgb:Array = [0,0,0]
    private var __rnd:Array = [0,0,0]
    private var __q:Quad;
    private var __s:Sprite;
    private var __t:TextField;
    private var __l:String = "Welcome to the Jungle!";
    private var __w:uint;
    private var __h:uint;

    public function Cube(w:Number=200,h:Number=200,color:uint=0xFFFFFF):void {
      __w = w;
      __h = h;
      __onColorReached();
      addEventListener(Event.ADDED_TO_STAGE,__activate);
    }


    private function __activate(e:Event):void {
      __q = new Quad(__w, __h);
      __t = new TextField(300, 20, __l, "Arial", 14, 0xFFFFFF);
      addChild(__q);
      addChild(__t);
      // change the registration point
      pivotX = __w >> 1;
      pivotY = __h >> 1;
    }


    public function update():void {
      var i:int; 
      for (i = 0; i < 3; i++)
        __rgb[i] -= (__rgb[i] - __rnd[i]) * .01;
      __q.color = color(__rgb);
  
      // when reaching the color, pick another one
      if ( Math.abs( __rgb[0] - __rnd[0] ) < 1 && 
           Math.abs( __rgb[1] - __rnd[1] ) < 1 && 
           Math.abs( __rgb[2] - __rnd[2] ) )
        __onColorReached();
      // (event.currentTarget as DisplayObject).rotation += .01;
      // rotation += .01;
    }

    public function label(s:String):void {
      __t.text = s;
    }

    // TODO: with event dispatch
    private function __onColorReached():void {
      var i:int; 
      for (i = 0; i < 3; i++)
        __rnd[i]=Math.random()*255;
    }
  } // end class

} // end package
