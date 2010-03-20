/**
 * SWFAddress 2.2: Deep linking for Flash and Ajax <http://www.asual.com/swfaddress/>
 *
 * SWFAddress is (c) 2006-2008 Rostislav Hristov and contributors
 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 *
 */

/**
 * @author Rostislav Hristov <http://www.asual.com>
 * @author Mark Ross <http://www.therossman.org>
 * @author Piotr Zema <http://felixz.mark-naegeli.com>
 */
package{

    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.external.ExternalInterface;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.system.Capabilities;
    import flash.utils.Timer;
    import SWFAddressEvent;
    
    [Event(name='init', type='SWFAddressEvent')]    
    [Event(name='change', type='SWFAddressEvent')]

    /**
     * SWFAddress class. 
     */ 
    public class SWFAddress {
    
        private static var _init:Boolean = false;
        private static var _initChange:Boolean = false;        
        private static var _strict:Boolean = true;
        private static var _value:String = '';
        private static var _timer:Timer = null;
        private static var _availability:Boolean = ExternalInterface.available;
        private static var _dispatcher:EventDispatcher = new EventDispatcher();

        /**
         * Init event.
         */
        public static var onInit:Function;
        
        /**
         * Change event.
         */
        public static var onChange:Function;

        public function SWFAddress() {
            throw new IllegalOperationError("SWFAddress cannot be instantiated.");
        }
        
        private static function _initialize():Boolean {
            if (_availability) {
                ExternalInterface.addCallback('getSWFAddressValue', 
                    function():String {return _value});
                ExternalInterface.addCallback('setSWFAddressValue', 
                    _setValue);
            }
            if (_timer == null) {
                _timer = new Timer(10);
                _timer.addEventListener(TimerEvent.TIMER, _check);
            }
            _timer.start();
            return true;
        }
        private static var _initializer:Boolean = _initialize();
        
        private static function _check(e:TimerEvent):void {
            if ((typeof SWFAddress['onInit'] == 'function' || _dispatcher.hasEventListener('init')) && !_init) {
                SWFAddress._setValueInit(_getValue());
                SWFAddress._init = true;                
            }
            if (typeof SWFAddress['onChange'] == 'function' || _dispatcher.hasEventListener('change')) {
                _timer.stop();
                SWFAddress._init = true;
                SWFAddress._setValueInit(_getValue());
            }
        }
        
        private static function _strictCheck(value:String, force:Boolean):String {
            if (SWFAddress.getStrict()) {
                if (force) {
                    if (value.substr(0, 1) != '/') value = '/' + value;
                } else {
                    if (value == '') value = '/';
                }
            }
            return value;
        }

        private static function _getValue():String {
            var value:String, ids:String = null;
            if (_availability) { 
                value = ExternalInterface.call('SWFAddress.getValue') as String;
                var arr:Array = ExternalInterface.call('SWFAddress.getIds') as Array;
                if (arr != null)
                    ids = arr.toString(); 
            }
            if (ids == null || !_availability) {
                value = SWFAddress._value;
            } else {
                if (value == 'undefined' || value == null) value = '';
            }
            return _strictCheck(value || '', false);
        }

        private static function _setValueInit(value:String):void {        
            SWFAddress._value = value;
            if (!_init) {
                _dispatchEvent(SWFAddressEvent.INIT);
            } else {
                _dispatchEvent(SWFAddressEvent.CHANGE);
            }
            _initChange = true;
        }        

        private static function _setValue(value:String):void {        
            if (value == 'undefined' || value == null) value = '';
            if (SWFAddress._value == value && SWFAddress._init) return;
            if (!SWFAddress._initChange) return;
            SWFAddress._value = value;
            if (!_init) {
                SWFAddress._init = true;
                if (typeof SWFAddress['onInit'] == 'function' || _dispatcher.hasEventListener('init')) {
                    _dispatchEvent(SWFAddressEvent.INIT);
                }
            }
            _dispatchEvent(SWFAddressEvent.CHANGE);
        }        
        
        private static function _dispatchEvent(type:String):void {
            if (_dispatcher.hasEventListener(type)) {
                _dispatcher.dispatchEvent(new SWFAddressEvent(type));
            }
            type = type.substr(0, 1).toUpperCase() + type.substring(1);
            if (typeof SWFAddress['on' + type] == 'function') {
                SWFAddress['on' + type]();
            }
        }

        /**
         * Loads the previous URL in the history list.
         */
        public static function back():void {
            if (_availability)
                ExternalInterface.call('SWFAddress.back');
        }

        /**
         * Loads the next URL in the history list.
         */
        public static function forward():void {
            if (_availability)
                ExternalInterface.call('SWFAddress.forward');
        }

        /**
         * Navigates one level up in the deep linking path.
         */
        public static function up():void {
            var path:String = SWFAddress.getPath();
            SWFAddress.setValue(path.substr(0, path.lastIndexOf('/', path.length - 2) + (path.substr(path.length - 1) == '/' ? 1 : 0)));
        }
        
        /**
         * Loads a URL from the history list.
         * @param delta An integer representing a relative position in the history list.
         */
        public static function go(delta:int):void {
            if (_availability)
                ExternalInterface.call('SWFAddress.go', delta);
        }
        
        /**
         * Opens a new URL in the browser. 
         * @param url The resource to be opened.
         * @param target Target window.
         */
        public static function href(url:String, target:String = '_self'):void {
            if (_availability && Capabilities.playerType == 'ActiveX') {
                ExternalInterface.call('SWFAddress.href', url, target);
                return;
            }
            navigateToURL(new URLRequest(url), target);
        }

        /**
         * Opens a browser popup window. 
         * @param url Resource location.
         * @param name Name of the popup window.
         * @param options Options which get evaluted and passed to the window.open() method.
         * @param handler Optional JavsScript handler code for popup handling.    
         */
        public static function popup(url:String, name:String='popup', options:String='""', handler:String=''):void {
            if (_availability && (Capabilities.playerType == 'ActiveX' || ExternalInterface.call('asual.util.Browser.isSafari'))) {
                ExternalInterface.call('SWFAddress.popup', url, name, options, handler);
                return;
            }
            navigateToURL(new URLRequest('javascript:popup=window.open("' + url + '","' + name + '",' + options + ');' 
                + handler + ';void(0);'), '_self');
        }
        
        /**
         * Registers an event listener.
         * @param type Event type.
         * @param listener Event listener.
         * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
         * @param priority The priority level of the event listener.
         * @param useWeakReference Determines whether the reference to the listener is strong or weak.
         */
        public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, 
            useWeakReference:Boolean = false):void {
            _dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        /**
         * Removes an event listener.
         * @param type Event type.
         * @param listener Event listener.
         */
        public static function removeEventListener(type:String, listener:Function):void {
            _dispatcher.removeEventListener(type, listener, false);
        }

        /**
         * Dispatches an event to all the registered listeners. 
         * @param event Event object.
         */
        public static function dispatchEvent(event:Event):Boolean {
            return _dispatcher.dispatchEvent(event);
        }

        /**
         * Checks the existance of any listeners registered for a specific type of event. 
         * @param event Event type.
         */
        public static function hasEventListener(type:String):Boolean {
            return _dispatcher.hasEventListener(type);
        }

        /**
         * Provides the base address of the document. 
         */
        public static function getBaseURL():String {
            var url:String = null;
            if (_availability)
                url = String(ExternalInterface.call('SWFAddress.getBaseURL'));
            return (url == null || url == 'null' || !_availability) ? '' : url;
        }

        /**
         * Provides the state of the strict mode setting. 
         */
        public static function getStrict():Boolean {
            var strict:String = null;
            if (_availability)
                strict = ExternalInterface.call('SWFAddress.getStrict') as String;
            return (strict == null) ? _strict : (strict == 'true');
        }

        /**
         * Enables or disables the strict mode.
         * @param {Boolean} strict Strict mode state.
         */
        public static function setStrict(strict:Boolean):void {
            if (_availability)
                ExternalInterface.call('SWFAddress.setStrict', strict);
            _strict = strict;
        }

        /**
         * Provides the state of the history setting. 
         */
        public static function getHistory():Boolean {
            return (_availability) ? 
                ExternalInterface.call('SWFAddress.getHistory') as Boolean : false;
        }

        /**
         * Enables or disables the creation of history entries.
         * @param {Boolean} history History state.
         */
        public static function setHistory(history:Boolean):void {
            if (_availability)
                ExternalInterface.call('SWFAddress.setHistory', history);
        }

        /**
         * Provides the tracker function.
         */
        public static function getTracker():String {
            return (_availability) ? 
                ExternalInterface.call('SWFAddress.getTracker') as String : '';
        }

        /**
         * Sets a function for page view tracking. The default value is 'urchinTracker'.
         * @param tracker Tracker function.
         */
        public static function setTracker(tracker:String):void {
            if (_availability)
                ExternalInterface.call('SWFAddress.setTracker', tracker);
        }

        /**
         * Provides the title of the HTML document.
         */
        public static function getTitle():String {
            var title:String = (_availability) ? 
                ExternalInterface.call('SWFAddress.getTitle') as String : '';
            if (title == 'undefined' || title == null) title = '';
            return title;
        }

        /**
         * Sets the title of the HTML document.
         * @param title Title value.
         */
        public static function setTitle(title:String):void {
            if (_availability) ExternalInterface.call('SWFAddress.setTitle', title);
        }

        /**
         * Provides the status of the browser window.
         */
        public static function getStatus():String {
            var status:String = (_availability) ? 
                ExternalInterface.call('SWFAddress.getStatus') as String : '';
            if (status == 'undefined' || status == null) status = '';
            return status;
        }

        /**
         * Sets the status of the browser window.
         * @param status Status value.
         */
        public static function setStatus(status:String):void {
            if (_availability) ExternalInterface.call('SWFAddress.setStatus', status);
        }

        /**
         * Resets the status of the browser window.
         */
        public static function resetStatus():void {
            if (_availability) ExternalInterface.call('SWFAddress.resetStatus');
        }

        /**
         * Provides the current deep linking value.
         */
        public static function getValue():String {
            return _strictCheck(_value || '', false);
        }

        /**
         * Sets the current deep linking value.
         * @param value A value which will be appended to the base link of the HTML document.
         */
        public static function setValue(value:String):void {
            if (value == 'undefined' || value == null) value = '';
            value = _strictCheck(value, true);
            if (SWFAddress._value == value) return;
            SWFAddress._value = value;
            if (_availability && SWFAddress._init) ExternalInterface.call('SWFAddress.setValue', value);
            _dispatchEvent(SWFAddressEvent.CHANGE);
        }

        /**
         * Provides the deep linking value without the query string.
         */
        public static function getPath():String {
            var value:String = SWFAddress.getValue();
            if (value.indexOf('?') != -1) {
                return value.split('?')[0];
            } else {
                return value;
            }
        }
        
        /**
         * Provides a list of all the folders in the deep linking path.
         */
        public static function getPathNames():Array {
            var path:String = SWFAddress.getPath();
            var names:Array = path.split('/');
            if (path.substr(0, 1) == '/' || path.length == 0)
                names.splice(0, 1);
            if (path.substr(path.length - 1, 1) == '/')
                names.splice(names.length - 1, 1);
            return names;
        }

        /**
         * Provides the query string part of the deep linking value.
         */
        public static function getQueryString():String {
            var value:String = SWFAddress.getValue();
            var index:Number = value.indexOf('?');
            if (index != -1 && index < value.length) {
                return value.substr(index + 1);
            }
            return '';
        }

        /**
         * Provides the value of a specific query parameter.
         * @param param Parameter name.
         */
        public static function getParameter(param:String):String {
            var value:String = SWFAddress.getValue();
            var index:Number = value.indexOf('?');
            if (index != -1) {
                value = value.substr(index + 1);
                var params:Array = value.split('&');
                var p:Array;
                var i:Number = params.length;
                while(i--) {
                    p = params[i].split('=');
                    if (p[0] == param) {
                        return p[1];
                    }
                }
            }
            return '';
        }

        /**
         * Provides a list of all the query parameter names.
         */
        public static function getParameterNames():Array {
            var value:String = SWFAddress.getValue();
            var index:Number = value.indexOf('?');
            var names:Array = new Array();
            if (index != -1) {
                value = value.substr(index + 1);
                if (value != '' && value.indexOf('=') != -1) {
                    var params:Array = value.split('&');
                    var i:Number = 0;
                    while(i < params.length) {
                        names.push(params[i].split('=')[0]);
                        i++;
                    }
                }
            }
            return names;
        }
    }
}