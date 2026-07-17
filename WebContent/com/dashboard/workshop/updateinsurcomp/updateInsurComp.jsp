<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>GatewayERP(i)</title>
		<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript">
			$(document).ready(function () {
				$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 		$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:380px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 		$('#insurcompwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Insurance Company Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		   		$('#insurcompwindow').jqxWindow('close');
		 
		 		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 		$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 		var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
		 		$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
		 		
		 		$('#todate').on('change', function (event) {
			   		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 	 	var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
			   		if(fromdate>todate){
				   		$.messager.alert('Message','To Date Less Than From Date  ','warning');   
			   			return false;
			  		}   
		 		});
				$('#insurcomp').dblclick(function(){
					$('#insurcompwindow').jqxWindow('open');
					insurCompSearchContent('insurCompSearchGrid.jsp?id=1', $('#insurcompwindow'));
				});
				$('#btnupdate').click(function(){
					if($('#gatedocno').val()==''){
						$.messager.alert('Warning','Please select a valid document');
						return false;
					}
					if($('#insurcomp').val()==''){
						$.messager.alert('Warning','Please select an Insurance Company');
						return false;
					}
					updateInsurCompAJAX($('#gatedocno').val(),$('#insurcompdocno').val());
				});
			});
			
			function updateInsurCompAJAX(gatedocno,insurcompdocno){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText.trim();
						if(items=="0"){
							$.messager.alert('Message','Successfully Updated');
							funreload("");
							$('#insurcomp,#insurcompdocno,#gatedocno').val('');
						}
						else{
							$.messager.alert('Warning','Not Updated');
						}
					}
					else
					{
					}
				}
				x.open("GET","updateInsurCompAJAX.jsp?gatedocno="+gatedocno+"&insurcompdocno="+insurcompdocno,true);
				x.send();
			}
			function funreload(event){
		 		var branch = document.getElementById("cmbbranch").value;
		    	var fromdate=$('#fromdate').jqxDateTimeInput('val');
		    	var todate=$('#todate').jqxDateTimeInput('val');
		 		$("#overlay, #PleaseWait").show();
		 		$('#updateinsurcompdiv').load('updateInsurCompGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&branch='+branch+'&id=1');
		 	}

	
			function getInsurComp(event){
		 		var x= event.keyCode;
				if(x==114){
	 				$('#insurcompwindow').jqxWindow('open');
					insurCompSearchContent('insurCompSearchGrid.jsp?id=1', $('#insurcompwindow'));
			    }
			} 
	 		function funExportBtn(){
				
			} 

			function insurCompSearchContent(url) {
		 		$.get(url).done(function (data) {
					$('#insurcompwindow').jqxWindow('open');
					$('#insurcompwindow').jqxWindow('setContent', data);
				}); 
			} 	
		</script>
	</head>
	<body onload="getBranch();">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%" >
					<tr>
						<td width="20%" >
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
	 								<tr>
	 									<td width="20%" align="right" >
	 										<label class="branch">From</label>
	 									</td>
	 									<td align="left">
	 										<div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    					</td>
                    				</tr>
                     				<tr>
                     					<td  align="right" >
                     						<label class="branch">To</label>
                     					</td>
                     					<td align="left">
                     						<div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    					</td>
                    				</tr>
                    				<tr>
                    					<td align="right">
                    						<label class="branch">Insur.Company</label>
                    					</td>
                    					<td align="left">
                    						<input type="text" name="insurcomp" id="insurcomp" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getInsurComp(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="insurcomp"/>'>
                    						<input type="hidden" name="insurcompdocno" id="insurcompdocno" value='<s:property value="insurcompdocno"/>'>
                    					</td>
                    				</tr>
                    				<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate">Update</button></td></tr>    
 									<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br></td></tr>
  								</table>
							</fieldset>
						</td>
						<td width="80%" >
							<table width="100%" >
								<tr><td><div id="updateinsurcompdiv"><jsp:include page="updateInsurCompGrid.jsp"></jsp:include></div><br/></td></tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="gatedocno" id="gatedocno">
			<div id="insurcompwindow">
   				<div></div>
			</div>
		</div>
	</body>
</html>