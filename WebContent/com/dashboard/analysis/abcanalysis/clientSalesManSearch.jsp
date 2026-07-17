<%@page import="com.dashboard.analysis.abcanalysis.ClsAbcAnalysis"%>
<%ClsAbcAnalysis DAO= new ClsAbcAnalysis(); %>
<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';

   var data3="";
   
   if(id=='2'){
	   data3='<%=DAO.clientSalesManSearch()%>';
	}
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'doc_no',type:'number'},
                  		{name : 'clientslmname',type:'String'},
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
    
    
    $("#clientSlmSearch").jqxGrid(
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
       				{ text: 'Doc No',datafield:'doc_no',width:'20%'},
       				{ text:'Salesman Name',datafield:'clientslmname',width:'75%'}
				]

    });
    
    $( "#btnok_clientslm" ).click(function() {
    	var rows = $("#clientSlmSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Salesman";	
        		document.getElementById("clientslm").value="Salesman";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nSalesman";
        		document.getElementById("clientslm").value+="\nSalesman";
        	}	
    	}
    	
    	document.getElementById("hidclientslm").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#clientSlmSearch').jqxGrid('getcellvalue',rows[i],'clientslmname');
    		var docno=$('#clientSlmSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("clientslm").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidclientslm").value=docno;
    		}
    		else{
    			document.getElementById("hidclientslm").value+=","+docno;
    		}
    	}
    	$('#salesmanSearchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_clientslm" ).click(function() {
    	$('#salesmanSearchWindow').jqxWindow('close');
    });
    
});
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_clientslm" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_clientslm" name="btncancel" class="myButton">Cancel</button></div>
<div id="clientSlmSearch"></div>