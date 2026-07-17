<%@page import="com.dashboard.analysis.jobcardanalysis.*"%>
<%ClsJobCardAnalysisDAO DAO= new ClsJobCardAnalysisDAO(); %>
<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';

   var invdata2="";
   
   if(id=='3'){
	   invdata2='<%=DAO.invoiceStatusSearch()%>';
	}
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'docno',type:'number'},
                  		{name : 'status',type:'String'},
                  	],
				    localdata: invdata2,
        
        
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
    
    
    $("#invoicestatusSearch").jqxGrid(
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
       				{ text:'Status',datafield:'status',width:'75%'}
				]

    });
    
    $( "#btnok_rtype" ).click(function() {
    	var rows = $("#invoicestatusSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Invoice Status";	
        		document.getElementById("invoicestatus").value="Invoice Status";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nInvoice Status";
        		document.getElementById("invoicestatus").value+="\nInvoice Status";
        	}	
    	}
    	
    	document.getElementById("hidinvoicestatus").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#invoicestatusSearch').jqxGrid('getcellvalue',rows[i],'status');
    		var docno=$('#invoicestatusSearch').jqxGrid('getcellvalue',rows[i],'docno');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("invoicestatus").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidinvoicestatus").value=docno;
    		}
    		else{
    			document.getElementById("hidinvoicestatus").value+=","+docno;
    		}
    	}
    	$('#invoicestatusSearchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_rtype" ).click(function() {
    	$('#invoicestatusSearchWindow').jqxWindow('close');
    });
    
});
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_rtype" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_rtype" name="btncancel" class="myButton">Cancel</button></div>
<div id="invoicestatusSearch"></div>