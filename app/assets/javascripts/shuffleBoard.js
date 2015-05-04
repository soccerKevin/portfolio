// suedo code for portfolio layout plug in




/*************************/
/*    Class Layout       */
/*************************/

//list of items
//resize();

// give items positions, keeps track of them
function Layout (items, colCount, mobWin){
	this.items = items.slice(0);
	//double array of items row, then col
	this.layout = Array(colCount);
	
	this.maxRow = Math.ceil( this.items.length / colCount );
	for (var r = 0; r <=  colCount; r++){
		this.layout[r] = new Array(this.maxRow);
	}
	
	//is the window a mobile
	this.mob = mobWin;
	//number of columns
	this.col = colCount;
	this.padding = [15, 15];
	this.colW = 150;
	this.height = 0;
	
	if(this.mob){
		this.colW = 100;
		this.padding = [3, 3];
		this.height = 75;
	}
	
	//position items
	this.init = function(){
		//if(!this.mob){
			//put items into position (no px positions yet, just a grid)
			for(var r = 0; r < this.maxRow; r++){
				for (var c = 0; c < this.col; c++){
					//converts item index to layout index
					var k = r * this.col + c;
					
					//stop if out of items
					if( typeof(this.items[k]) == 'undefined')
						break;
						
					this.layout[c][r] = this.items[k];
					x = (this.colW + this.padding[0]) * c;
					if( r <= 0 ){
						y = 0;
					}else{
						//get size of element 1 above me
						if(!this.mob)
							y = this.layout[c][r - 1].pos[1] + this.layout[c][r - 1].size[1] + this.padding[1];
						else
							y = this.layout[c][r - 1].pos[1] + this.height + this.padding[1];
					}
						
					//save the oldPos for movement
					this.items[k].oldPos = this.items[k].pos.slice(0);
					//this.layout[c][r].pos[x, y];
					this.items[k].pos = [x, y];
				}
			}
		//}
	}
	
	this.init();
	
	return this.items;
}





/*************************/
/*    Class Item         */
/*************************/

function Item(imgSrc, url, w, h, text){
	//current position, set this for category positioning
	this.pos = [0, 0];
	//temporary position, changes to this.pos
	this.oldPos = [0, 0];
	
	//make sure something is set
	var wx = typeof w !== 'undefined' ? w : 150;
	this.size = [wx, h];
	//default position, set this when all (not a category) items are layed out
	//this.dpos = [0, 0]; not sure I need this
	this.toFade = true;
	
	//a unique id for each element. (helps with moving and calling items by id later)
	this.id = 0;
	this.text = typeof text !== 'undefined' ? text : "";
	this.img = imgSrc;
	this.url = typeof url !== 'undefined' ? url : "";
	//style of hover state etc, css styles to add
	/*this.hoverStyle = hoverStyle;*/
	
	this.init = function(){
		
	}
	
	
	//creates this object
	this.init();
}






/*************************/
/*    Class Board        */
/*************************/
function ShuffleBoard(items, indexes){
	
	//list of all items
	this.items = items;
	//current items on the shuffleboard
	this.currentItems = items.slice(0);
	//items to erase on the shuffle board (not including new currentItems)
	this.oldItems = [];
	//the width of the items
	this.itemW = 150;
	this.colCount = 4;
	this.moveDuration = 1500;
	this.layout;
	
	//sections btns
	//double array, first element is name

	this.sections = indexes;
	
	//first iteration (defines whether or not to use animation)
	this.first = true;
	
	//is the window a mobile
	this.mobWin = false;
	this.sb = "#shuffle-board";
	
	//padding width, height
	this.padding = [15, 15];
	
	
	//the contsructor
	this.init = function(){
		var _this = this;
		
		//set up btns
		for(var i = 0; i < this.sections.length; i++){
			$("#shuffle-board-nav div").click(function(){
				_this.displaySection( $(this).index() );
			});
		}
		
		//set item id's for easy grabbing with jquery later
		for(var i = 0; i < this.items.length; i++){
			this.items[i].id = i;
		}
		
		this.resize();
		
		//generally in update (want to skip setting first)
		this.currentItems = new Layout(this.currentItems, this.colCount, this.mobWin);
		
		//print current imgs with old positions
		this.printItems();
	}
	
	
	/** displays the new section based on the variable passed**/
	this.displaySection = function(sectionNum){
		this.setItems(sectionNum);
		this.update();
	}
	
	
	
	//sets the number of columns based on the width of the window
	this.getColumnCount = function(){
		//set number of columns based on window width
		var ww = $(window).width();
		if(ww >= 641){
			this.mobWin = false;
			this.colCount = Math.floor(ww / (this.itemW + this.padding[0]) );
		}else{//mobile
			this.colCount = 4;
			this.mobWin = true;
		}
	}
	
	
	//updates the shuffleboard
	this.update = function(duration){
		//alert(duration);
		var dur = typeof duration !== 'undefined' ? duration : this.moveDuration;
		
		
		//get new layout
		this.currentItems = new Layout(this.currentItems, this.colCount, this.mobWin);
		if(this.first)
			this.first = false;
		
		this.eraseItems();
		
		
		//print current imgs with old positions
		//or sets new positions
		this.printItems();
		
		//move the items to their new positions
		this.moveItems(dur);
	}
	
	
	/* figures out the number of columns based on window width */
	this.resize = function(){
		//getColumnCount
		this.getColumnCount();
		
		/*resizePage*/
		if(!this.mobWin)
			$(this.sb).css("width", (this.colCount * this.itemW) + (this.colCount - 1) * this.padding[0] );
		else
			$(this.sb).css("width", "100%");
	}
	
	//erases the items before adding and moving new ones
	this.eraseItems = function(){
		//clear the baord (for now)
		//$('#shuffle-board').html("");
		
		$(this.oldItems).each(function (i, item){
			var id = item.id;
        	$("#item" + id).animate(
        		{opacity: 0}, 
        		{ duration: 1000, 
        		queue: false/*, 
        		complete: function(){
        			$("#item" + id).remove();
        		}*/
        	});
        });
	}
	
	/* adds items to the DOM if first iteration, otherwise, set opacity to 1 and set to new positions*/
	this.printItems = function(){
		
		//layout all items for the first time
		if(this.first){
			for(var i = 0; i < this.currentItems.length; i++){
				var x = this.currentItems[i].pos[0];
				var y = this.currentItems[i].pos[1];
				var id = this.currentItems[i].id;
				var url = this.currentItems[i].url;
				var text = this.currentItems[i].text;
				
				$('#shuffle-board').append( 
					'<a target="_blank" href="' + url + '" id="item' + id + '" class="item" style="left:' + x + 'px; top:' + y + 'px;"> <span class="slider">' + text + '</span><img src="' + this.currentItems[i].img + '" alt=""/></a>' );
				
			}
		}else{
			
			//add all pieces
			for(var i = 0; i < this.currentItems.length; i++){
				var x = this.currentItems[i].oldPos[0];
				var y = this.currentItems[i].oldPos[1];
				var nx = this.currentItems[i].pos[0];
				var ny = this.currentItems[i].pos[1];
				var id = this.currentItems[i].id;
				/*if(! $("#item" + id) ){
					$('#shuffle-board').append( 
					'<a href="" id="item' + id + '"> <img class="item" style="left:' + x + 'px; top:' + y + 'px; opacity: 100;" src="' + this.currentItems[i].img + '" alt=""/></a>' );
				}*/
				$("#item" + id).animate(
	        		{x: x, y: y, opacity: 100}, 
	        		{ duration: 1000, 
	        		queue: false/*, 
	        		complete: function(){
	        			$("#item" + id).remove();
	        		}*/
	        	});
			}
		}
		
	}
	
	
	/**animates the items, must have old and current positions set already**/
	this.moveItems = function(dur){
		//animate all items at once
		$(this.currentItems).each(function (i, item){
        	var nx = item.pos[0];
			var ny = item.pos[1];
			var id = item.id;
        	$("#item" + id).animate({left: nx, top: ny}, { duration: dur, queue: false });
        });
	}
	
	
	/**sets this.oldItems and this.currentItems */
	this.setItems = function(sectionNum){
		var num = sectionNum;
		
		this.oldItems = [];
		
		this.oldItems = this.currentItems.slice(0);
		
		this.currentItems = [];
		
		//set items for currentItems
		for(var i = 0; i < this.sections[num].length; i++){
			//get the placement of item based on the original set
			var p = this.sections[num][i];
			this.currentItems[i] = this.items[p];
		}
		
		//set oldItems (or erasble items)
		var ci = this.currentItems;
		this.oldItems = this.oldItems.filter(function(val){
			return ci.indexOf(val) == -1;
		});
	}
	
	
	//starts the contructor
	//must be done here so that functions exist
	this.init();
}