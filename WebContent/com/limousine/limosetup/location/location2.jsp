<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
	form label.error {
		color:red;
  		font-weight:bold;
	}

	.controls {
    	margin-top: 10px;
        border: 1px solid transparent;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        height: 32px;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
    }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 300px;
        height: 32px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      .pac-container {
        font-family: Roboto;
      }

      #type-selector {
        color: #fff;
        background-color: #4d90fe;
        padding: 5px 11px 0px 11px;
      }

      #type-selector label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }
      #target {
        width: 345px;
      }


</style>

 <jsp:include page="../../../../includes.jsp"></jsp:include>
 
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCNRkpjhg621w7iyU8uialJS_Ye84J4wJk&libraries=places"></script>
<script type="text/javascript">
	$(document).ready(function() {
  		$("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
		getConfig();
	});
	
	function getConfig(){
		$.get('getConfig.jsp',function(data){
			data=JSON.parse(data);
			$('#mapconfig').val(data.locationmap);
			if(data.locationmap=="0"){
				$('.maprow').hide();
			}
			
		});
	}
	function funSearchLoad(){
		changeContent('location2Search.jsp', $('#window')); 
	}
	function funReadOnly() {
		 $('#frmlocation2 input').attr('readonly', true);
		 $('#frmlocation2 select').attr('disabled', true);
		 $('#date').jqxDateTimeInput({ disabled: true}); 
		 
	}
	function funRemoveReadOnly() {
		$('#frmlocation2 input').attr('readonly', false);
		$('#frmlocation2 select').attr('disabled', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({		disabled : false		});
		$('#docno').attr('readonly', true);
		 $('#date').jqxDateTimeInput({ disabled: false}); 
	}
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 if(document.getElementById("location").value!=""){
			 document.getElementById("pac-input").value=document.getElementById("location").value;
			 google.maps.event.addDomListener(window, 'load', initialize);
		 }
	}

	 function funFocus()
	    {
	    	document.getElementById("location").focus();
	    		
	    }
	     $(function(){
	        $('#frmlocation2').validate({
	        	rules: {
	                location:"required"
	                 
	            }, 
	        	messages:{
	        		location:" *"
	        		
	        	}
	        });
	     }); 
	     
	     
	     function funNotify(){
	     	if($('#mapconfig').val()=='1'){
	     		document.getElementById("location").value=document.getElementById("pac-input").value;	
	     	}
	     	else{
	     		if(document.getElementById("location").value==""){
	     			document.getElementById("errormsg").innerText="";
	     			document.getElementById("errormsg").innerText="Please enter location";
	     			return 0;
	     		}
	     	}
	    	return 1;
	     } 
		function getCordinates(place){
			if(place==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Location is mandatory";
				return false;
			}
			else{
                var geocoder =  new google.maps.Geocoder();
                var city=place;
                geocoder.geocode({'address': city}, function(results, status) {
                      if (status == google.maps.GeocoderStatus.OK) {
                        $('#latitude').val(results[0].geometry.location.lat());
                        $('#longitude').val(results[0].geometry.location.lng());
                        /* var p1=new google.maps.LatLng(position1);
                        var p2=new google.maps.LatLng(position2);
                        var distance=(google.maps.geometry.spherical.computeDistanceBetween(p1, p2) / 1000).toFixed(2);
                      	//Dont forget to add geometry library */ 
                      } else {
                        document.getElementById("errormsg").innerText="Invalid Location";
                        return false;
                      }
                    });			            

			}
		}
		

	      
</script>
 </head>
<body onLoad="setValues();">
	<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmlocation2" action="saveLocation2" method="post" autocomplete="off">
			<jsp:include page="../../../../header.jsp" />
			<table width="100%" border="0">
				<tr>
			    	<td width="40%" class="maprow"><div id="mapdiv"><jsp:include page="map.jsp" /></div></td>
			    	<td width="60%">
			    		<table width="100%">
  							<tr>
    							<td width="13%" align="right">Date</td>
    							<td width="11%"><div id="date" name="date"></div></td>
    							<td width="15%">&nbsp;</td>
    							<td colspan="2">&nbsp;</td>
    							<td width="12%" align="right">Doc No</td>
    							<td width="17%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td>
  							</tr>
  							<tr>
							    <td align="right">Location</td>
							    <td><input type="text" name="location" id="location" value='<s:property value="location"/>'></td>
							    <td>&nbsp;</td>
							    <td width="19%" align="left" hidden="true"><button  type="button" name="btncordinates" id="btncordinates" class="myButton" onClick="getCordinates();">Get Cordinates</button></td>
							    <td width="13%">&nbsp;</td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
  							</tr>
  							<tr>
							    <td align="right">Latitude</td>
							    <td><input type="text" name="latitude" id="latitude" value='<s:property value="latitude"/>'></td>
							    <td align="right">Longitude</td>
							    <td><input type="text" name="longitude" id="longitude" value='<s:property value="longitude"/>'></td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
  							</tr>
						</table>
					</td>
		      	</tr>
		  	</table>
			<%-- <input type="hidden" name="location" id="location" value='<s:property value="location"/>'> --%>
			<input type="hidden" id="mode" name="mode"/>
			<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
			<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
			<input type="hidden" name="mapconfig" id="mapconfig" value='<s:property value="mapconfig"/>'/>
		</form>
	</div>			
</body>
</html>