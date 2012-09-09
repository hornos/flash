package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.FileFilter;
    import flash.net.FileReference;
    import flash.utils.ByteArray;

    public class Compressor extends Sprite
    {
        private var ref:FileReference;

        public function Compressor()
        {
            ref = new FileReference();
            ref.addEventListener(Event.SELECT, load);
            ref.browse([new FileFilter("SWF Files", "*.swf")]);
        }

        private function load(e:Event):void
        {
            ref.addEventListener(Event.COMPLETE, processSWF);
            ref.load();
        }

        private function processSWF(e:Event):void
        {
            var swf:ByteArray;
            switch(ref.data.readMultiByte(3, "us-ascii"))
            {
                case "CWS":
                    swf = decompress(ref.data);
                    break;
                case "FWS":
                    swf = compress(ref.data);
                    break;
                default:
                    throw Error("Not SWF...");
                    break;
            }

            new FileReference().save(swf);
        }

        private function compress(data:ByteArray):ByteArray
       {
            var header:ByteArray = new ByteArray();
            var decompressed:ByteArray = new ByteArray();
            var compressed:ByteArray = new ByteArray();

            header.writeBytes(data, 3, 5); //read the header, excluding the signature
            decompressed.writeBytes(data, 8); //read the rest

            decompressed.compress();

            compressed.writeMultiByte("CWS", "us-ascii"); //mark as compressed
            compressed.writeBytes(header);
            compressed.writeBytes(decompressed);

            return compressed;
        }

        private function decompress(data:ByteArray):ByteArray
        {
            var header:ByteArray = new ByteArray();
            var compressed:ByteArray = new ByteArray();
            var decompressed:ByteArray = new ByteArray();

            header.writeBytes(data, 3, 5); //read the uncompressed header, excluding the signature
            compressed.writeBytes(data, 8); //read the rest, compressed

            compressed.uncompress();

            decompressed.writeMultiByte("FWS", "us-ascii"); //mark as uncompressed
            decompressed.writeBytes(header); //write the header back
            decompressed.writeBytes(compressed); //write the now uncompressed content

            return decompressed;
        }

    }
}
