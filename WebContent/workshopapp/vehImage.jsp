
<div id="vehImage-pad" class="signature-pad">
	<div class="signature-pad--body">
				<canvas style="width:100%;min-height:200px;"></canvas>
			</div>
			<div class="signature-pad--footer">
	  			<div class="description text-center">Mark above</div>
	  			<div class="signature-pad--actions">
	    			<div class="text-center" style="align-items:center;">
	      				<button type="button" class="button clear btn btn-default focus" data-action="clear">Clear</button>
	      				<!-- <button type="button" class="button" data-action="change-color">Change color</button>
	      				<button type="button" class="button" data-action="undo">Undo</button> -->
	    			</div>
	    			<!-- <div>
	      				<button type="button" class="button save" data-action="save-png">Save as PNG</button>
	      				<button type="button" class="button save" data-action="save-jpg">Save as JPG</button>
	      				<button type="button" class="button save" data-action="save-svg">Save as SVG</button>
	    			</div> -->
	  			</div>
			</div>
</div>
<script src="vendor/signaturepad/signature_pad.umd.js"></script>
<script type="text/javascript">
	var vehimgwrapper = document.getElementById("vehImage-pad");
	var clearButton = vehimgwrapper.querySelector("[data-action=clear]");
		var vehimgcanvas = vehimgwrapper.querySelector("canvas");
		var vehimgctx=vehimgcanvas.getContext("2d");
		var ratio =  Math.min(window.devicePixelRatio || 1, 1);
		//alert(ratio);
  		vehimgcanvas.width = vehimgcanvas.offsetWidth * ratio;
  		vehimgcanvas.height = vehimgcanvas.offsetHeight * ratio;
  		vehimgcanvas.getContext("2d").scale(ratio, ratio);
		var replaceimg=new Image();
		replaceimg.src="../icons/replacevehicle.jpg";
		replaceimg.style.width=vehimgcanvas.width+"px";
		replaceimg.style.height=vehimgcanvas.height+"px";
		
		
		replaceimg.onload=function(){
			//alert(vehimgcanvas.width+"::"+vehimgcanvas.height);
			vehimgctx.drawImage(replaceimg,0,0,vehimgcanvas.width, vehimgcanvas.height);
		}
		var vehImagePad = new SignaturePad(vehimgcanvas, {
  			// It's Necessary to use an opaque color when saving image as JPEG;
  			// this option can be omitted if only saving as PNG or SVG
  			//backgroundColor: 'rgb(255, 255, 255)'
			penColor:'rgb(255,0,0)'
		});
		
		function resizeVehImageCanvas() {
  			var ratio =  Math.max(window.devicePixelRatio || 1, 1);
  			vehimgcanvas.width = vehimgcanvas.offsetWidth * ratio;
  			vehimgcanvas.height = vehimgcanvas.offsetHeight * ratio;
  			vehimgcanvas.getContext("2d").scale(ratio, ratio);
  			vehImagePad .clear();
		}
		window.onresize = resizeVehImageCanvas;
		//resizeVehImageCanvas();
		clearButton.addEventListener("click", function (event) {
  			vehImagePad.clear();
  			var ratio =  Math.min(window.devicePixelRatio || 1, 1);
  			vehimgcanvas.width = vehimgcanvas.offsetWidth * ratio;
  			vehimgcanvas.height = vehimgcanvas.offsetHeight * ratio;
  			vehimgcanvas.getContext("2d").scale(ratio, ratio);
  			replaceimg=new Image();
			replaceimg.src="../icons/replacevehicle.jpg";
			replaceimg.style.width=vehimgcanvas.width+"px";
			replaceimg.style.height=vehimgcanvas.height+"px";
			replaceimg.onload=function(){
				vehimgctx.drawImage(replaceimg,0,0,vehimgcanvas.width, vehimgcanvas.height);
			}
			vehImagePad = new SignaturePad(vehimgcanvas, {
  				penColor:'rgb(255,0,0)'
			});
		});
</script>