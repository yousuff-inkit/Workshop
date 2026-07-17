<%@page import="com.dashboard.analysis.collectionanalysis.ClsCollectionAnalysis"%>
<%ClsCollectionAnalysis DAO= new ClsCollectionAnalysis(); %>
<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';

   var data2="";
   
   if(id=='1'){
	   data2='<%=DAO.clientCategorySearch()%>';
	}
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'doc_no',type:'number'},
                  		{name : 'clientcatname',type:'String'},
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
    
    
    $("#clientCatSearch").jqxGrid(
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
       				{ text:'Category Name',datafield:'clientcatname',width:'75%'}
				]

    });
    
    $( "#btnok_clientcat" ).click(function() {
    	var rows = $("#clientCatSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Client Category";	
        		document.getElementById("clientcat").value="Client Category";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nClient Category";
        		document.getElementById("clientcat").value+="\nClient Category";
        	}	
    	}
    	
    	document.getElementById("hidclientcat").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#clientCatSearch').jqxGrid('getcellvalue',rows[i],'clientcatname');
    		var docno=$('#clientCatSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("clientcat").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidclientcat").value=docno;
    		}
    		else{
    			document.getElementById("hidclientcat").value+=","+docno;
    		}
    	}
    	$('#clientCategorySearchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_clientcat" ).click(function() {
    	$('#clientCategorySearchWindow').jqxWindow('close');
    });
    
});
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_clientcat" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_clientcat" name="btncancel" class="myButton" >Cancel</button></div>
<div id="clientCatSearch"></div>