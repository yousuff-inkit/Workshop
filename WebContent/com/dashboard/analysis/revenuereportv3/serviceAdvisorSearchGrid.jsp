<%@page import="com.dashboard.analysis.revenuereportv3.*"%>
<%ClsRevenueReportV3DAO DAO= new ClsRevenueReportV3DAO(); %>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");%>
<script type="text/javascript">
$(document).ready(function () {
   var id='<%=id%>';
   var srvcadvisordata=[];
   if(id=='1'){
	   srvcadvisordata='<%=DAO.getServiceAdvisorData(id)%>';
	}
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'doc_no',type:'number'},
                  		{name : 'sal_code',type:'String'},
                  		{name : 'sal_name',type:'String'}
                  	],
				    localdata: srvcadvisordata,
        
        
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
    
    
    $("#serviceAdvisorSearchGrid").jqxGrid(
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
       				{ text: 'Doc No',datafield:'docno',width:'20%',hidden:true},
       				{ text: 'Code',datafield:'sal_code',width:'20%'},
       				{ text: 'Name',datafield:'sal_name',width:'75%'}
				]

    });
    
    $( "#btnok_wsa" ).click(function() {
    	var rows = $("#serviceAdvisorSearchGrid").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Service Advisor";	
        		document.getElementById("serviceadvisor").value="Service Advisor";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nService Advisor";
        		document.getElementById("serviceadvisor").value+="\nService Advisor";
        	}	
    	}
    	
    	document.getElementById("hidserviceadvisor").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#serviceAdvisorSearchGrid').jqxGrid('getcellvalue',rows[i],'sal_name');
    		var docno=$('#serviceAdvisorSearchGrid').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("serviceadvisor").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidserviceadvisor").value=docno;
    		}
    		else{
    			document.getElementById("hidserviceadvisor").value+=","+docno;
    		}
    	}
    	$('#serviceAdvisorSearchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_wsa" ).click(function() {
    	$('#serviceAdvisorSearchWindow').jqxWindow('close');
    });
    
});
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_wsa" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_wsa" name="btncancel" class="myButton">Cancel</button></div>
<div id="serviceAdvisorSearchGrid"></div>