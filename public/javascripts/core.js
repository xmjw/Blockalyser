
var imageHeight = 500;
var imageWidth = 500;

function parse_submit()
{

}

function startup()
{
	var clrCvs = document.getElementById('clrImg');
	clrCvs.height = 0;
	clrCvs.width = 0;


	//alert("Woot: opened!");
	var cvs = document.getElementById('srcImg');
	
	var ctx = document.getElementById('srcImg').getContext('2d');
	
	//later, this has to be dynamic to cope better..
	ctx.scale(0.5,0.5);
	
	var img = new Image();

	img.src = document.getElementById('imageFile').value;
	
	//handle the image size...

	img.onload = function(){
		
		imageHeight = img.height;
		imageWidth = img.width;
		
		cvs.height = img.height;
		cvs.width = img.width;
	
		ctx.drawImage(img,0,0);
	}    
}


function checkAspect(sender)
{
	if (document.getElementById('preserveAspect').checked)
	{
		if (sender.id=="destHeight")
		{
			var height = parseInt(sender.value);
			document.getElementById('destWidth').value = Math.round((height / imageHeight) * imageWidth);
		}
		else if (sender.id == "destWidth")
		{
			var width = parseInt(sender.value);
			document.getElementById('destHeight').value = Math.round((width / imageWidth) * imageHeight);
		}
	}
}

function render()
{
	var destHeight = document.getElementById('destHeight').value;
	var destWidth = document.getElementById('destWidth').value;
	
	var ctx = document.getElementById('srcImg').getContext('2d');
	
	var cvs = document.getElementById('srcImg');

	var img = new Image();
	img.src = document.getElementById('imageFile').value;
	

	
	document.getElementById('srcImg').height = destHeight;
	document.getElementById('srcImg').width = destWidth;
	
	img.onload = function() {
		cvs.height = destHeight;
		cvs.width = destWidth;
		var hblock = destHeight/imageHeight;
		var wblock = destWidth/imageWidth;
		ctx.scale(wblock,hblock);

		ctx.drawImage(img,0,0);

	}
}
	
function calculate()
{
	var destHeight = document.getElementById('destHeight').value;
	var destWidth = document.getElementById('destWidth').value;
	var destCvs = document.getElementById('srcImg');
	
	var destCtx = destCvs.getContext('2d');
	var pixels = destCtx.getImageData(0,0,destCvs.width,destCvs.height);
	var pixelSize = pixels.data.length;
	var pixelData = "";
	
	var clrCvs = document.getElementById('clrImg');
	var clrCtx = clrCvs.getContext('2d');
	
	clrCvs.height = destCvs.height;
	clrCvs.width = destCvs.width;
	
	for (var i=0;i<pixelSize;i+=4)
	{
		pixels = reduceColour(pixels,i);
		
	}

	//Gets the pixel data ready to send to the server.
    var p = "{";
	for (var i=0;i<pixels.data.length;i++)
	{
		p = p + pixels.data[i];
		if (i+1 < pixels.data.length) p = p + ",";
		
	}
	p = p + "}";
	
	document.getElementById('image_data').value = p;

	clrCtx.putImageData(pixels,0,0);


	//var outputDiv = document.getElementById('outputRaw');
	//outputDiv.innerHTML = pixelData;	
}

//Ultimately hold the precalculated optimum distance in here.
var colourMatches = [];

function RGBColour(r, g, b)
{
	this.r = r;
	this.g = g;
	this.b = b;
}

var BrightBlue      = new RGBColour(52,93,129); // 345D81 Light Blue ("Bright Blue")
var EarthBlue       = new RGBColour(45,69,87); // 2D4557 Dark Blue ("Earth Blue")
var ReddishBrown    = new RGBColour(153,100,64); // 996440 Brown ("Reddish Brown")
var BrightRed       = new RGBColour(254,76,44); // FE4C2C Red ("Bright Red")
var DarkRed         = new RGBColour(175,78,77); // AF4E4D Burgendy ("Dark Red")
var DarkGreen       = new RGBColour(60,174,108); // 3CAE6C Green ("Dark Green")
var BrickYellow     = new RGBColour(255,251,206); // FFFBCE Beige ("Brick Yellow")
var MediumStoneGrey = new RGBColour(145,150,143); // 918C8F Grey ("Medium Stone Grey")
var MediumBlue      = new RGBColour(156,207,255); // 9CCFFF Sky Blue ("Medium Blue")
var Black           = new RGBColour(0,0,0); // 000000 Black
var White           = new RGBColour(250,250,250); // FAFAFA White

//does euclidean colour matching for a given poisiont, presuming that position=r, poisiton+1=g, position+2=b
function reduceColour(pixels,position)
{
	var pixelColour = new RGBColour(pixels.data[position],pixels.data[position+1],pixels.data[position+2]);
	var pixelData = pixelColour.r+","+pixelColour.g+","+pixelColour.b; //minimist the amount we store in the array..

	if (colourMatches[pixelData] == null)
	{
		var shortest = 442; //Maxium distance of SQRT((0-255)^2 + (0-255)^2 + (0-255)^2) (rounded up)
		
		var brightBlue      = euclideanDistance(pixelColour,BrightBlue); // 345D81 Light Blue ("Bright Blue")
		var earthBlue       = euclideanDistance(pixelColour,EarthBlue); // 2D4557 Dark Blue ("Earth Blue")
		var reddishBrown    = euclideanDistance(pixelColour,ReddishBrown); // 996440 Brown ("Reddish Brown")
		var brightRed       = euclideanDistance(pixelColour,BrightRed); // FE4C2C Red ("Bright Red")
		var darkRed         = euclideanDistance(pixelColour,DarkRed); // AF4E4D Burgendy ("Dark Red")
		var darkGreen       = euclideanDistance(pixelColour,DarkGreen); // 3CAE6C Green ("Dark Green")
		var brickYellow     = euclideanDistance(pixelColour,BrickYellow); // FFFBCE Beige ("Brick Yellow")
		var mediumStoneGrey = euclideanDistance(pixelColour,MediumStoneGrey); // 918C8F Grey ("Medium Stone Grey")
		var mediumBlue      = euclideanDistance(pixelColour,MediumBlue); // 9CCFFF Sky Blue ("Medium Blue")
		var black           = euclideanDistance(pixelColour,Black); // 000000 Black
		var white           = euclideanDistance(pixelColour,White); // FAFAFA White

		//Now work out which is closest.
		if (shortest > brightBlue)      { pixelColour = BrightBlue; shortest = brightBlue; }
		if (shortest > earthBlue)       { pixelColour = EarthBlue; shortest = earthBlue;}
		if (shortest > reddishBrown)    { pixelColour = ReddishBrown; shortest = reddishBrown;}
		if (shortest > brightRed)       { pixelColour = BrightRed; shortest = brightRed; }
		if (shortest > darkRed)         { pixelColour = DarkRed; shortest = darkRed;}
		if (shortest > darkGreen)       { pixelColour = DarkGreen; shortest = darkGreen; }
		if (shortest > brickYellow)     { pixelColour = BrickYellow; shortest = brickYellow;}
		if (shortest > mediumStoneGrey) { pixelColour = MediumStoneGrey; shortest = mediumStoneGrey; }
		if (shortest > mediumBlue)      { pixelColour = MediumBlue; shortest = mediumBlue; }
		if (shortest > black)           { pixelColour = Black; shortest = black; }
		if (shortest > white)           { pixelColour = White; shortest = white; }
		
		colourMatches[pixelData] = pixelColour;
	}
	else
	{
		pixelColour = colourMatches[pixelData];
	}
	pixels.data[position+0] = pixelColour.r;
	pixels.data[position+1] = pixelColour.g;
	pixels.data[position+2] = pixelColour.b;

	return pixels;

}

//Calculate the distance between the points. Use (from-r,from-g,from-b,to-r,to-g,to-b)
function euclideanDistance(p,q)
{
	var result = Math.pow((p.r-q.r),2) + Math.pow((p.g-q.g),2) + Math.pow((p.b-q.b),2);
	result = Math.sqrt(result);
	return result;
}

