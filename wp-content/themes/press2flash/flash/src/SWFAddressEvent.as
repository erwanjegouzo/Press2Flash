/**
 * SWFAddress 2.2: Deep linking for Flash and Ajax <http://www.asual.com/swfaddress/>
 *
 * SWFAddress is (c) 2006-2008 Rostislav Hristov and contributors
 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 *
 */
 
/**
 * @author Rostislav Hristov <http://www.asual.com>
 * @author Matthew J Tretter <http://www.exanimo.com>
 * @author Piotr Zema <http://felixz.mark-naegeli.com>
 */
package{

    import flash.events.Event;
    import SWFAddress;
    
    /**
     * Event class for SWFAddress.
     */
    public class SWFAddressEvent extends Event {
        
        /**
         * Init event.
         */
        public static const INIT:String = 'init';

        /**
         * Change event.
         */
        public static const CHANGE:String = 'change';
        
        private var _value:String;
        private var _path:String;
        private var _pathNames:Array;
        private var _parameters:Object;
        private var _parametersNames:Array;
        
        /**
         * Creates a new SWFAddress event.
         * @param type Type of the event.
         * @constructor
         */
        public function SWFAddressEvent(type:String) {
            super(type, false, false);
        }

        /**
         * The current target of this event.
         */
        public override function get currentTarget():Object {
            return SWFAddress;
        }

        /**
         * The target of this event.
         */
        public override function get type():String {
            return super.type;
        }

        /**
         * The target of this event.
         */
        public override function get target():Object {
            return SWFAddress;
        }

        /**
         * The value of this event.
         */
        public function get value():String {
            if (_value == null) {
                _value = SWFAddress.getValue();
            }
            return _value;
        }

        /**
         * The path of this event.
         */
        public function get path():String {
            if (_path == null) {
                _path = SWFAddress.getPath();
            }
            return _path;
        }
        
        /**
         * The folders in the deep linking path of this event.
         */         
        public function get pathNames():Array {
            if (_pathNames == null) {
                _pathNames = SWFAddress.getPathNames();
            }
            return _pathNames;
        }
        
        /**
         * The parameters of this event.
         */
        public function get parameters():Object {
            if (_parameters == null) {
                _parameters = new Object();
                for (var i:int = 0; i < parametersNames.length; i++) {
                    _parameters[parametersNames[i]] = SWFAddress.getParameter(parametersNames[i]);
                }
            }
            return _parameters;
        }
        
        /**
         * The parameters names of this event.
         */    
        public function get parametersNames():Array {
            if (_parametersNames == null) {
                _parametersNames = SWFAddress.getParameterNames();            
            }
            return _parametersNames;
        }
    
        /**
         * Clones this event.
         */
        public override function clone():Event {
            return new SWFAddressEvent(type);
        }
    
        /**
         * The string representation of the object.
         */
        public override function toString():String {
            return formatToString('SWFAddressEvent', 'type', 'bubbles', 'cancelable', 
                'eventPhase', 'value', 'path', 'pathNames', 'parameters', 'parametersNames');
        }
    }
}