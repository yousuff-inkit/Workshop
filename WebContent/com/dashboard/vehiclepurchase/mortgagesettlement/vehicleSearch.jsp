<%@page import="com.dashboard.vehiclepurchase.mortgagesettlement.*" %>
<%ClsMortgageSettlementDAO mortgagedao=new ClsMortgageSettlementDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String purchasedocno=request.getParameter("purchasedocno")==null?"0":request.getParameter("purchasedocno");
String dealno=request.getParameter("dealno")==null?"0":request.getParameter("dealno");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=id%>';
   var vehicledata;
   if(id=='1'){
	   vehicledata='<%=mortgagedao.getVehicle(purchasedocno,dealno,id)%>';
	
}
else{
	vehicledata=[];
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'rowno',type:'number'},
                  		{name : 'brand',type:'String'},
                  		{name : 'model',type:'String'},
                  		{name : 'color',type:'String'},
                  		{name : 'fleet_no',type:'String'},
                  		{name : 'reg_no',type:'String'}
                  		
                  		
                  		],
				    localdata: vehicledata,
        
        
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
    
    
    $("#vehicleSearch").jqxGrid(
    {
        width: '100%',
        height: 330,
        source: dataAdapter,
        showaggregates:true,
        //filtermode:'excel',
        //showfilterrow:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5.5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                    { text: 'Fleet No',datafield:'fleet_no',width:'15%'},
                    { text: 'Reg No',datafield:'reg_no',width:'15%'},
                    { text: 'Brand',datafield:'brand',width:'20%'},
                    { text: 'Model',datafield:'model',width:'20%'},
                    { text: 'Color',datafield:'color',width:'20%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });

    $( "#btnok" ).click(function() {
    	var rows = $("#vehicleSearch").jqxGrid('selectedrowindexes');
    	
    	document.getElementById("hidvehicle").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#vehicleSearch').jqxGrid('getcellvalue',rows[i],'fleet_no');
    		var docno=$('#vehicleSearch').jqxGrid('getcellvalue',rows[i],'rowno');
    		document.getElementById("vehicleremove").value+="\n"+dummy;
    		document.getElementById("vehicle").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidvehicle").value=docno;
    		}
    		else{
    			document.getElementById("hidvehicle").value+=","+docno;
    		}
    	}
    	$('#vehiclewindow').jqxWindow('close');
    	});
    
    $("#btncancel" ).click(function() {
    	$('#vehiclewindow').jqxWindow('close');
    });
});

</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btnclear" name="btnclear" class="myButton" >Cancel</button></div>
<div id="vehicleSearch"></div>
