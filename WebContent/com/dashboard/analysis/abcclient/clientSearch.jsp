<%@page import="com.dashboard.analysis.abcclient.ClsAbcClientDAO" %>
<%ClsAbcClientDAO cad=new ClsAbcClientDAO(); %>


<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var clientfilterdata;
   if(id=='1'){
	   clientfilterdata='<%=cad.getClient()%>';
	
}
else{
	clientfilterdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'cldocno',type:'number'},
                  		{name : 'refname',type:'String'},
                  		{name : 'phone',type:'string'},
                  		{name : 'mobile',type:'String'}
                  		
                  		
                  		],
				    localdata: clientfilterdata,
        
        
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
    
    
    $("#clientSearch").jqxGrid(
    {
        width: '100%',
        height: 330,
        source: dataAdapter,
        showaggregates:true,
        //filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No', filtertype:'number',datafield:'cldocno',width:'10%'},
       				{ text:'Name',filtertype:'input',columntype:'textbox',datafield:'refname',width:'56%'},
       				{ text:'Phone',filtertype:'input',columntype:'textbox',datafield:'phone',width:'15%'},
       				{ text:'Mobile',filtertype:'input',columntype:'textbox',datafield:'mobile',width:'15%'},
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });

    $( "#btnok" ).click(function() {
    	var rows = $("#clientSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Client";
        		document.getElementById("client").value="Client";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nClient";
        		document.getElementById("client").value+="\nClient";
        	}	
    	}
    	
    	
    	document.getElementById("hidclient").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#clientSearch').jqxGrid('getcellvalue',rows[i],'refname');
    		var docno=$('#clientSearch').jqxGrid('getcellvalue',rows[i],'cldocno');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("client").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidclient").value=docno;
    		}
    		else{
    			document.getElementById("hidclient").value+=","+docno;
    		}
    	}
    	$('#clientwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#clientwindow').jqxWindow('close');
    	});
});

</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="clientSearch"></div>
