
<div id="signature-pad" class="signature-pad">
	<div class="signature-pad--body">
				<canvas style="width:100%;min-height:200px;"></canvas>
			</div>
			<div class="signature-pad--footer">
	  			<div class="description text-center">Sign above</div>
	  			<div class="signature-pad--actions">
	    			<div>
	      				<button type="button" class="button clear btn btn-default focus" data-action="clear">Clear</button>
	      				<!-- <!-- <button type="button" class="button" data-action="change-color">Change color</button>
	      				<button type="button" class="button" data-action="undo">Undo</button> --> -->
	    			</div>
	    			<div class="d-none">
	      				<button type="button" class="button save" data-action="save-png">Save as PNG</button>
	      				<button type="button" class="button save" data-action="save-jpg">Save as JPG</button>
	      				<button type="button" class="button save" data-action="save-svg">Save as SVG</button>
	    			</div>
	  			</div>
			</div>
</div>
<script src="vendor/signaturepad/signature_pad.umd.js"></script>
<script type="text/javascript">
	var wrapper = document.getElementById("signature-pad");
	var clearButton = wrapper.querySelector("[data-action=clear]");
		var canvas = wrapper.querySelector("canvas");
		var signaturePad = new SignaturePad(canvas, {
  			// It's Necessary to use an opaque color when saving image as JPEG;
  			// this option can be omitted if only saving as PNG or SVG
  			backgroundColor: 'rgb(255, 255, 255)'
		});
		function resizeCanvas() {
  			var ratio =  Math.min(window.devicePixelRatio || 1, 1);
  			canvas.width = canvas.offsetWidth * ratio;
  			canvas.height = canvas.offsetHeight * ratio;
  			canvas.getContext("2d").scale(ratio, ratio);
  			signaturePad.clear();
		}
		window.onresize = resizeCanvas;
		resizeCanvas();
		clearButton.addEventListener("click", function (event) {
  			signaturePad.clear();
		});
</script>