<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var fleetdata;
   if(id=='1'){
	   fleetdata='<%=csd.getFleet()%>';
	
}
else{
	fleetdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'fleet_no',type:'String'},
                  		{name : 'reg_no',type:'String'},
                  		{name : 'flname',type:'String'},
                  		{name : 'plate',type:'String'}
                  		],
				    localdata: fleetdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
   
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                },
                loadComplete: function () {
                    $("#loadingImage").css("display", "none");
                }
		            
	            }		
    );
    
    
    $("#fleetSearch").jqxGrid(
    {
        width: '100%',
        height: 320,
        source: dataAdapter,
        showaggregates:true,
        //filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No', filtertype:'number',datafield:'doc_no',width:'10%'},
       				{ text:'Fleet No',filtertype:'input',columntype:'textbox',datafield:'fleet_no',width:'12.5%'},
       				{ text:'Fleet Name',filtertype:'input',columntype:'textbox',datafield:'flname',width:'47.5%'},
       				{ text:'Reg No',filtertype:'input',columntype:'textbox',datafield:'reg_no',width:'12.5%'},
       				{ text:'Plate Code',filtertype:'input',columntype:'textbox',datafield:'plate',width:'12.5%'}
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });

    $( "#btnok" ).click(function() {
    	var rows = $("#fleetSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Fleet";
        		document.getElementById("fleet").value="Fleet";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nFleet";
        		document.getElementById("fleet").value+="\nFleet";
        	}	
    	}
    	
    	
    	document.getElementById("hidfleet").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#fleetSearch').jqxGrid('getcellvalue',rows[i],'flname');
    		var docno=$('#fleetSearch').jqxGrid('getcellvalue',rows[i],'fleet_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("fleet").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidfleet").value=docno;
    		}
    		else{
    			document.getElementById("hidfleet").value+=","+docno;
    		}
    	}
    	$('#fleetwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#fleetwindow').jqxWindow('close');
    	});

/*     $('#fleetSearch').on('rowdoubleclick', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    document.getElementById("hidfleet").value=$('#fleetSearch').jqxGrid('getcellvalue',rowBoundIndex, "fleet_no");
    		    document.getElementById("fleet").value=$('#fleetSearch').jqxGrid('getcellvalue',rowBoundIndex, "flname");
    		    $('#fleetwindow').jqxWindow('close');
    		});
 */
 });

</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btnclearc" name="btnclear" class="myButton" >Cancel</button></div>
<div id="fleetSearch"></div>