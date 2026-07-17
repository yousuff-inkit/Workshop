<!DOCTYPE html>
<html lang="en">
<head>
    <title>html2canvas example</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include>
    <script type="text/javascript" src="../../../../js/jspdf.min.js"></script>
 
 
  <script type="text/javascript">
  $(document).ready(function(){ 

	    var specialElementHandlers = {
	        '#editor': function (element,renderer) {
	            return true;
	        }
	    };
	 $('#cmd').click(function () {
		
	        var doc = new jsPDF();
	        doc.fromHTML($('body').get(0), 15, 15, {
				'width': 170, 
				'elementHandlers': specialElementHandlers
			});
	        doc.save('sample-file.pdf');
	    });  
	});


  </script>
</head>
<body id="target">
<div id="content">
     <h3>Hello, this is a H3 tag</h3>
      <a class="upload"  >Upload to Imgur</a>    
    <h2>this is <b>bold</b> <span style="color:red">red</span></h2>   
    <p> Feedback form with screenshot This script allows you to create feedback forms which include a screenshot, 
    created on the clients browser, along with the form. 
    The screenshot is based on the DOM and as such may not be 100% accurate to the real 
    representation as it does not make an actual screenshot, but builds the screenshot based on the 
    information available on the page. How does it work? The script is based on the html2canvas library,
     which renders the current page as a canvas image, by reading the DOM and the different styles applied 
     to the elements. This script adds the options for the user to draw elements on top of that image, 
     such as mark points of interest on the image along with the feedback they send.
      It does not require any rendering from the server, as the whole image is created on the clients browser.
       No plugins, no flash, no interaction needed from the server, just pure JavaScript! Browser compatibility Firefox 3.5+ Newer versions of Google Chrome, Safari & Opera IE9
    </p>

  </div>  
 <button id="cmd">generate PDF</button>
</body>
</html>