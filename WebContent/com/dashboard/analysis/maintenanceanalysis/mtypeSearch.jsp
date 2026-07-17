<%@page import="com.dashboard.analysis.maintenanceanalysis.ClsmaintenanceanalysisDAO" %>
<% ClsmaintenanceanalysisDAO cmd=new ClsmaintenanceanalysisDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var mtypedata;
   if(id=='1'){
	   mtypedata='<%=cmd.getMtype()%>';
	
}
else{
	mtypedata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'docno',type:'number'},
                  		{name : 'mtype',type:'String'},
                  		{name : 'name',type:'String'},
                  		
                  		],
				    localdata: mtypedata,
        
        
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
    
    
    $("#mtypeSearch").jqxGrid(
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
               
				
       				{ text: 'Doc No', filtertype:'number',datafield:'docno',width:'10%'},
       				{ text:'Maintenance Type',filtertype:'input',columntype:'textbox',datafield:'mtype',width:'30%'},
       				{ text:'Description',filtertype:'input',columntype:'textbox',datafield:'name',width:'55%'},
       				
					]

    });

    $( "#mtypeokbtn" ).click(function() {
    	  var rows = $("#mtypeSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Maintenance Type";
        		document.getElementById("mtype").value="Maintenance Type";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nMaintenance Type";
        		document.getElementById("mtype").value+="\nMaintenance Type";
        	}	
    	}
    	
    	
 
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#mtypeSearch').jqxGrid('getcellvalue',rows[i],'mtype')+'-'+$('#mtypeSearch').jqxGrid('getcellvalue',rows[i],'name');
      		var docno=$('#mtypeSearch').jqxGrid('getcellvalue',rows[i],'docno');
    		
    	
    		
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("mtype").value+="::"+dummy;
    		if(i==0){
    			 
    			if(document.getElementById("hidmtype").value==""){
        			document.getElementById("hidmtype").value+=docno;    				
    			}
    			else{
        			document.getElementById("hidmtype").value+=","+docno;
        			
    			}
    			
    			
    			//document.getElementById("hidfleet").value=docno;
    		}
    		else{
    			document.getElementById("hidmtype").value+=","+docno;
    		}
    	}  
    	$('#mtypewindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#mtypewindow').jqxWindow('close');
    	});

 
 });

</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="mtypeokbtn" name="mtypeokbtn" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btnclearc" name="btnclear" class="myButton" >Cancel</button></div>
<div id="mtypeSearch"></div>