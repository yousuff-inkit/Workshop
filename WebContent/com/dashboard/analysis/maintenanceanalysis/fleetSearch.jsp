<%@page import="com.dashboard.analysis.maintenanceanalysis.ClsmaintenanceanalysisDAO" %>
<% ClsmaintenanceanalysisDAO cmd=new ClsmaintenanceanalysisDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var fleetdata;
   if(id=='1'){
	   fleetdata='<%=cmd.getFleet()%>';
	
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
        height: 340,
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
       				{ text:'Plate Code',filtertype:'input',columntype:'textbox',datafield:'plate',width:'13%'}
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });

    $( "#fleetokbtn" ).click(function() {
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
    	
    	
 
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#fleetSearch').jqxGrid('getcellvalue',rows[i],'flname');
      		var docno=$('#fleetSearch').jqxGrid('getcellvalue',rows[i],'fleet_no');
    		
    	
    		
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("fleet").value+="::"+dummy;
    		if(i==0){
    			 
    			if(document.getElementById("hidfleet").value==""){
        			document.getElementById("hidfleet").value+=docno;    				
    			}
    			else{
        			document.getElementById("hidfleet").value+=","+docno;
        			
    			}
    			
    			
    			//document.getElementById("hidfleet").value=docno;
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

 
 });

</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="fleetokbtn" name="fleetokbtn" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btnclearc" name="btnclear" class="myButton" >Cancel</button></div>
<div id="fleetSearch"></div>