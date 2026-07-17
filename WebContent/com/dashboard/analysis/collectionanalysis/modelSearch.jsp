<%@page import="com.dashboard.analysis.collectionanalysis.ClsCollectionAnalysis"%>
<%ClsCollectionAnalysis DAO= new ClsCollectionAnalysis(); %>
<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var modeldata="";
   
   if(id=='1'){
	   modeldata='<%=DAO.modelSearch()%>';
	}
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'doc_no',type:'number'},
         				{name : 'model',type:'String'}         		
                  	],
				    localdata: modeldata,
        
        
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
    
    
    $("#modelSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        //filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No', filtertype:'number',datafield:'doc_no',width:'20%'},
  
       				{ text:'Model',filtertype:'input',columntype:'textbox',datafield:'model',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
      
    $( "#btnok_model" ).click(function() {
    	var rows = $("#modelSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Model";	
        		document.getElementById("model").value="Model";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nModel";
        		document.getElementById("model").value="\nModel";
        	}	
    	}
    	
    	
    	document.getElementById("hidmodel").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#modelSearch').jqxGrid('getcellvalue',rows[i],'model');
    		var docno=$('#modelSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("model").value+="\n"+dummy;
    		
    		if(i==0){
    			document.getElementById("hidmodel").value=docno;
    		}
    		else{
    			document.getElementById("hidmodel").value+=","+docno;
    		}
    	}
    	$('#modelSearchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_model" ).click(function() {
    	$('#modelSearchWindow').jqxWindow('close');
    	});
    
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_model" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_model" name="btncancel" class="myButton" >Cancel</button></div>
<div id="modelSearch"></div>