////////////////////////////////////////////////////////////////////////////////
// UBISOFT CONFIDENTIAL -- Designed at Ubisoft Lille (France) 
//                                                                             
// Copyright 2009-2014 Ubisoft Entertainment -- All Rights Reserved.  
// 
// NOTICE: All information contained herein is, and remains the property of 
// Ubisoft Entertainment and its suppliers, if any. The intellectual and 
// technical concepts contained herein are proprietary to Ubisoft Entertainment 
// and its suppliers and may be covered by U.S. and Foreign Patents, patents in 
// process, and are protected by trade secret or copyright law. Dissemination 
// of this information or reproduction of this material is strictly forbidden 
// unless prior written permission is obtained from Ubisoft Entertainment. 
////////////////////////////////////////////////////////////////////////////////

package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	
	public class Main extends Sprite
	{
		////////////////////////////////////////////////////////////
		//::// Members 
		////////////////////////////////////////////////////////////
		
		private const _data_size : int = 200000;
		
		private var _input_rand : Vector.<int>;
		private var _output_ref : Vector.<int>;
		private var _output_test : Vector.<int>;
		
		private var _log : TextField = new TextField();
		
		////////////////////////////////////////////////////////////
		//::// Constructor 
		////////////////////////////////////////////////////////////
		
		public function Main()
		{
			super();
			
			var t : int;
			
			// Initializing the log.
			
			_log = new TextField();
			_log.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(_log);
			
			// Initializing random data as input.
			
			_input_rand = new Vector.<int>(_data_size, true);
			
			for(var k : int = 0 ; k < _data_size ; k++)
			{
				_input_rand[k] = int(Math.random() * int.MAX_VALUE);
			}
			
			// Running the built-in Vector sort algorithm to get reference data as output.
			
			_output_ref = _input_rand.concat();
			
			t = getTimer();
			
			_output_ref.sort(compare);
			
			log("Vector/sort: " + (getTimer() - t) + " ms.");
			
			// Running our custom algorithms.
			
			_output_test = _input_rand.concat();
			
			t = getTimer();
			
			shellSort(_output_test);
			
			log("shellSort: " + (getTimer() - t) + " ms.");
			
			_output_test = _input_rand.concat();
			
			t = getTimer();
			
			quickSort(_output_test, 0, _data_size - 1);
			
			log("quickSort: " + (getTimer() - t) + " ms.");
		}
		
		////////////////////////////////////////////////////////////
		//::// Methods 
		////////////////////////////////////////////////////////////
		
		private function log(msg : String) : void
		{
			_log.appendText(msg + "\n");
		}
		
		private function shellSort(data : Vector.<int>) : void
		{
			var n : int = data.length;
			var k : int = int(n / 2);
			
			while(k)
			{
				for(var i : int = k ; i < n ; i++)
				{
					var t : int = data[i], j : int = i;
					
					while(j < k && data[int(j - k)] > t)
					{
						data[j] = data[int(j - k)];
						
						j = int(j - k);
					}
					
					data[j] = t;
				}
				
				k = int(k / 2.2);
			}
		}
		
		private function quickSort(data : Vector.<int>, left : int, right : int) : void
		{
			var i : int = left;
			var j : int = right;
			
			var p : int = data[Math.round((left + right) * .5)];
			
			// Loop
			
			while(i <= j)
			{
				while(data[i] < p)
				{
					i++;
				}
				
				while(data[j] > p)
				{
					j--;
				}
				
				if(i <= j)
				{
					var t : int = data[i];
					data[i] = data[j];
					i++;
					data[j] = t;
					j--;
				}
			}
			
			// Swap
			
			if(left < j)
			{
				quickSort(data, left, j);
			}
			
			if(i < right)
			{
				quickSort(data, i, right);
			}
		}
		
		private function compare(a : int, b : int) : int
		{
			return a - b;
		}
	}
}
