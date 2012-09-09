package {
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import starling.core.Starling;

  DEBUG::stats {
    import net.hires.debug.Stats;
  }

  // SWF Stage
  [SWF(frameRate="24", width="800", height="600", backgroundColor="0x333333")]

  public class Main extends Sprite {
    private var __s:Starling;

    public function Main() {
      // hires stats
      DEBUG::stats {
        var stats:Stats;
        stats = new Stats();
        addChild(stats);
      }

      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;

      if( DEBUG::nogpu ) {
        __s = new Starling( Game, stage, null, null, Context3DRenderMode.SOFTWARE );
      }
      else {
        __s = new Starling( Game, stage );
      }

      // emulate multi-touch
      __s.simulateMultitouch = true;

      __s.antiAliasing = 1;
      __s.start();
    }
  } // end class

} // end package

