<%@ page import="com.dashboard.rentalagreement.salesagentreport.ClssalesagentReportDAO"


 %>
 <%
 ClssalesagentReportDAO DAO=new ClssalesagentReportDAO();
 %>
<script type="text/javascript">
 
$(document).ready(function () {  
 
	   var   sadata='<%=DAO.getsalesagent()%>';
	
 
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'sal_name',type:'String'},
                  		
                  		
                  		],
				    localdata: sadata,
        
        
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
    
    
    $("#sasersch").jqxGrid(
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
               
				
       				{ text: 'Doc No', filtertype:'number',datafield:'doc_no',width:'20%'},
       				{ text:'Name',filtertype:'input',columntype:'textbox',datafield:'sal_name',width:'72%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });

    $("#btnok1").click(function() {
    	var rows = $("#sasersch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Name";
        		document.getElementById("sag").value="Name";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nName";
        		document.getElementById("sag").value+="\nName";
        	}	
    	}
    	
    	
    	//document.getElementById("hidbrand").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#sasersch').jqxGrid('getcellvalue',rows[i],'sal_name');
    		var docno=$('#sasersch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("sag").value+="::"+dummy;
    		
    		
    		if(i==0){
    			
    			
    			if(document.getElementById("hidsag").value==""){
        			document.getElementById("hidsag").value+=docno;    				
    			}
    			else{
        			document.getElementById("hidsag").value+=","+docno;
        			
    			}

    		}
    		else{
    			document.getElementById("hidsag").value+=","+docno;
    		}
    	}
    	$('#agentWindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#agentWindow').jqxWindow('close');
    	});
});

</script>
<body bgcolor="#E0ECF8">
<table bgcolor="#E0ECF8" width="100%" >
<tr>
<td>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok1" name="btnok1" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btnclearc" name="btnclear" class="myButton" >Cancel</button></div>
</td>
</tr> 
<tr>
<td>
<div id="sasersch"></div>

</td>
</tr>

</table>
</body>
