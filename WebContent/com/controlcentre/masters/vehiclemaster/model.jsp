<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelDAO" %>
<%ClsModelDAO cma=new ClsModelDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
      $(document).ready(function () {          
    	  $("#modeldate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
    	  $('#groupinfowindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#groupinfowindow').jqxWindow('close');
		  
    	    document.getElementById("formdet").innerText="Model(MOD)";
			document.getElementById("formdetail").value="Model";
			document.getElementById("formdetailcode").value="MOD";
			window.parent.formCode.value="MOD";
			window.parent.formName.value="Model";
			
            $('#txtgroup').dblclick(function(){
         	   groupSearchContent('modelgroupGrid.jsp');
	       		});

          var data= '<%=cma.getSearchDetails()%>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            {name : 'doc_no' , type: 'int' },
    						{name : 'vtype', type: 'String'  },
                         	{name : 'date', type: 'date'  },
                         	{name : 'brand_name',type:'String'},
                         	{name : 'brandid',type:'String'},
                         	{name : 'gname',type:'String'},
                         	{name : 'groupid',type:'String'},
                         	{name : 'enginesize',type:'string'},
                         	{name : 'enginesizedocno',type:'string'}
                   ],
                   localdata: data,
                  
                  
                  pager: function (pagenum, pagesize, oldpagenum) {
                      // callback called when a page or page size is changed.
                  }
              };
              
              var dataAdapter = new $.jqx.dataAdapter(source,
              		 {
                  		loadError: function (xhr, status, error) {
  	                    alert(error);    
  	                    }
  		            }		
              );
      


              $("#jqxModelSearch1").jqxGrid(
                      {
                      	width: '100%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'singlerow',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '10%' },
					{ text: 'Model', columntype: 'textbox', filtertype: 'input',datafield: 'vtype', width: '40%' },
					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Brand',columntype: 'textbox', filtertype: 'input',datafield:  'brand_name',width:'20%'},
					{ text: 'Brand ID',columntype: 'textbox', filtertype: 'input',datafield:  'brandid',width:'5%',hidden:true},
					{ text: 'Group',columntype: 'textbox', filtertype: 'input',datafield:  'gname',width:'10%'},
					{ text: 'Group ID',columntype: 'textbox', filtertype: 'input',datafield:  'groupid',width:'5%',hidden:true},
					{ text: 'Engine Size',columntype: 'textbox', filtertype: 'input',datafield:  'enginesize',width:'10%'},
					{ text: 'Engine Size Doc No',columntype: 'textbox', filtertype: 'input',datafield:  'enginesizedocno',width:'5%',hidden:true} 
          	              ]
                      });

	$('#jqxModelSearch1').on('rowdoubleclick', function (event) 
    {
  		var rowindex1=event.args.rowindex;
  		document.getElementById("docno").value= $('#jqxModelSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		document.getElementById("model").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "vtype");
		$('#frmModel select').attr('disabled', false);
  		$('#modeldate').jqxDateTimeInput({disabled: false});
  		$("#modeldate").jqxDateTimeInput('val',$("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
		$('#brand').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
		$('#frmModel select').attr('disabled', true);
  		$('#modeldate').jqxDateTimeInput({disabled: true});
		$('#cmbenginesize').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "enginesizedocno"));
	}); 
	$("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 
});

	function getGroup(event){  
    	var x= event.keyCode;
   		if(x==114){
   			groupSearchContent('modelgroupGrid.jsp');
   	  	}
   	  	else{
   	   	}
    }
   
      function groupSearchContent(url) {
    	    $('#groupinfowindow').jqxWindow('open');
    		$.get(url).done(function (data) {
    		$('#groupinfowindow').jqxWindow('setContent', data);
    		$('#groupinfowindow').jqxWindow('bringToFront');
    	}); 
    	}
    
    
     
      function funSearchLoad(){
			changeContent('modelSearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmModel input').attr('readonly', true);
		$('#frmModel select').attr('disabled', true);
		$('#modeldate').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		$('#txtgroup').attr('readonly', true);
		//$('#txtgroup').attr('disabled', true);
	}
	function funRemoveReadOnly() {
		$('#frmModel input').attr('readonly', false);
		$('#frmModel select').attr('disabled', false);
		$('#modeldate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtgroup').attr('readonly', true);
		//$('#txtgroup').attr('disabled', false);
		

	}

	function getBrand() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#brand").html(optionsbrand);
				$('#brand').val($('#brandid').val());
				} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}
	
	function funFocus(){
		document.getElementById("brand").focus();
	}
	 $(function(){
	        $('#frmModel').validate({
	                 rules: {
	                 brand:{
	                	 required:true
	                 },
	                 model:{
	                	 required:true,
	                	 maxlength:50
	                 }
	                 },
	                 messages: {
	                  brand:{
	                	  required:" *"
	                  },
	                  model:{
	                	  required:" *",
	                	  maxlength:"max 50 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		if ($('#brandid').val() != null) {
			$('#brand').val($('#brandid').val());
		}
		if($('#msg').val()!=""){
	   		$.messager.alert('Message',$('#msg').val());
	  	}
	  	$.get('getEngineSize.jsp',function(data){
	  		data=JSON.parse(data);
	  		var htmldata='';
	  		$.each(data.enginedata,function(index,value){
	  			htmldata+='<option value="'+value.docno+'">'+value.enginesize+'</option>';
	  		});
	  		$('#cmbenginesize').html($.parseHTML(htmldata));
	  		if($('#hidcmbenginesize').val()!='' && $('#hidcmbenginesize').val()!='0'){
	  			$('#cmbenginesize').val($('#hidcmbenginesize').val());
	  		}
	  	});
	}
	
	 function funExcelBtn(){
		  $("#jqxModelSearch1").jqxGrid('exportdata', 'xls', 'Model');
	  }
</script>
</head>
<body onLoad="getBrand();setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmModel" action="saveActionModel"  autocomplete="off">
	<jsp:include page="../../../../header.jsp" /><br/> 
	<fieldset><legend>Model Details</legend>
		<input type="text" id="brandid" name="brandid" value='<s:property value="brandid"/>' hidden="true">
		<table width="100%" border="0">
			<tr>
			  	<td width="14%"><div align="right">Date</div></td>
			  	<td width="12%"><div id="modeldate" name="modeldate" value='<s:property value="modeldate"/>'></div></td>
			  	<td colspan="4">&nbsp;</td>
			  	<td width="23%"><div align="right">Doc No</div></td>
			  	<td width="20%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
			</tr>
			<tr>
				<td><div align="right">Brand</div></td>
				<td><select name="brand" id="brand"></select></td>
				<td align="right">Model</td>
				<td width="20%"><input type="text" name="model" id="model"  value='<s:property value="model"/>'></td>
				<td width="13%" align="right"><div>Group</div></td>
				<td width="20%"><input type="text" name="txtgroup" id="txtgroup"  onkeydown="getGroup(event);" readonly placeholder="Press F3 to Search" required value='<s:property value="txtgroup"/>'>
				<input type="hidden" name="txtgroupid" id="txtgroupid"   value='<s:property value="txtgroupid"/>'></td>
				<td align="right">Engine Size</td>
				<td>
					<select name="cmbenginesize" id="cmbenginesize" style="width:99%;">
						<option value="">--Select--</option>
					</select>
				</td>
			</tr>
			<tr><td colspan="8"><div id="jqxModelSearch1"></div></td></tr>
		</table> 
	</fieldset>
	
	<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
	<input type="hidden" id="hidcmbenginesize" name="hidcmbenginesize"  value='<s:property value="hidcmbenginesize"/>'/>
	<input type="hidden" id="mode" name="mode"/>
	<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>    
</form>
	<div id="groupinfowindow">  
   		<div></div>
	</div>          
 	
</div>
</body>
</html>