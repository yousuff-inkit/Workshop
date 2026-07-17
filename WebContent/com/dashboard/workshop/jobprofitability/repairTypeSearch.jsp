<%@page import="com.dashboard.analysis.revenuereport.*"%>
<%ClsRevenueReportDAO DAO= new ClsRevenueReportDAO(); %>
<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';

   var data2="";
   
   if(id=='1'){
	   data2='<%=DAO.repairTypeSearch()%>';
	}
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'docno',type:'number'},
                  		{name : 'rtname',type:'String'},
                  	],
				    localdata: data2,
        
        
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
    
    
    $("#repairtypeSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        sortable:false,
        
        columns: [
       				{ text: 'Doc No',datafield:'docno',width:'20%'},
       				{ text:'Repair Type',datafield:'rtname',width:'75%'}
				]

    });
    
    $( "#btnok_rtype" ).click(function() {
    	var rows = $("#repairtypeSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Repair Type";	
        		document.getElementById("repairtype").value="Repair Type";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nRepair Type";
        		document.getElementById("repairtype").value+="\nRepair Type";
        	}	
    	}
    	
    	document.getElementById("hidrepairtype").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#repairtypeSearch').jqxGrid('getcellvalue',rows[i],'rtname');
    		var docno=$('#repairtypeSearch').jqxGrid('getcellvalue',rows[i],'docno');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("repairtype").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidrepairtype").value=docno;
    		}
    		else{
    			document.getElementById("hidrepairtype").value+=","+docno;
    		}
    	}
    	$('#repairtypeSearchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_rtype" ).click(function() {
    	$('#repairtypeSearchWindow').jqxWindow('close');
    });
    
});
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_rtype" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_rtype" name="btncancel" class="myButton">Cancel</button></div>
<div id="repairtypeSearch"></div>