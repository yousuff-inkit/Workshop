<%@page import="com.dashboard.analysis.collectionanalysis.ClsCollectionAnalysis"%>
<%ClsCollectionAnalysis DAO= new ClsCollectionAnalysis(); %>
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
    
    
    $("#salesmanSearch").jqxGrid(
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
    
    $( "#btnok_salesman" ).click(function() {
    	var rows = $("#salesmanSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Salesman";	
        		document.getElementById("salesman").value="Salesman";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nSalesman";
        		document.getElementById("salesman").value+="\nSalesman";
        	}	
    	}
    	
    	document.getElementById("hidsalesman").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#salesmanSearch').jqxGrid('getcellvalue',rows[i],'clientslmname');
    		var docno=$('#salesmanSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("salesman").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidsalesman").value=docno;
    		}
    		else{
    			document.getElementById("hidsalesman").value+=","+docno;
    		}
    	}
    	$('#salesmanSearchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_salesman" ).click(function() {
    	$('#salesmanSearchWindow').jqxWindow('close');
    });
    
});
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_salesman" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_salesman" name="btncancel" class="myButton">Cancel</button></div>
<div id="salesmanSearch"></div>