<%@page import="com.dashboard.leaseagreement.vehiclereturn.*" %>
<% ClsVehicleReturnDAO returndao=new ClsVehicleReturnDAO(); 
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
	String periodupto=request.getParameter("periodupto")==null?"":request.getParameter("periodupto");
	String type=request.getParameter("type")==null?"":request.getParameter("type");
	String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var returndata;
if(id=="1"){
	returndata='<%=returndao.getReturnData(branch,periodupto,type,id)%>';
vehretrnexcel='<%=returndao.getReturnDataexcel(branch,periodupto,type,id)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'brhid', type: 'number'},
						{name : 'branchname',type:'string'},
						{name : 'doc_no', type: 'number'},
						{name : 'voc_no',type:'string'},
						{name : 'date', type: 'date'},
						{name : 'cldocno',type:'number'},
						{name : 'refname',type:'number'},
						{name : 'perfleet', type: 'String'},
						{name : 'flname',type:'string'},
						{name : 'outdate', type: 'date'},
						{name : 'enddate',type:'date'},
						{name : 'reg_no',type:'number'},
						{name : 'depr_date',type:'date'},
						{name : 'veh_cost',type:'number'},
						{name : 'residualvalue',type:'number'},
						{name : 'stockvehiclestatus',type:'number'}

						],
				    localdata: returndata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#vehReturnGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#vehReturnGrid").jqxGrid(
    {
        width: '98%',
        height: 285,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
                  	 { text: 'Branch ID', datafield: 'brhid', width: '12%',hidden:true},
				     { text: 'Branch', datafield:'branchname', width: '10%'}, 
				     { text: 'Doc No',datafield: 'doc_no', width: '12%',hidden:true},
				     { text: 'Voc No',datafield: 'voc_no', width: '10%'},
				     { text: 'Date',datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Client ID', datafield: 'cldocno', width: '15%',hidden:true },
					 { text: 'Client',datafield: 'refname',width:'25%'},
					 { text: 'Fleet', datafield: 'perfleet', width: '8%'},
					 { text: 'Reg No', datafield:'reg_no',width:'8%'},
					 { text: 'Fleet Name', datafield: 'flname',width: '15%'},
					 { text: 'Agmt Date', datafield: 'outdate', width: '8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'End Date', datafield: 'enddate', width: '8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Depr Date',datafield:'depr_date',width:'8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Vehicle Cost',datafield:'veh_cost',width:'8%',cellsformat:'d2'},
					 { text: 'Residual Value',datafield:'residualvalue',width:'8%',cellsformat:'d2'},
					 { text: 'Stock Vehicle Status',datafield:'stockvehiclestatus',width:'8%'}
					
					]
   
    });

    $('#vehReturnGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	if($('#client').val()==''){
   		$.messager.alert('warning','Please Select Client Account');
   			return false;
	   	}
	   	if($('#salesvalue').val()==''){
	   		$.messager.alert('warning','Please Enter Sales Value');
	   		return false;
	   	}
    	$('#agmtno,#hidagmtno,#fleetno,#curdepr').val('');
    	document.getElementById("agmtno").value=$('#vehReturnGrid').jqxGrid('getcellvalue',rowindex,'voc_no');
    	document.getElementById("hidagmtno").value=$('#vehReturnGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
    	document.getElementById("fleetno").value=$('#vehReturnGrid').jqxGrid('getcellvalue',rowindex,'perfleet');
    	document.getElementById("stockvehiclestatus").value=$('#vehReturnGrid').jqxGrid('getcellvalue',rowindex,'stockvehiclestatus');
    	var salesvalue=$('#salesvalue').val();
    	$('#vehReturnCalcGrid').jqxGrid('clear');
    	if(document.getElementById("cmbtype").value=="2"){
    		/* checkDepr($('#hidagmtno').val(),$('#fleetno').val()); */
    	} 
    	$('#vehreturncalcdiv').load('vehReturnCalcGrid.jsp?fleetno='+$('#fleetno').val()+'&type='+document.getElementById("cmbtype").value+'&id=1&clientacno='+$('#clientacno').val()+'&agmtno='+$('#hidagmtno').val()+"&salesvalue="+salesvalue+"&stockvehiclestatus="+$('#stockvehiclestatus').val());
    }); 
});
                     
  function checkDepr(agmtno,fleetno){
	  var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items= x.responseText.trim();
				$('#deprstatus').val(items);
	 			$("#overlay, #PleaseWait").show();
        		$('#vehreturncalcdiv').load('vehReturnCalcGrid.jsp?fleetno='+fleetno+'&type='+document.getElementById("cmbtype").value+'&id=1&agmtno='+agmtno);    			
				/* if(items=="1"){
	     			$("#overlay, #PleaseWait").show();
	        		$('#vehreturncalcdiv').load('vehReturnCalcGrid.jsp?fleetno='+fleetno+'&type='+document.getElementById("cmbtype").value+'&id=1&agmtno='+agmtno);    			
	    		}
	    		else{
	    			$.messager.alert('warning', 'Please complete vehicle depreciation');
	    		} */
			}
			else
			{
				
			}
		}
		x.open("GET", "checkDepr.jsp?agmtno="+agmtno+"&fleetno="+fleetno, true);
		x.send();
  }
</script>
<div id="vehReturnGrid"></div>
<input type="hidden" id="deprstatus" name="deprstatus">