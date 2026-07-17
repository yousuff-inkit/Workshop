<%@page import="com.dashboard.analysis.abcanalysis.ClsAbcAnalysis"%>
<%ClsAbcAnalysis DAO= new ClsAbcAnalysis(); %>
<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';

   var data3="";
   
   if(id=='3'){
	   data3='<%=DAO.clientStatusSearch()%>';
	}
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'pcase',type:'number'},
                  		{name : 'status',type:'String'},
                  	],
				    localdata: data3,
        
        
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
    
    
    $("#clientStatSearch").jqxGrid(
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
       				{ text: 'Doc No',datafield:'pcase',width:'20%'},
       				{ text:'Status',datafield:'status',width:'75%'}
				]

    });
    
    $( "#btnok_clientstat" ).click(function() {
    	var rows = $("#clientStatSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Client Status";	
        		document.getElementById("clientstatus").value="Client Status";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nClient Status";
        		document.getElementById("clientstatus").value+="\nClient Status";
        	}	
    	}
    	
    	document.getElementById("hidclientstatus").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#clientStatSearch').jqxGrid('getcellvalue',rows[i],'status');
    		var docno=$('#clientStatSearch').jqxGrid('getcellvalue',rows[i],'pcase');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("clientstatus").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidclientstatus").value=docno;
    		}
    		else{
    			document.getElementById("hidclientstatus").value+=","+docno;
    		}
    	}
    	$('#clientStatusSearchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_clientstat" ).click(function() {
    	$('#clientStatusSearchWindow').jqxWindow('close');
    });
    
});
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_clientstat" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_clientstat" name="btncancel" class="myButton" >Cancel</button></div>
<div id="clientStatSearch"></div>