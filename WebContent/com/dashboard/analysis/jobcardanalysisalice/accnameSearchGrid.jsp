<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.jobcardanalysisalice.*"%>
<%ClsJobCardAnalysisAliceDAO DAO= new ClsJobCardAnalysisAliceDAO(); %>
 <script type="text/javascript">
 
 var accnamedata='<%=DAO.accnameSearch()%>';
 
        $(document).ready(function () { 
         
        	$( "#btnok_accname" ).click(function() {
	        	var rows = $("#accnameSearchGrid").jqxGrid('selectedrowindexes');
        		if(rows!=""){
     	 			if(document.getElementById("searchdetails").value==""){
	           			document.getElementById("searchdetails").value="Account Name";	
	           			document.getElementById("accname").value="Account Name";
	           		}
	           		else{
	           			document.getElementById("searchdetails").value+="\n\nAccount Name";
	           			document.getElementById("accname").value+="\nAccount Name";
	           		}
        		}
        		document.getElementById("hidaccname").value="";
        	
        		for(var i=0;i<rows.length;i++){
        			var dummy=$('#accnameSearchGrid').jqxGrid('getcellvalue',rows[i],'refname');
        			var docno=$('#accnameSearchGrid').jqxGrid('getcellvalue',rows[i],'cldocno');
        			document.getElementById("searchdetails").value+="\n"+dummy;
        			document.getElementById("accname").value+="\n"+dummy;
        			if(i==0){
        				document.getElementById("hidaccname").value=docno;
        			}
        			else{
        				document.getElementById("hidaccname").value+=","+docno;
        			}
        		}
        		$('#accnamewindow').jqxWindow('close');
			});
         
         	$( "#btncancel_accname" ).click(function() {
				$('#accnamewindow').jqxWindow('close');
			});
         
         
         
         
         
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  }
                          	],
                          	localdata: accnamedata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#accnameSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',
				filterable:true,
				showfilterrow:true,
                columns: [
							{ text: 'Client Id', datafield: 'cldocno', width: '30%' },
							{ text: 'Name', datafield: 'refname', width: '70%' }
					    ]
            });
				           
}); 
                       
</script>
<div style="text-align:center;">
	<button type="button" id="btnok_accname" name="btnok" class="myButton">OK</button>
	<button type="button" id="btncancel_accname" name="btncancel" class="myButton" >Cancel</button>
</div>
<div id="accnameSearchGrid"></div>
    
</body>
</html>